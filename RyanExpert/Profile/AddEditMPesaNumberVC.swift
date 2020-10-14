//
//  AddEditMPesaNumberVC.swift
//  RyanExpert
//
//  Created by Keyur on 09/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class AddEditMPesaNumberVC: UIViewController {

    @IBOutlet weak var mpesaNumberTxt: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToSaveDetails(_ sender: Any) {
        self.view.endEditing(true)
        if mpesaNumberTxt.text?.trimmed == "" {
            displayToast("Please enter MPesa number")
        }else {
            APIManager.shared.serviceCallToAddEditMpesa(["mobileNumber" : mpesaNumberTxt.text!]) {
                NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REFRESH_PAYMENT_DETAILS), object: nil)
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
