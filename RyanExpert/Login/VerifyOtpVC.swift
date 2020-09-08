//
//  VerifyOtpVC.swift
//  RyanUser
//
//  Created by Amisha on 24/07/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

import UIKit

class VerifyOtpVC: UIViewController {

    @IBOutlet weak var code1Txt: TextField!
    @IBOutlet weak var code2Txt: TextField!
    @IBOutlet weak var code3Txt: TextField!
    @IBOutlet weak var code4Txt: TextField!
    @IBOutlet weak var resendBtn: Button!
    @IBOutlet var successView: UIView!
    @IBOutlet weak var keyboardCV: UICollectionView!
    
    var mobile = ""
    var otpTime : Timer?
    var second = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerCollectionView()
        
        code1Txt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        code2Txt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        code3Txt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        code4Txt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        if #available(iOS 12.0, *) {
            code1Txt.textContentType = .oneTimeCode
            code2Txt.textContentType = .oneTimeCode
            code3Txt.textContentType = .oneTimeCode
            code4Txt.textContentType = .oneTimeCode
            code1Txt.becomeFirstResponder()
        }
        startTimer()
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToVerify(_ sender: Any) {
        self.view.endEditing(true)
        if code1Txt.text?.trimmed != "" && code2Txt.text?.trimmed != "" && code3Txt.text?.trimmed != "" && code4Txt.text?.trimmed != "" {
            let code : String = code1Txt.text! + code2Txt.text! + code3Txt.text! + code4Txt.text!
            print(code)
            
            var param = [String : Any]()
            param["mobileNumber"] = mobile
            param["otp"] = code
            param["device_id"] = DEVICE_ID
            param["device_type"] = "I"
            APIManager.shared.serviceCallToVerifyOtp(param) {
                displaySubViewtoParentView(self.view, subview: self.successView)
                displaySubViewWithScaleOutAnim(self.successView)
                
                delay(3.0) {
                    displaySubViewWithScaleInAnim(self.successView)
                    if AppModel.shared.currentUser.location == "" {
                        let vc : AddPersonalDetailVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "AddPersonalDetailVC") as! AddPersonalDetailVC
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    else{
                        AppDelegate().sharedDelegate().navigateToDashBoard()
                    }
                }
            }
        }
        
    }
    
    @IBAction func clickToChangeNumber(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToResendOtp(_ sender: Any) {
        startTimer()
    }
    
    //MARK:- Timer
    func startTimer()
    {
        if otpTime != nil {
            otpTime?.invalidate()
            second = 30
        }
        otpTime = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            if self.second == 0 {
                self.otpTime?.invalidate()
                self.resendBtn.isEnabled = true
                self.resendBtn.setTitle("Resend", for: .normal)
            }
            else{
                self.second -= 1
                self.resendBtn.setTitle(("Resend (" + String(self.second) + ")"), for: .normal)
                self.resendBtn.isEnabled = false
            }
        })
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

extension VerifyOtpVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 1
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        delay(0.2) {
            self.changeTextField(textField, string)
        }
        return newString.length <= maxLength
    }
    
    func changeTextField(_ textField: UITextField, _ string: String)
    {
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92 && textField.text != "") {
                if textField == code2Txt {
                    code1Txt.becomeFirstResponder()
                } else if textField == code3Txt {
                    code2Txt.becomeFirstResponder()
                } else if textField == code4Txt {
                   code3Txt.becomeFirstResponder()
                }
            }
            else if textField.text != "" {
                if textField == code1Txt {
                    code2Txt.becomeFirstResponder()
                } else if textField == code2Txt {
                    code3Txt.becomeFirstResponder()
                } else if textField == code3Txt {
                   code4Txt.becomeFirstResponder()
                } else if textField == code4Txt {
                   code4Txt.resignFirstResponder()
                }
            }
        }
    }
    
    @objc func textFieldDidChange(_ textField : UITextField) {
        
        if textField.text?.count != 6 {
            return
        }
        let strCode = textField.text
        for i in 0...strCode!.count {
            if strCode!.count <= i {
                break
            }
            switch i {
            case 0:
                code1Txt.text = strCode![i]
                break
            case 1:
                code2Txt.text = strCode![i]
                break
            case 2:
                code3Txt.text = strCode![i]
                break
            case 3:
                code4Txt.text = strCode![i]
                break
            default:
                break
            }
        }
        
        if code1Txt.text?.trimmed != "" && code2Txt.text?.trimmed != "" && code3Txt.text?.trimmed != "" && code4Txt.text?.trimmed != "" {
            clickToVerify(self)
        }
    }
    
}

//MARK:- CollectionView Method
extension VerifyOtpVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func registerCollectionView() {
        keyboardCV.register(UINib.init(nibName: "KeyboardDigitCVC", bundle: nil), forCellWithReuseIdentifier: "KeyboardDigitCVC")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/3, height: collectionView.frame.size.height/4)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : KeyboardDigitCVC = keyboardCV.dequeueReusableCell(withReuseIdentifier: "KeyboardDigitCVC", for: indexPath) as! KeyboardDigitCVC
        cell.digitBtn.isHidden = (indexPath.row == 9)
        cell.digitBtn.setImage(nil, for: .normal)
        cell.digitBtn.setTitle("", for: .normal)
        if indexPath.row == 10 {
            cell.digitBtn.setTitle("0", for: .normal)
        }
        else if indexPath.row == 11 {
            cell.digitBtn.setImage(UIImage(named: "backspace"), for: .normal)
        }else{
            cell.digitBtn.setTitle(String(indexPath.row+1), for: .normal)
        }
        cell.digitBtn.tag = indexPath.row
        cell.digitBtn.addTarget(self, action: #selector(clickToDigitBtn(_:)), for: .touchUpInside)
        return cell
    }
    
    @IBAction func clickToDigitBtn(_ sender: UIButton) {
        if sender.tag == 10 {
            setCodeValue("0")
        }
        else if sender.tag == 11 {
            if code4Txt.text != "" {
                code4Txt.text = ""
                code3Txt.becomeFirstResponder()
            }
            else if code3Txt.text != "" {
                code3Txt.text = ""
                code2Txt.becomeFirstResponder()
            }
            else if code2Txt.text != "" {
                code2Txt.text = ""
                code1Txt.becomeFirstResponder()
            }
            else {
                code1Txt.text = ""
                code1Txt.resignFirstResponder()
            }
        }else{
            setCodeValue(String(sender.tag+1))
        }
    }
    
    func setCodeValue(_ value : String) {
        if code1Txt.text == "" {
            code1Txt.text = value
            code2Txt.becomeFirstResponder()
        }
        else if code2Txt.text == "" {
            code2Txt.text = value
            code3Txt.becomeFirstResponder()
        }
        else if code3Txt.text == "" {
            code3Txt.text = value
            code4Txt.becomeFirstResponder()
        }
        else {
            code4Txt.text = value
            code4Txt.resignFirstResponder()
        }
    }
}
