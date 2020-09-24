//
//  HomeVC.swift
//  RyanExpert
//
//  Created by Keyur Akbari on 09/08/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit
import Toast_Swift

class HomeVC: UIViewController {

    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var onlineBtn: Button!
    @IBOutlet weak var userIdLbl: Label!
    @IBOutlet weak var nameLbl: Label!
    @IBOutlet weak var subTitleLbl: Label!
    @IBOutlet weak var locationLbl: Label!
    @IBOutlet weak var pendingTblView: UITableView!
    @IBOutlet weak var constraintHeightPendingTblView: NSLayoutConstraint!
    @IBOutlet weak var trainingTblView: UITableView!
    @IBOutlet weak var constraintHeightTrainingTblView: NSLayoutConstraint!
    
    var isOnline = true
    var startCnt = 0
    var arrSessionData = [SessionModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(setupDetail), name: NSNotification.Name.init(NOTIFICATION.UPDATE_CURRENT_USER_DATA), object: nil)
        registerTableViewMethod()
        setupDetail()
        AppDelegate().sharedDelegate().serviceCallToGetData()
        refreshHomeData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().showTabBar()
    }
    
    @objc func setupDetail() {
        setImageBackgroundImage(userImgView, AppModel.shared.currentUser.image, "")
        userIdLbl.text = String(AppModel.shared.currentUser.id)
        nameLbl.text = AppModel.shared.currentUser.fullName
        subTitleLbl.text = AppModel.shared.currentUser.speciality
        locationLbl.text = AppModel.shared.currentUser.location
        isOnline = AppModel.shared.currentUser.isOnline
        
        if !isOnline {
            onlineBtn.setTitle("Go Online", for: .normal)
            onlineBtn.backgroundColor = LightTextColor
        }else{
            onlineBtn.setTitle("Go Offline", for: .normal)
            onlineBtn.backgroundColor = GreenColor
        }
    }
    
    func refreshHomeData() {
        startCnt = 0
        serviceCallToGetSession()
    }
    
    //MARK:- Button click event
    @IBAction func clickToNotification(_ sender: Any) {
        let vc : NotificationVC = STORYBOARD.PROFILE.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToGoOnlineOffline(_ sender: Any) {
        isOnline = !isOnline
        if !isOnline {
            onlineBtn.setTitle("Go Online", for: .normal)
            onlineBtn.backgroundColor = LightTextColor
        }else{
            onlineBtn.setTitle("Go Offline", for: .normal)
            onlineBtn.backgroundColor = GreenColor
            self.view.makeToast("\n\n\nSwitch to ‘Online mode’ to Accept or Decline.\n\n\n", duration: 3.0, position: .center, style: ToastStyle())
        }
        
        APIManager.shared.serviceCallToUpdateOnlineStatus(["isOnline" : isOnline]) {
            AppModel.shared.currentUser.isOnline = self.isOnline
            setLoginUserData()
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
extension HomeVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        pendingTblView.register(UINib.init(nibName: "PendingSessionTVC", bundle: nil), forCellReuseIdentifier: "PendingSessionTVC")
        trainingTblView.register(UINib.init(nibName: "TrainingSessionTVC", bundle: nil), forCellReuseIdentifier: "TrainingSessionTVC")
        constraintHeightPendingTblView.constant = 80 * 2
        constraintHeightTrainingTblView.constant = 80 * 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == pendingTblView {
            return 2
        }
        return 3
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
            let cell : TrainingSessionTVC = trainingTblView.dequeueReusableCell(withIdentifier: "TrainingSessionTVC") as! TrainingSessionTVC
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
}

extension HomeVC {
    func serviceCallToGetSession() {
        APIManager.shared.serviceCallToGetSession(startCnt) { (data, is_last) in
            if self.startCnt == 0 {
                self.arrSessionData = [SessionModel]()
            }
            for temp in data {
                self.arrSessionData.append(SessionModel.init(dict: temp))
            }
            self.pendingTblView.reloadData()
        }
    }
}
