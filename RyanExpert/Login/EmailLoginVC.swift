//
//  EmailLoginVC.swift
//  RyanExpert
//
//  Created by Keyur Akbari on 21/08/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class EmailLoginVC: UIViewController {

    @IBOutlet weak var emailTxt: TextField!
    @IBOutlet weak var passwordTxt: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToLogin(_ sender: Any) {
        self.view.endEditing(true)
        if emailTxt.text?.trimmed == "" {
            displayToast("enter_email")
        }
        else if !emailTxt.text!.isValidEmail {
            displayToast("invalid_email")
        }
        else if passwordTxt.text?.trimmed == "" {
            displayToast("enter_password")
        }
        else {
            var param = [String : Any]()
            param["email"] = emailTxt.text
            param["password"] = passwordTxt.text
            param["device_id"] = DEVICE_ID
            param["device_type"] = "I"
            APIManager.shared.serviceCallToLoginEmail(param) {
                AppDelegate().sharedDelegate().serviceCallToUpdateFcmToken()
                AppDelegate().sharedDelegate().navigateToDashBoard()
            }
        }
    }
    
    @IBAction func clickToSignup(_ sender: Any) {
        let vc : EmailSignupVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "EmailSignupVC") as! EmailSignupVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToMobileLogin(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
