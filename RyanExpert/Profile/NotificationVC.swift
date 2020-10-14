//
//  NotificationVC.swift
//  RyanExpert
//
//  Created by Keyur Akbari on 12/08/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController {

    @IBOutlet weak var pauseSwitch: UISwitch!
    @IBOutlet weak var tblView: UITableView!
    
    var startCnt = 1
    var arrNotification = [NotificationModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableViewMethod()
        serviceCallToGetNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().hideTabBar()
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func changeNotificationSwitch(_ sender: Any) {
        APIManager.shared.serviceCallToPauseNotification(pauseSwitch.isOn) {
            
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
extension NotificationVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: "CustomNotificationTVC", bundle: nil), forCellReuseIdentifier: "CustomNotificationTVC")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNotification.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CustomNotificationTVC = tblView.dequeueReusableCell(withIdentifier: "CustomNotificationTVC") as! CustomNotificationTVC
        cell.setupDetail(arrNotification[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if startCnt != 0 && indexPath.row == arrNotification.count - 1{
            startCnt += 1
            serviceCallToGetNotification()
        }
    }
}

extension NotificationVC {
    func serviceCallToGetNotification() {
        APIManager.shared.serviceCallToGetNotification(startCnt) { (data, isLast) in
            if self.startCnt == 1 {
                self.arrNotification = [NotificationModel]()
            }
            for temp in data {
                self.arrNotification.append(NotificationModel.init(dict: temp))
            }
            if data.count == 0 {
                self.startCnt = 0
            }
            self.tblView.reloadData()
        }
    }
}
