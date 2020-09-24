//
//  SelectLoginVC.swift
//  RyanExpert
//
//  Created by Keyur Akbari on 03/08/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class SelectLoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickToLogin(_ sender: UIButton) {
        let vc : MobileEmailLoginVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "MobileEmailLoginVC") as! MobileEmailLoginVC
        vc.type = sender.tag
        self.navigationController?.pushViewController(vc, animated: false)
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
