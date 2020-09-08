//
//  MobileEmailLoginVC.swift
//  RyanExpert
//
//  Created by Keyur Akbari on 03/08/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class MobileEmailLoginVC: UIViewController {

    var type = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func clickToMobileLogin(_ sender: Any) {
        let vc : MobileLoginVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "MobileLoginVC") as! MobileLoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToLoginWithEmail(_ sender: Any) {
        let vc : EmailLoginVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "EmailLoginVC") as! EmailLoginVC
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
