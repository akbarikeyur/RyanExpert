//
//  ProfileVC.swift
//  RyanExpert
//
//  Created by Keyur Akbari on 11/08/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userIdLbl: Label!
    @IBOutlet weak var nameLbl: Label!
    @IBOutlet weak var specialityLbl: Label!
    @IBOutlet weak var phoneLbl: Label!
    @IBOutlet weak var emailLbl: Label!
    @IBOutlet weak var starView: FloatRatingView!
    @IBOutlet weak var rateLbl: Label!
    @IBOutlet weak var sessionDoneLbl: Label!
    @IBOutlet weak var certificateLbl: Label!
    @IBOutlet weak var feedbackLbl: Label!
    @IBOutlet weak var bankView: View!
    @IBOutlet weak var bank_phoneLbl: Label!
    @IBOutlet weak var bank_acNumberLbl: Label!
    @IBOutlet weak var bank_acNameLbl: Label!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(setupDetails), name: NSNotification.Name.init(NOTIFICATION.UPDATE_CURRENT_USER_DATA), object: nil)
        setupDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().showTabBar()
    }
    
    @objc func setupDetails() {
        setImageBackgroundImage(profileImg, AppModel.shared.currentUser.image, IMAGE.PLACEHOLDER)
        if AppModel.shared.currentUser.expertType == TYPE.TRAINER {
            userIdLbl.text = displayTrainerId(AppModel.shared.currentUser.id)
        }else {
            userIdLbl.text = displayNutritionId(AppModel.shared.currentUser.id)
        }
        nameLbl.text = AppModel.shared.currentUser.fullName
        emailLbl.text = AppModel.shared.currentUser.email
        phoneLbl.text = AppModel.shared.currentUser.mobileNumber
        specialityLbl.text = AppModel.shared.currentUser.speciality
        starView.rating = AppModel.shared.currentUser.rating
        rateLbl.text = String(AppModel.shared.currentUser.rating) + "/5"
        sessionDoneLbl.text = String(AppModel.shared.currentUser.sessionsDone)
        for temp in AppModel.shared.currentUser.certifications {
            if certificateLbl.text != "" {
                certificateLbl.text = (certificateLbl.text ?? "") + "\n"
            }
            certificateLbl.text = temp
        }
        if AppModel.shared.currentUser.feedback.count > 0 {
            feedbackLbl.text = AppModel.shared.currentUser.feedback[0]
        }
        
        if getBankDetail().count == 0 {
            bankView.isHidden = true
        }else{
            bankView.isHidden = false
//            bank_phoneLbl.text = "Phone Number     +234 709 898 09"
//            bank_acNumberLbl.text = "Bank Account     0600 8790 89876"
//            bank_acNameLbl.text = "Payable Account     LISA PATEL"
        }
    }
    
    //MARK:- Button click event
    @IBAction func clickToEdit(_ sender: Any) {
        let vc : EditProfileVC = STORYBOARD.PROFILE.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToLogout(_ sender: Any) {
        showAlertWithOption("Logout", message: "Are you sure want to logout?", btns: ["No", "Yes"], completionConfirm: {
            AppDelegate().sharedDelegate().navigateToLogout()
        }) {
            
        }
    }
    
    @IBAction func clickToEditBankDetails(_ sender: Any) {
        
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
