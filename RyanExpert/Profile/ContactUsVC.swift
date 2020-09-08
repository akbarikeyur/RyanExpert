//
//  ContactUsVC.swift
//  RyanExpert
//
//  Created by Keyur Akbari on 12/08/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class ContactUsVC: UIViewController {

    @IBOutlet weak var subjectTxt: TextField!
    @IBOutlet weak var messageTxt: TextView!
    @IBOutlet weak var successView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        successView.isHidden = true
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToSubmit(_ sender: Any) {
        self.view.endEditing(true)
        if subjectTxt.text == "" {
            displayToast("Please enter subject")
        }
        else if messageTxt.text == "" {
            displayToast("Please enter your message")
        }
        else{
            var param = [String : Any]()
            param["subject"] = subjectTxt.text
            param["message"] = messageTxt.text
            APIManager.shared.serviceCallToContactUs(param) {
                self.successView.isHidden = false
            }
        }
    }
    
    @IBAction func clickToHome(_ sender: Any) {
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
