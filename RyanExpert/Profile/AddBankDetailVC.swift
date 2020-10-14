//
//  AddBankDetailVC.swift
//  RyanExpert
//
//  Created by Keyur Akbari on 09/09/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class AddBankDetailVC: UIViewController {

    @IBOutlet weak var bankNameTxt: TextField!
    @IBOutlet weak var bankCodeTxt: TextField!
    @IBOutlet weak var swiftCodeTxt: TextField!
    @IBOutlet weak var bankBranchTxt: TextField!
    @IBOutlet weak var branchCodeTxt: TextField!
    @IBOutlet weak var accountNameTxt: TextField!
    @IBOutlet weak var accountNumberTxt: TextField!
    @IBOutlet weak var mobileTxt: TextField!
    
    var bankData = BankModel.init(dict: [String : Any]())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if bankData.id != 0 {
            setupDetail()
        }
    }
    
    func setupDetail() {
        bankNameTxt.text = bankData.bankName
        bankCodeTxt.text = bankData.bankCode
        swiftCodeTxt.text = bankData.swiftCode
        bankBranchTxt.text = bankData.bankBranch
        branchCodeTxt.text = bankData.branchCode
        accountNameTxt.text = bankData.accountNumber
        accountNumberTxt.text = bankData.accountName
        mobileTxt.text = bankData.bankMobileNumber
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToAdd(_ sender: Any) {
        self.view.endEditing(true)
        if bankNameTxt.text?.trimmed == "" {
            displayToast("add_bank_name")
        }
        else if bankCodeTxt.text?.trimmed == "" {
            displayToast("add_bank_code")
        }
        else if swiftCodeTxt.text?.trimmed == "" {
            displayToast("add_swift_code")
        }
        else if bankBranchTxt.text?.trimmed == "" {
            displayToast("add_bank_branch")
        }
        else if branchCodeTxt.text?.trimmed == "" {
            displayToast("add_branch_code")
        }
        else if accountNameTxt.text?.trimmed == "" {
            displayToast("add_account_name")
        }
        else if accountNumberTxt.text?.trimmed == "" {
            displayToast("add_account_number")
        }
        else if mobileTxt.text?.trimmed == "" {
            displayToast("add_mobile_number")
        }
        else{
            var param = [String : Any]()
            param["bankName"] = bankNameTxt.text
            param["bankCode"] = bankCodeTxt.text
            param["swiftCode"] = swiftCodeTxt.text
            param["bankBranch"] = bankBranchTxt.text
            param["branchCode"] = branchCodeTxt.text
            param["accountName"] = accountNameTxt.text
            param["accountNumber"] = accountNumberTxt.text
            param["bankMobileNumber"] = mobileTxt.text
            
//            if bankData.id != 0 {
//                param["id"] = bankData.id
//            }
            printData(param)
            APIManager.shared.serviceCallToAddBank(param) {
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
