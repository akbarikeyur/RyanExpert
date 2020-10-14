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
    @IBOutlet weak var nameLbl: Label!
    @IBOutlet weak var userDetailLbl: Label!
    @IBOutlet weak var durationLbl: Label!
    @IBOutlet weak var priceLbl: Label!
    @IBOutlet weak var dateLbl: Label!
    @IBOutlet weak var timeLbl: Label!
    
    @IBOutlet var successRejectView: UIView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var successRejectLbl: Label!
    
    var sessionData = SessionModel.init(dict: [String : Any]())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //registerTableViewMethod()
        
        loader.transform = CGAffineTransform.init(scaleX: 2.5, y: 2.5)
        setupDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().hideTabBar()
    }
    
    func setupDetails() {
        setImageBackgroundImage(userImgView, sessionData.user.image, IMAGE.USER_PLACEHOLDER)
        nameLbl.text = sessionData.user.fullName
        userDetailLbl.text = String(sessionData.user.age) + "yrs | " + String(sessionData.user.weight) + "Kg | " + sessionData.user.level
        durationLbl.text = displayDurationWithMinute(sessionData.duration) + " Session"
        priceLbl.text = displayPriceWithCurrecny(String(sessionData.price))
        let date = getDateFromTimeStamp(sessionData.dateTime)
        dateLbl.text = getDateStringFromDateWithCurrentLangugae(date: date, format: "dd MMMM yyyy")
        timeLbl.text = getDateStringFromDateWithCurrentLangugae(date: date, format: "hh:mm a")
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToNotification(_ sender: Any) {
        let vc : NotificationVC = STORYBOARD.PROFILE.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func clickToAcceptDecline(_ sender: UIButton) {
        if sender.tag == 1 {
            //Accept
            successRejectLbl.text = displayDurationWithMinute(sessionData.duration) + " Session Accepted!!\n\nConnecting you with trainee……"
        }else{
            //Decline
            successRejectLbl.text = "Session Request Declined!\n\nTaking you back to your dashboard"
        }
        if sender.tag == 1 {
            //Accept
            APIManager.shared.serviceCallToAcceptRejectSession(String(self.sessionData.id), ["isAccepted" : "Y"]) {
                NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REFRESH_SESSION_LIST), object: nil)
                self.navigationController?.popViewController(animated: true)
            }
        }else{
            //Decline
            APIManager.shared.serviceCallToAcceptRejectSession(String(self.sessionData.id), ["isAccepted" : "N"]) {
                NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REFRESH_SESSION_LIST), object: nil)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
