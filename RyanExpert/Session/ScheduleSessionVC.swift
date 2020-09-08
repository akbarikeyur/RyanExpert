//
//  ScheduleSessionVC.swift
//  RyanExpert
//
//  Created by Keyur Akbari on 12/08/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class ScheduleSessionVC: UIViewController {

    @IBOutlet weak var trainingTblView: UITableView!
    @IBOutlet weak var constraintHeightTrainingTblView: NSLayoutConstraint!
    @IBOutlet weak var recentTblView: UITableView!
    @IBOutlet weak var constraintHeightRecentTblView: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableViewMethod()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().showTabBar()
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
        trainingTblView.register(UINib.init(nibName: "PendingSessionTVC", bundle: nil), forCellReuseIdentifier: "PendingSessionTVC")
        recentTblView.register(UINib.init(nibName: "TrainingSessionTVC", bundle: nil), forCellReuseIdentifier: "TrainingSessionTVC")
        constraintHeightTrainingTblView.constant = 80 * 2
        constraintHeightRecentTblView.constant = 80 * 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == trainingTblView {
            return 2
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == trainingTblView {
            let cell : PendingSessionTVC = trainingTblView.dequeueReusableCell(withIdentifier: "PendingSessionTVC") as! PendingSessionTVC
            
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
        if tableView == trainingTblView {
            let vc : UserRequestVC = STORYBOARD.HOME.instantiateViewController(withIdentifier: "UserRequestVC") as! UserRequestVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
