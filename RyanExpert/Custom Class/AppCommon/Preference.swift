//
//  Preference.swift
//  Cozy Up
//
//  Created by Keyur on 15/10/18.
//  Copyright © 2018 Keyur. All rights reserved.
//

import UIKit

class Preference: NSObject {

    static let sharedInstance = Preference()
    
    let IS_USER_LOGIN_KEY       =   "IS_USER_LOGIN"
    let USER_DATA_KEY           =   "USER_DATA"
    let MUSIC_DATA_KEY          =   "MUSIC_DATA_KEY"
}


func setDataToPreference(data: AnyObject, forKey key: String)
{
    UserDefaults.standard.set(data, forKey: MD5(key))
    UserDefaults.standard.synchronize()
}

func getDataFromPreference(key: String) -> AnyObject?
{
    return UserDefaults.standard.object(forKey: MD5(key)) as AnyObject?
}

func removeDataFromPreference(key: String)
{
    UserDefaults.standard.removeObject(forKey: key)
    UserDefaults.standard.synchronize()
}

func removeUserDefaultValues()
{
    UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    UserDefaults.standard.synchronize()
}

//MARK: - Access Token
func setAuthToken(_ token: String)
{
    setDataToPreference(data: token as AnyObject, forKey: "user_access_token")
}

func getAuthToken() -> String
{
    if let token : String = getDataFromPreference(key: "user_access_token") as? String
    {
        return token
    }
    return ""
}

//MARK: - Push notification Token
func setLoginUserData()
{
    if AppModel.shared.currentUser != nil {
        setDataToPreference(data: AppModel.shared.currentUser.dictionary() as AnyObject, forKey: "login_user_data")
        setIsUserLogin(true)
    }
}

func getLoginUserData() -> UserModel
{
    if let dict : [String : Any] = getDataFromPreference(key: "login_user_data") as? [String : Any]
    {
        return UserModel.init(dict: dict)
    }
    return UserModel.init(dict: [String : Any]())
}

func setIsUserLogin(_ value: Bool)
{
    setDataToPreference(data: value as AnyObject, forKey: "is_user_login")
}

func isUserLogin() -> Bool
{
    if let value : Bool = getDataFromPreference(key: "is_user_login") as? Bool
    {
        return value
    }
    return false
}


func setNotFirstTime(_ value: Bool)
{
    setDataToPreference(data: value as AnyObject, forKey: "is_first_time")
}

func isNotFirstTime() -> Bool
{
    if let value : Bool = getDataFromPreference(key: "is_first_time") as? Bool
    {
        return value
    }
    return false
}

func setBankDetail(_ dict: [String : Any])
{
    setDataToPreference(data: dict as AnyObject, forKey: "bank_details")
}

func getBankDetail() -> [String : Any]
{
    if let dict : [String : Any] = getDataFromPreference(key: "bank_details") as? [String : Any]
    {
        return dict
    }
    return [String : Any]()
}
