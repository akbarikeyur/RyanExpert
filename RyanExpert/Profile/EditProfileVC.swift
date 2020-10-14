//
//  EditProfileVC.swift
//  RyanExpert
//
//  Created by Keyur Akbari on 04/09/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class EditProfileVC: UploadImageVC {

    @IBOutlet weak var profilePicImg: ImageView!
    @IBOutlet weak var nameTxt: TextField!
    @IBOutlet weak var emailTxt: TextField!
    @IBOutlet weak var mobNoTxt: TextField!
    @IBOutlet weak var specialityTxt: TextField!
    @IBOutlet weak var locationTxt: TextField!
    @IBOutlet weak var articlesTxtView: TextView!
    @IBOutlet weak var confTxt: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().hideTabBar()
    }
    
    func setupDetails() {
        nameTxt.text = AppModel.shared.currentUser.fullName
        emailTxt.text = AppModel.shared.currentUser.email
        mobNoTxt.text = AppModel.shared.currentUser.mobileNumber
        specialityTxt.text = AppModel.shared.currentUser.speciality
        locationTxt.text = AppModel.shared.currentUser.location
        for temp in AppModel.shared.currentUser.publishedArticles {
            if articlesTxtView.text != "" {
                articlesTxtView.text = (articlesTxtView.text ?? "") + "\n"
            }
            articlesTxtView.text = (articlesTxtView.text ?? "") + temp
        }
        for temp in AppModel.shared.currentUser.Conferences {
            if confTxt.text != "" {
                confTxt.text = (confTxt.text ?? "") + "\n"
            }
            confTxt.text = (confTxt.text ?? "") + temp
        }
        
        emailTxt.isUserInteractionEnabled = (emailTxt.text?.trimmed == "")
        mobNoTxt.isUserInteractionEnabled = (mobNoTxt.text?.trimmed == "")
        
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToUploadImage(_ sender: Any) {
        uploadImage()
    }
    
    override func selectedImage(choosenImage: UIImage) {
        profilePicImg.image = choosenImage
        if let imageData = choosenImage.jpegData(compressionQuality: 1.0) {
            if let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters) as? String {
                var param = [String : Any]()
                param["image"] = strBase64
                APIManager.shared.serviceCallToUpdateProfileImage(param) {
                    
                }
            }
        }
    }
    
    @IBAction func clickToUpdateProfile(_ sender: Any) {
        self.view.endEditing(true)
        if nameTxt.text?.trimmed == "" {
            displayToast("enter_name")
        }
        else if emailTxt.text?.trimmed == "" {
            displayToast("enter_email")
        }
        else if mobNoTxt.text?.trimmed == "" {
            displayToast("enter_mobile")
        }
        else if specialityTxt.text?.trimmed == "" {
            displayToast("enter_speciality")
        }
        else if locationTxt.text?.trimmed == "" {
            displayToast("enter_location")
        }
        else{
            var param = [String : Any]()
            param["fullname"] = nameTxt.text
            param["email"] = emailTxt.text
            param["mobileNumber"] = mobNoTxt.text
            param["speciality"] = specialityTxt.text
            param["location"] = locationTxt.text
            param["publishedArticles"] = articlesTxtView.text
            param["conferences"] = confTxt.text
            APIManager.shared.serviceCallToUpdateProfile(param) {
                self.navigationController?.popViewController(animated: true)
            }
        }
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
