//
//  TrainingSessionTVC.swift
//  RyanExpert
//
//  Created by Keyur Akbari on 09/08/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class TrainingSessionTVC: UITableViewCell {

    @IBOutlet weak var imgBtn: Button!
    @IBOutlet weak var nameLbl: Label!
    @IBOutlet weak var dateLbl: Label!
    @IBOutlet weak var timeLbl: Label!
    @IBOutlet weak var priceLbl: Label!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusBtn: Button!
    @IBOutlet weak var canncelView: UIView!
    @IBOutlet weak var cancelBtn: Button!
    
    var sessionModel:SessionModel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupDetails(_ dict : SessionModel) {
        sessionModel = dict
        
        setButtonBackgroundImage(imgBtn, dict.user.image, IMAGE.USER_PLACEHOLDER)
        nameLbl.text = dict.user.fullName.capitalized
        let date = getDateFromTimeStamp(dict.dateTime)
        dateLbl.text = getDateStringFromDateWithCurrentLangugae(date: date, format: "dd MMMM yyyy")
        timeLbl.text = getDateStringFromDateWithCurrentLangugae(date: date, format: "hh:mm a")
        priceLbl.text = displayDurationWithMinute(dict.duration) + " / " + displayPriceWithCurrecny(String(dict.price))
        statusBtn.setTitle(getStatus(dict.status), for: .normal)
        statusView.backgroundColor = getStatusBackgroundColor(dict.status)
        
        if dict.status == 1 && date >= Date() {
            canncelView.isHidden = false
        }else {
            canncelView.isHidden = true
        }
        
    }
    
    @IBAction func onSessionCancelTap(_ sender: Any) {
        APIManager.shared.serviceCallToCancelSession(String(sessionModel.id)) {
            NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REFRESH_SESSION_LIST), object: nil)
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
