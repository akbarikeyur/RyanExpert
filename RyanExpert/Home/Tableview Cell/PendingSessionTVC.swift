//
//  PendingSessionTVC.swift
//  RyanExpert
//
//  Created by Keyur Akbari on 09/08/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class PendingSessionTVC: UITableViewCell {

    @IBOutlet weak var imgBtn: Button!
    @IBOutlet weak var nameLbl: Label!
    @IBOutlet weak var dateLbl: Label!
    @IBOutlet weak var timeLbl: Label!
    @IBOutlet weak var priceLbl: Label!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusBtn: Button!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupDetails(_ dict : SessionModel) {
        setButtonBackgroundImage(imgBtn, dict.user.image, IMAGE.USER_PLACEHOLDER)
        nameLbl.text = dict.user.fullName.capitalized
        let date = getDateFromTimeStamp(dict.dateTime)
        dateLbl.text = getDateStringFromDateWithCurrentLangugae(date: date, format: "dd MMMM yyyy")
        timeLbl.text = getDateStringFromDateWithCurrentLangugae(date: date, format: "hh:mm a")
        priceLbl.text = displayDurationWithMinute(dict.duration) + " / " + displayPriceWithCurrecny(String(dict.price))
        statusBtn.setTitle(getStatus(dict.status), for: .normal)
        statusView.backgroundColor = getStatusBackgroundColor(dict.status)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
