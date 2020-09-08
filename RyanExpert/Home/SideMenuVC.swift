//
//  SideMenuVC.swift
//  RyanExpert
//
//  Created by Keyur Akbari on 09/08/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class SideMenuVC: UIViewController {

    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var tblView: UITableView!
    
    var arrMenuData = ["HOME", "PROFILE", "SESSIONS", "NOTIFICATIONS", "PAYMENT DETAILS", "TRANSACTIONS", "NEED HELP?"]
    var selectedMenuIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableViewMethod()
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
extension SideMenuVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: "SideMenuTVC", bundle: nil), forCellReuseIdentifier: "SideMenuTVC")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenuData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SideMenuTVC = tblView.dequeueReusableCell(withIdentifier: "SideMenuTVC") as! SideMenuTVC
        cell.titleLbl.text = arrMenuData[indexPath.row]
        cell.redImgView.isHidden = (selectedMenuIndex != indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMenuIndex = indexPath.row
        tblView.reloadData()
        delay(0.5) {
            self.continueRedirection()
        }
    }
    
    func continueRedirection() {
        self.menuContainerViewController.toggleLeftSideMenuCompletion {
            
        }
        switch arrMenuData[selectedMenuIndex] {
            case "HOME":
                NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REDICT_TAB_BAR), object: ["tabIndex" : 0])
                break
            case "PROFILE":
                NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REDICT_TAB_BAR), object: ["tabIndex" : 3])
                break
            case "SESSIONS":
                NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REDICT_TAB_BAR), object: ["tabIndex" : 2])
                break
            case "NOTIFICATIONS":
                let vc : NotificationVC = STORYBOARD.PROFILE.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
                self.navigationController?.pushViewController(vc, animated: true)
                break
            case "PAYMENT DETAILS":
                let vc : PaymentDetailVC = STORYBOARD.PROFILE.instantiateViewController(withIdentifier: "PaymentDetailVC") as! PaymentDetailVC
                self.navigationController?.pushViewController(vc, animated: true)
                break
            case "TRANSACTIONS":
                let vc : MyTransactionVC = STORYBOARD.PROFILE.instantiateViewController(withIdentifier: "MyTransactionVC") as! MyTransactionVC
                self.navigationController?.pushViewController(vc, animated: true)
                break
            case "NEED HELP?":
                let vc : HelpVC = STORYBOARD.PROFILE.instantiateViewController(withIdentifier: "HelpVC") as! HelpVC
                self.navigationController?.pushViewController(vc, animated: true)
                break
            default:
                break
        }
    }
}
