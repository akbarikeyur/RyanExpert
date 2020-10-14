//
//  CustomNotificationTVC.swift
//  RyanExpert
//
//  Created by Keyur Akbari on 12/08/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class CustomNotificationTVC: UITableViewCell {

    @IBOutlet weak var titleLbl: Label!
    @IBOutlet weak var dateLbl: Label!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupDetail(_ dict : NotificationModel) {
        titleLbl.text = dict.message
        let date = getDateFromTimeStamp(dict.date)
        dateLbl.text = getDateStringFromDate(date: date, format: "MMM dd, hh:mm a")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
