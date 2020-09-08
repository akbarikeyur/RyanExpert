//
//  HelpVC.swift
//  RyanExpert
//
//  Created by Keyur Akbari on 12/08/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class HelpVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    var arrSetting = [SettingModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableViewMethod()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().hideTabBar()
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

//MARK:- Tableview Method
extension HelpVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: "CustomNotificationTVC", bundle: nil), forCellReuseIdentifier: "CustomNotificationTVC")
        arrSetting = [SettingModel]()
        let arrTempData = getJsonFromFile("help")
        for temp in arrTempData {
            arrSetting.append(SettingModel.init(dict: temp))
        }
        tblView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSetting.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CustomNotificationTVC = tblView.dequeueReusableCell(withIdentifier: "CustomNotificationTVC") as! CustomNotificationTVC
        cell.titleLbl.text = arrSetting[indexPath.row].name
        cell.titleLbl.textAlignment = .center
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch arrSetting[indexPath.row].name {
            case "About Us":
                openUrlInSafari(strUrl: ABOUT_URL)
//                let vc : AboutUsVC = STORYBOARD.PROFILE.instantiateViewController(withIdentifier: "AboutUsVC") as! AboutUsVC
//                vc.type = 1
//                self.navigationController?.pushViewController(vc, animated: true)
                break
            case "F.A.Q":
                openUrlInSafari(strUrl: FAQ_URL)
//                let vc : FaqsVC = STORYBOARD.PROFILE.instantiateViewController(withIdentifier: "FaqsVC") as! FaqsVC
//                self.navigationController?.pushViewController(vc, animated: true)
                break
            case "Terms and Condition":
                openUrlInSafari(strUrl: TERMS_URL)
//                let vc : AboutUsVC = STORYBOARD.PROFILE.instantiateViewController(withIdentifier: "AboutUsVC") as! AboutUsVC
//                vc.type = 2
//                self.navigationController?.pushViewController(vc, animated: true)
                break
            case "Privacy Policy":
                openUrlInSafari(strUrl: POLICY_URL)
//                let vc : AboutUsVC = STORYBOARD.PROFILE.instantiateViewController(withIdentifier: "AboutUsVC") as! AboutUsVC
//                vc.type = 3
//                self.navigationController?.pushViewController(vc, animated: true)
                break
            case "Contact Us":
                let vc : ContactUsVC = STORYBOARD.PROFILE.instantiateViewController(withIdentifier: "ContactUsVC") as! ContactUsVC
                self.navigationController?.pushViewController(vc, animated: true)
                break
            default:
                break
        }
    }
}
