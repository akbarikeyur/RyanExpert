//
//  EmailSignupVC.swift
//  RyanExpert
//
//  Created by Keyur Akbari on 04/08/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class EmailSignupVC: UIViewController {

    @IBOutlet weak var emailTxt: TextField!
    @IBOutlet weak var passwordTxt: TextField!
    @IBOutlet weak var confirmPasswordTxt: TextField!
    @IBOutlet var verifyView: UIView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loader.transform = CGAffineTransform.init(scaleX: 2.5, y: 2.5)
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToVerify(_ sender: Any) {
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
            loader.startAnimating()
            displaySubViewtoParentView(self.view, subview: verifyView)
            displaySubViewWithScaleOutAnim(verifyView)
            var param = [String : Any]()
            param["email"] = emailTxt.text
            param["password"] = passwordTxt.text
            param["device_id"] = DEVICE_ID
            param["device_type"] = "I"
            param["expertType"] = USER_TYPE
            APIManager.shared.serviceCallToSignupEmail(param) { (status) in
                self.loader.stopAnimating()
                displaySubViewWithScaleInAnim(self.verifyView)
                if status == 1 {
                    let vc : AddPersonalDetailVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "AddPersonalDetailVC") as! AddPersonalDetailVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
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
