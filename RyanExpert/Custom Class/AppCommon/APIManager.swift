//
//  APIManager.swift
//  Knocc
//
//  Created by PC on 16/08/19.
//  Copyright © 2019 PC. All rights reserved.
//

import Foundation
import SystemConfiguration
import Alamofire


struct API {
    static let BASE_URL = "https://ryan.commencement.website/api/v1/"
    
    static let LOGIN_MOBILE                         =       BASE_URL + "auth/loginMobile"
    static let OTP_VERIFY                           =       BASE_URL + "auth/verifyOtp"
    static let SIGNUP_EMAIL                         =       BASE_URL + "auth/signupEmail"
    static let LOGIN_EMAIL                          =       BASE_URL + "auth/loginEmail"
    static let COMPLETE_PROFILE                     =       BASE_URL + "completeProfile"
    
    //Profile
    static let GET_PROFILE                          =       BASE_URL + "profile"
    static let UPLOAD_IMAGE                         =       BASE_URL + "profile/image"
    static let UPDATE_ONLINE_STATUS                 =       BASE_URL + "profile/image"
    
    //Session
    static let GET_SESSION                          =       BASE_URL + "sessions"
    
    //Notification
    static let NOTIFICATION                         =       BASE_URL + "notifications"
    
    //Bank
    static let GET_PAYMENT_DETAIL                   =       BASE_URL + "profile/paymentDetails"
    static let ADD_MPESA_ACCOUNT                    =       BASE_URL + "profile​/paymentDetails/mpesa"
    static let ADD_BANK_ACCOUNT                     =       BASE_URL + "profile/paymentDetails/bank"
    
    //Default
    static let GET_CMS_DATA                         =       BASE_URL + "cms"
    static let CONTACT_ADMIN                        =       BASE_URL + "/contact"
}



public class APIManager {
    
    static let shared = APIManager()
    
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    func getJsonHeader() -> HTTPHeaders {
        if isUserLogin() {
            return ["Content-Type":"application/json", "Accept":"application/json", "AUTHORIZATION": ("Bearer " + getAuthToken())]
        }else{
            return ["Content-Type":"application/json", "Accept":"application/json"]
        }
        
    }
    
    func getMultipartHeader() -> [String:String]{
        if isUserLogin() {
            return ["Content-Type":"multipart/form-data", "Accept":"application/json", "AUTHORIZATION":("Bearer " + getAuthToken())]
        }else{
            return ["Content-Type":"multipart/form-data", "Accept":"application/json"]
        }
    }
    
    
    func networkErrorMsg()
    {
        removeLoader()
        showAlert("Ryan", message: "no_network") {
            
        }
    }
    
    func toJson(_ dict:[String:Any]) -> String {
        let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
        let jsonString = String(data: jsonData!, encoding: .utf8)
        return jsonString!
    }
    
    func handleError(_ dict : [String : Any])
    {
        if let status = dict["status"] as? Int, status == 0 {
            if let message = dict["message"] as? String {
                displayToast(message)
            }
        }
    }
    
    //MARK:- Login
    func serviceCallToLoginMobile(_ param : [String  :Any],  _ completion: @escaping () -> Void) {
        callPostRequest(API.LOGIN_MOBILE, param, true) { (dict) in
            printData(dict)
            if let status = dict["status"] as? Int, status == 1 {
                completion()
                return
            }
            else{
                self.handleError(dict)
            }
        }
    }
    
    func serviceCallToVerifyOtp(_ param : [String  :Any],  _ completion: @escaping () -> Void) {
        callPostRequest(API.OTP_VERIFY, param, true) { (dict) in
            printData(dict)
            if let status = dict["status"] as? Int, status == 1 {
                if let token = dict["token"] as? String, token != "" {
                    setAuthToken(token)
                    if let user = dict["user"] as? [String : Any] {
                        AppModel.shared.currentUser = UserModel.init(dict: user)
                        setLoginUserData()
                        completion()
                        return
                    }
                }
            }
            else{
                self.handleError(dict)
            }
        }
    }
    
    func serviceCallToLoginEmail(_ param : [String  :Any],  _ completion: @escaping () -> Void) {
        callPostRequest(API.LOGIN_EMAIL, param, true) { (dict) in
            printData(dict)
            if let status = dict["status"] as? Int, status == 1 {
                if let token = dict["token"] as? String, token != "" {
                    setAuthToken(token)
                    if let user = dict["user"] as? [String : Any] {
                        AppModel.shared.currentUser = UserModel.init(dict: user)
                        setLoginUserData()
                        completion()
                        return
                    }
                }
            }
            else{
                self.handleError(dict)
            }
        }
    }
    
    func serviceCallToSignupEmail(_ param : [String  :Any],  _ completion: @escaping (_ status : Int) -> Void) {
        callPostRequest(API.SIGNUP_EMAIL, param, false) { (dict) in
            printData(dict)
            if let status = dict["status"] as? Int, status == 1 {
                if let token = dict["token"] as? String, token != "" {
                    setAuthToken(token)
                    if let user = dict["user"] as? [String : Any] {
                        AppModel.shared.currentUser = UserModel.init(dict: user)
                        setLoginUserData()
                        completion(1)
                        return
                    }
                }
            }
            else{
                self.handleError(dict)
                completion(0)
                return
            }
        }
    }
    
    func serviceCallToCompleteProfile(_ param : [String  :Any],  _ completion: @escaping () -> Void) {
        callPostRequest(API.COMPLETE_PROFILE, param, true) { (dict) in
            printData(dict)
            if let status = dict["status"] as? Int, status == 1 {
                if let user = dict["user"] as? [String : Any] {
                    AppModel.shared.currentUser = UserModel.init(dict: user)
                    setLoginUserData()
                    completion()
                    return
                }
            }
            else{
                self.handleError(dict)
            }
        }
    }
    
    //MARK:- Session
    func serviceCallToGetSession(_ start : Int, _ completion: @escaping (_ data : [[String : Any]], _ is_last : Bool) -> Void) {
        let strUrl = API.GET_SESSION + "?start=" + String(start) + "&limit=" + String(CONSTANT.LIMIT_DATA)
        callGetRequest(strUrl, false) { (dict) in
            printData(dict)
            if let status = dict["status"] as? Int, status == 1 {
                if let is_last = dict["is_last"] as? Bool {
                    if let data = dict["sessions"] as? [[String : Any]] {
                        completion(data, is_last)
                    }
                }
            }
        }
    }
    
    //MARK:- Profile
    func serviceCallToGetProfile() {
        callGetRequest(API.GET_PROFILE, false) { (dict) in
            printData(dict)
            if let status = dict["status"] as? Int, status == 1 {
                if let user = dict["user"] as? [String : Any] {
                    AppModel.shared.currentUser = UserModel.init(dict: user)
                    setLoginUserData()
                    NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.UPDATE_CURRENT_USER_DATA), object: nil)
                }
            }
        }
    }
    
    func serviceCallToUpdateProfile(_ param : [String : Any], _ completion: @escaping () -> Void) {
        callPostRequest(API.GET_PROFILE, param, true) { (dict) in
            printData(dict)
            if let status = dict["status"] as? Int, status == 1 {
                if let user = dict["user"] as? [String : Any] {
                    AppModel.shared.currentUser = UserModel.init(dict: user)
                    setLoginUserData()
                    NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.UPDATE_CURRENT_USER_DATA), object: nil)
                    completion()
                    return
                }
            }
        }
    }
    
    func serviceCallToUpdateProfileImage(_ param : [String : Any], _ completion: @escaping () -> Void) {
        callPostRequest(API.UPLOAD_IMAGE, param, true) { (dict) in
            printData(dict)
            if let status = dict["status"] as? Int, status == 1 {
                completion()
                return
            }
        }
    }
    
    func serviceCallToUpdateOnlineStatus(_ param : [String : Any], _ completion: @escaping () -> Void) {
        callPostRequest(API.UPDATE_ONLINE_STATUS, param, false) { (dict) in
            printData(dict)
            if let status = dict["status"] as? Int, status == 1 {
                completion()
                return
            }
        }
    }
    
    //MARK:- Notification
    func serviceCallToGetNotification(_ start : Int, _ completion: @escaping (_ data : [[String : Any]], _ is_last : Bool) -> Void) {
        let strUrl = API.NOTIFICATION + "?start=" + String(start) + "&limit=" + String(CONSTANT.LIMIT_DATA)
        callGetRequest(strUrl, true) { (dict) in
            printData(dict)
            if let status = dict["status"] as? Int, status == 1 {
                if let is_last = dict["is_last"] as? Bool {
                    if let data = dict["sessions"] as? [[String : Any]] {
                        completion(data, is_last)
                    }
                }
            }
        }
    }
    
    func serviceCallToPauseNotification(_ enabled : Bool, _ completion: @escaping () -> Void) {
        callPostRequest(API.NOTIFICATION, ["enabled" : enabled], false) { (dict) in
            printData(dict)
            if let status = dict["status"] as? Int, status == 1 {
                completion()
                return
            }
        }
    }
    
    //MARK:- Payment
    func serviceCallToGetPaymentDetails(_ completion: @escaping (_ dict : [String : Any]) -> Void) {
        callGetRequest(API.GET_PAYMENT_DETAIL, false) { (dict) in
            printData(dict)
            if let status = dict["status"] as? Int, status == 1 {
                if let bankDict = dict["bankdetails"] as? [String : Any] {
                    completion(bankDict)
                    return
                }
            }
        }
    }
    
    func serviceCallToAddBank(_ param : [String  :Any],  _ completion: @escaping () -> Void) {
        callPostRequest(API.ADD_BANK_ACCOUNT, param, true) { (dict) in
            printData(dict)
            if let status = dict["status"] as? Int, status == 1 {
                completion()
                return
            }
        }
    }
    
    //MARK:- Contact Admin
    func serviceCallToContactUs(_ param : [String  :Any],  _ completion: @escaping () -> Void) {
        callPostRequest(API.CONTACT_ADMIN, param, true) { (dict) in
            printData(dict)
            if let status = dict["status"] as? Int, status == 1 {
                completion()
                return
            }
        }
    }
    
    //MARK:- Get Cms Data
    func serviceCallToGetCmsData() {
        callGetRequest(API.GET_CMS_DATA, false) { (dict) in
            printData(dict)
            if let temp = dict["about"] as? String, temp != "" {
                ABOUT_URL = temp
            }
            if let temp = dict["faq"] as? String, temp != "" {
                FAQ_URL = temp
            }
            if let temp = dict["termsAndConditions"] as? String, temp != "" {
                TERMS_URL = temp
            }
            if let temp = dict["privacyPolicy"] as? String, temp != "" {
                POLICY_URL = temp
            }
        }
    }
    
    //MARK:- Get request
    func callGetRequest(_ api : String, _ isLoaderDisplay : Bool, _ completion: @escaping (_ result : [String:Any]) -> Void) {
        if !APIManager.isConnectedToNetwork()
        {
            APIManager().networkErrorMsg()
            return
        }
        if isLoaderDisplay {
            showLoader()
        }
        
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: getJsonHeader()).responseJSON { (response) in
            removeLoader()
            switch response.result {
            case .success:
                if let result = response.result.value as? [String:Any] {
                    completion(result)
                    return
                }
                if let error = response.result.error
                {
                    displayToast(error.localizedDescription)
                    return
                }
                break
            case .failure(let error):
                printData(error)
                break
            }
        }
    }
    
    //MARK:- Post request
    func callPostRequest(_ api : String, _ params : [String : Any], _ isLoaderDisplay : Bool, _ completion: @escaping (_ result : [String:Any]) -> Void) {
        if !APIManager.isConnectedToNetwork()
        {
            APIManager().networkErrorMsg()
            return
        }
        if isLoaderDisplay {
            showLoader()
        }
        Alamofire.request(api, method: .post, parameters: params, encoding: JSONEncoding.default, headers: getJsonHeader()).responseJSON { (response) in
            removeLoader()
            switch response.result {
            case .success:
                if let result = response.result.value as? [String:Any] {
                    completion(result)
                    return
                }
                if let error = response.result.error
                {
                    displayToast(error.localizedDescription)
                    return
                }
                break
            case .failure(let error):
                printData(error)
                break
            }
        }
    }
    
    //MARK:- Multipart request
    func callMultipartRequest(_ api : String, _ params : [String : Any], _ isLoaderDisplay : Bool, _ completion: @escaping (_ result : [String:Any]) -> Void) {
        if !APIManager.isConnectedToNetwork()
        {
            APIManager().networkErrorMsg()
            return
        }
        if isLoaderDisplay {
            showLoader()
        }
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in params {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
        }, usingThreshold: UInt64.init(), to: api, method: .post, headers: getJsonHeader()) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (Progress) in
                    printData("Upload Progress: \(Progress.fractionCompleted)")
                })
                upload.responseJSON { response in
                    removeLoader()
                    if let result = response.result.value as? [String:Any] {
                        completion(result)
                        return
                    }
                    else if let error = response.error{
                        displayToast(error.localizedDescription)
                        return
                    }
                }
            case .failure(let error):
                removeLoader()
                printData(error.localizedDescription)
                break
            }
        }
    }
    
    func callMultipartRequestWithImage(_ api : String, _ params : [String : Any], _ arrImg : [UIImage], _ isLoaderDisplay : Bool, _ completion: @escaping (_ result : [String:Any]) -> Void) {
        if !APIManager.isConnectedToNetwork()
        {
            APIManager().networkErrorMsg()
            return
        }
        if isLoaderDisplay {
            showLoader()
        }
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in params {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            for temp in arrImg {
                if let imageData = temp.jpegData(compressionQuality: 1.0) {
                    multipartFormData.append(imageData, withName: "myfile", fileName: "myfile.jpg", mimeType: "image/jpg")
                }
            }
        }, usingThreshold: UInt64.init(), to: api, method: .post, headers: getMultipartHeader()) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (Progress) in
                    printData("Upload Progress: \(Progress.fractionCompleted)")
                })
                upload.responseJSON { response in
                    removeLoader()
                    if let result = response.result.value as? [String:Any] {
                        completion(result)
                        return
                    }
                    else if let error = response.error{
                        displayToast(error.localizedDescription)
                        return
                    }
                }
            case .failure(let error):
                removeLoader()
                printData(error.localizedDescription)
                break
            }
        }
    }
    
}
