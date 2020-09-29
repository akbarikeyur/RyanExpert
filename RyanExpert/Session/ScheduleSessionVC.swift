//
//  ScheduleSessionVC.swift
//  RyanExpert
//
//  Created by Keyur Akbari on 12/08/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class ScheduleSessionVC: UIViewController {

    @IBOutlet weak var pendingView: View!
    @IBOutlet weak var pendingTblView: UITableView!
    @IBOutlet weak var constraintHeightPendingTblView: NSLayoutConstraint!
    @IBOutlet weak var recentView: View!
    @IBOutlet weak var recentTblView: UITableView!
    @IBOutlet weak var constraintHeightRecentTblView: NSLayoutConstraint!
    @IBOutlet weak var noDataLbl: Label!
    
    var startCnt = 0
    var arrPendingSessionData = [SessionModel]()
    var arrSessionData = [SessionModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableViewMethod()
        pendingView.isHidden = true
        constraintHeightPendingTblView.constant = 0
        recentView.isHidden = true
        constraintHeightRecentTblView.constant = 0
        refreshPendingSessionData()
        refreshSessionData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().showTabBar()
    }
    
    func refreshSessionData() {
        startCnt = 0
        serviceCallToGetSession()
    }
    
    func refreshPendingSessionData() {
        serviceCallToGetRequestedSession()
    }
    
    //MARK:- Button click event
    @IBAction func clickToNotification(_ sender: Any) {
        let vc : NotificationVC = STORYBOARD.PROFILE.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
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

//MARK:- Tableview Method
extension ScheduleSessionVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        pendingTblView.register(UINib.init(nibName: "PendingSessionTVC", bundle: nil), forCellReuseIdentifier: "PendingSessionTVC")
        recentTblView.register(UINib.init(nibName: "TrainingSessionTVC", bundle: nil), forCellReuseIdentifier: "TrainingSessionTVC")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == pendingTblView {
            return arrPendingSessionData.count
        }
        return arrSessionData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == pendingTblView {
            let cell : PendingSessionTVC = pendingTblView.dequeueReusableCell(withIdentifier: "PendingSessionTVC") as! PendingSessionTVC
            
            cell.selectionStyle = .none
            return cell
        }else{
            let cell : TrainingSessionTVC = recentTblView.dequeueReusableCell(withIdentifier: "TrainingSessionTVC") as! TrainingSessionTVC
            if indexPath.row % 2 == 0 {
                cell.statusBtn.setTitle("Completed", for: .normal)
                cell.statusBtn.backgroundColor = GreenColor
            }else{
                cell.statusBtn.setTitle("Rescheduled", for: .normal)
                cell.statusBtn.backgroundColor = LightTextColor
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == pendingTblView {
            let vc : UserRequestVC = STORYBOARD.HOME.instantiateViewController(withIdentifier: "UserRequestVC") as! UserRequestVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func updatePendingSessionViewHeight() {
        if arrPendingSessionData.count > 0 {
            self.constraintHeightPendingTblView.constant = CGFloat(80 * self.arrPendingSessionData.count) + 68
        }else {
            constraintHeightPendingTblView.constant = 0
        }
        pendingView.isHidden = (arrPendingSessionData.count == 0)
        self.noDataLbl.isHidden = !(self.arrSessionData.count == 0 && self.arrPendingSessionData.count == 0)
    }
    
    func updateRecentSessionViewHeight() {
        if arrSessionData.count > 0 {
            constraintHeightRecentTblView.constant = CGFloat(80 * self.arrSessionData.count) + 48
        }else {
            constraintHeightRecentTblView.constant = 0
        }
        recentView.isHidden = (arrSessionData.count == 0)
        self.noDataLbl.isHidden = !(self.arrSessionData.count == 0 && self.arrPendingSessionData.count == 0)
    }
}

extension ScheduleSessionVC {
    
    func serviceCallToGetRequestedSession() {
        APIManager.shared.serviceCallToGetRequestedSession { (data) in
            self.arrPendingSessionData = [SessionModel]()
            for temp in data {
                self.arrPendingSessionData.append(SessionModel.init(dict: temp))
            }
            self.pendingTblView.reloadData()
            self.updatePendingSessionViewHeight()
        }
    }
    
    func serviceCallToGetSession() {
        APIManager.shared.serviceCallToGetSession(startCnt) { (data, is_last) in
            if self.startCnt == 0 {
                self.arrSessionData = [SessionModel]()
            }
            for temp in data {
                self.arrSessionData.append(SessionModel.init(dict: temp))
            }
            self.recentTblView.reloadData()
            self.updateRecentSessionViewHeight()
        }
    }
    
}
