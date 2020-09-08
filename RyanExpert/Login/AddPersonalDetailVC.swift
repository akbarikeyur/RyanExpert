//
//  AddPersonalDetailVC.swift
//  RyanExpert
//
//  Created by Keyur Akbari on 04/08/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit
import MobileCoreServices

class AddPersonalDetailVC: UIViewController {

    @IBOutlet weak var nameTxt: TextField!
    @IBOutlet weak var locationTxt: TextField!
    @IBOutlet var successView: UIView!
    @IBOutlet weak var certificateTxt: TextField!
    @IBOutlet weak var awardTxt: TextField!
    
    var fileType = 0
    var certificateUrl : URL?
    var awardUrl : URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameTxt.text = AppModel.shared.currentUser.fullName
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().hideTabBar()
    }
    
    @IBAction func clickToUploadCertificate(_ sender: UIButton) {
        self.view.endEditing(true)
        fileType = 1
        uploadFile()
    }
    
    @IBAction func clickToUploadAward(_ sender: UIButton) {
        self.view.endEditing(true)
        fileType = 2
        uploadFile()
    }
    
    @IBAction func clickToNext(_ sender: Any) {
        self.view.endEditing(true)
        if nameTxt.text?.trimmed == "" {
            displayToast("enter_name")
        }
        else if locationTxt.text?.trimmed == "" {
            displayToast("enter_location")
        }
//        else if certificateUrl == nil {
//            displayToast("select_certificate")
//        }
//        else if awardUrl == nil {
//            displayToast("select_award")
//        }
        else {
            var param = [String : Any]()
            param["fullname"] = nameTxt.text
            param["location"] = locationTxt.text
            param["certificationDocuments"] = ""
            param["awards"] = ""
            do {
                if certificateUrl != nil {
                    if let fileData = try Data(contentsOf: certificateUrl!) as? Data {
                        if let strBase64 = fileData.base64EncodedString(options: .lineLength64Characters) as? String {
                            param["certificationDocuments"] = strBase64
                        }
                    }
                }
                if awardUrl != nil {
                    if let fileData = try Data(contentsOf: awardUrl!) as? Data {
                        if let strBase64 = fileData.base64EncodedString(options: .lineLength64Characters) as? String {
                            param["awards"] = strBase64
                        }
                    }
                }
            }
            catch {}
            
            APIManager.shared.serviceCallToCompleteProfile(param) {
                displaySubViewtoParentView(self.view, subview: self.successView)
                displaySubViewWithScaleOutAnim(self.successView)
            }
        }
    }
    
    @IBAction func clickToDashboard(_ sender: Any) {
        displaySubViewWithScaleInAnim(successView)
        AppDelegate().sharedDelegate().navigateToDashBoard()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddPersonalDetailVC: UIDocumentPickerDelegate {
    
    func uploadFile() {
        let types = [kUTTypePDF, kUTTypeText, kUTTypeRTF, kUTTypeSpreadsheet]
        let importMenu = UIDocumentPickerViewController(documentTypes: types as [String], in: .import)

        if #available(iOS 11.0, *) {
            importMenu.allowsMultipleSelection = true
        }

        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet

        present(importMenu, animated: true)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(urls)
        let name = urls.first!.absoluteString.components(separatedBy: "/").last
        if fileType == 1 {
            certificateTxt.text = name
            certificateUrl = urls.first
        }
        else if fileType == 2 {
            awardTxt.text = name
            awardUrl = urls.first
        }
    }

     func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
