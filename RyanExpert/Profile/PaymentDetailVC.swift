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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        serviceCallToGetPaymentDetails()
        mpesaView.isHidden = true
        bankView.isHidden = true
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToEditMpesa(_ sender: Any) {
        
    }
    
    @IBAction func clickToEditBank(_ sender: Any) {
        
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
            
        }
    }
}
