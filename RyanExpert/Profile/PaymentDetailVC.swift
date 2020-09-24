//
//  PaymentDetailVC.swift
//  RyanExpert
//
//  Created by Keyur Akbari on 12/08/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class PaymentDetailVC: UIViewController {

    @IBOutlet weak var editMpesaBtn: UIButton!
    @IBOutlet weak var mpesaView: UIView!
    @IBOutlet weak var mpesaNumberLbl: Label!
    @IBOutlet weak var editBankBtn: UIButton!
    @IBOutlet weak var bankView: UIView!
    @IBOutlet weak var bankNameLbl: Label!
    @IBOutlet weak var bankBranchLbl: Label!
    @IBOutlet weak var accountNumberLbl: Label!
    
    var bankData = BankModel.init(dict: [String : Any]())
    var mpesaNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        serviceCallToGetPaymentDetails()
        self.setupDetail()
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToEditMpesa(_ sender: Any) {
        
    }
    
    @IBAction func clickToEditBank(_ sender: Any) {
        let vc : AddBankDetailVC = STORYBOARD.PROFILE.instantiateViewController(withIdentifier: "AddBankDetailVC") as! AddBankDetailVC
        vc.bankData = bankData
        self.navigationController?.pushViewController(vc, animated: true)
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

extension PaymentDetailVC {
    
    func serviceCallToGetPaymentDetails() {
        APIManager.shared.serviceCallToGetPaymentDetails { (dict) in
            if let bank = dict["bank"] as? [String : Any] {
                self.bankData = BankModel.init(dict: bank)
            }
            if let mpesa = dict["mpesa"] as? [String : Any] {
                self.mpesaNumber = mpesa["mobileNumber"] as? String ?? ""
            }
            self.setupDetail()
        }
    }
    
    func setupDetail() {
        if bankData.id == 0 {
            bankView.isHidden = true
        }else{
            bankView.isHidden = false
            bankNameLbl.text = bankData.bankName
            bankBranchLbl.text = bankData.bankBranch
            accountNumberLbl.text = bankData.accountNumber
        }
        
        if mpesaNumber == "" {
            mpesaView.isHidden = true
        }else{
            mpesaView.isHidden = false
            mpesaNumberLbl.text = mpesaNumber
        }
    }
}
