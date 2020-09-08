//
//  AboutUsVC.swift
//  RyanExpert
//
//  Created by Keyur Akbari on 12/08/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class AboutUsVC: UIViewController {

    @IBOutlet weak var titleLbl: Label!
    @IBOutlet weak var descTxt: TextView!
    
    var type = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if type == 1 {
            titleLbl.text = "About Us"
        }
        else if type == 2 {
            titleLbl.text = "Terms and Conditions"
        }
        else if type == 3 {
            titleLbl.text = "Privacy Policy"
        }
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
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
