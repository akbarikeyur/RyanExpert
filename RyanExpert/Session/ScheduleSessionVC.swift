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
    @IBOutlet weak var myScroll: UIScrollView!
    @IBOutlet weak var pendingTblView: UITableView!
    @IBOutlet weak var constraintHeightPendingTblView: NSLayoutConstraint!
    @IBOutlet weak var recentView: View!
    @IBOutlet weak var recentTblView: UITableView!
    @IBOutlet weak var constraintHeightRecentTblView: NSLayoutConstraint!
    @IBOutlet weak var noDataLbl: Label!
    
    var startCnt = 1
    var arrPendingSessionData = [SessionModel]()
    var arrSessionData = [SessionModel]()
    var refreshConntrol = UIRefreshControl.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(refreshSessionData), name: NSNotification.Name.init(NOTIFICATION.REFRESH_SESSION_LIST), object: nil)
        noDataLbl.isHidden = true
        registerTableViewMethod()
        
        refreshConntrol.tintColor = DarkRedColor
        refreshConntrol.addTarget(self, action: #selector(refreshSessionData), for: .valueChanged)
        myScroll.addSubview(refreshConntrol)
        
        refreshSessionData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().showTabBar()
    }
    
    @objc func refreshSessionData() {
        refreshConntrol.endRefreshing()
        startCnt = 1
        serviceCallToGetSession()
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
        updateTableviewHeight()
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
            cell.setupDetails(arrPendingSessionData[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }else{
            let cell : TrainingSessionTVC = recentTblView.dequeueReusableCell(withIdentifier: "TrainingSessionTVC") as! TrainingSessionTVC
            cell.setupDetails(arrSessionData[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var dict = SessionModel.init(dict: [String : Any]())
        if tableView == pendingTblView {
            dict = arrPendingSessionData[indexPath.row]
        }
        else {
            dict = arrSessionData[indexPath.row]
        }
        if dict.status == 0 {
            let vc : UserRequestVC = STORYBOARD.HOME.instantiateViewController(withIdentifier: "UserRequestVC") as! UserRequestVC
            vc.sessionData = dict
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ScheduleSessionVC {
    func serviceCallToGetSession() {
        APIManager.shared.serviceCallToGetSession(startCnt) { (data, is_last) in
            if self.startCnt == 1 {
                self.arrSessionData = [SessionModel]()
                self.arrPendingSessionData = [SessionModel]()
            }
            for temp in data {
                let session = SessionModel.init(dict: temp)
                if session.status == 0 {
                    self.arrPendingSessionData.append(session)
                }else{
                    self.arrSessionData.append(session)
                }
            }
            self.updateTableviewHeight()
        }
    }
    
    func updateTableviewHeight() {
        pendingTblView.reloadData()
        if arrPendingSessionData.count > 0 {
            self.constraintHeightPendingTblView.constant = CGFloat(80 * self.arrPendingSessionData.count) + 68
        }else {
            constraintHeightPendingTblView.constant = 0
        }
        pendingView.isHidden = (arrPendingSessionData.count == 0)
        recentTblView.reloadData()
        if arrSessionData.count > 0 {
            constraintHeightRecentTblView.constant = CGFloat(80 * self.arrSessionData.count) + 48
        }else {
            constraintHeightRecentTblView.constant = 0
        }
        recentView.isHidden = (arrSessionData.count == 0)
        self.noDataLbl.isHidden = !(self.arrSessionData.count == 0 && self.arrPendingSessionData.count == 0)
    }
    
}
