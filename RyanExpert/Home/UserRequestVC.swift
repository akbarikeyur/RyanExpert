//
//  UserRequestVC.swift
//  RyanExpert
//
//  Created by Keyur Akbari on 09/08/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class UserRequestVC: UIViewController {

    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var onlineBtn: Button!
    @IBOutlet weak var nameLbl: Label!
    @IBOutlet weak var userDetailLbl: Label!
    @IBOutlet weak var durationLbl: Label!
    @IBOutlet weak var priceLbl: Label!
    @IBOutlet weak var dateLbl: Label!
    @IBOutlet weak var timeLbl: Label!
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet var successRejectView: UIView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var successRejectLbl: Label!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableViewMethod()
        
        loader.transform = CGAffineTransform.init(scaleX: 2.5, y: 2.5)
    }
    
    //MARK:- Button click event
    @IBAction func clickToNotification(_ sender: Any) {
        let vc : NotificationVC = STORYBOARD.PROFILE.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func clickToAcceptDecline(_ sender: UIButton) {
        if sender.tag == 1 {
            //Accept
            successRejectLbl.text = "20MINS Session Accepted!!\n\nConnecting you with trainee……"
        }else{
            //Decline
            successRejectLbl.text = "Session Request Declined!\n\nTaking you back to your dashboard"
        }
        
        displaySubViewtoParentView(self.view, subview: successRejectView)
        loader.startAnimating()
        delay(3.0) {
            self.loader.stopAnimating()
            self.successRejectView.removeFromSuperview()
            if sender.tag == 1 {
                //Accept
                let vc : StartSessionVC = STORYBOARD.HOME.instantiateViewController(withIdentifier: "StartSessionVC") as! StartSessionVC
                self.navigationController?.pushViewController(vc, animated: false)
            }else{
                //Decline
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

//MARK:- Tableview Method
extension UserRequestVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: "UserRequestListTVC", bundle: nil), forCellReuseIdentifier: "UserRequestListTVC")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UserRequestListTVC = tblView.dequeueReusableCell(withIdentifier: "UserRequestListTVC") as! UserRequestListTVC
        if indexPath.row == 0 {
            cell.titleLbl.text = "Medical Condition(s)"
            cell.valueLbl.text = "HIV Positive"
        }
        else if indexPath.row == 1 {
            cell.titleLbl.text = "Previous Sessions"
            cell.valueLbl.text = "7 Weight lift sessions"
        }
        else if indexPath.row == 2 {
            cell.titleLbl.text = "Diet Condition"
            cell.valueLbl.text = "HIV Positive"
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
