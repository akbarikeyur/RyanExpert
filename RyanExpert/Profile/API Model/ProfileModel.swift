//
//  ProfileModel.swift
//  RyanUser
//
//  Created by Amisha on 27/07/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

import UIKit

struct SettingModel {
    var name : String!
    var value : String!
    var image : String!
    var isProfile : Bool!
    var isButton : Bool!
    var isBigButton : Bool!
    var isBoldValue : Bool!
    var isBoldName : Bool!
    
    init(dict : [String : Any])
    {
        name = dict["name"] as? String ?? ""
        value = dict["value"] as? String ?? ""
        image = dict["image"] as? String ?? ""
        isProfile = dict["isProfile"] as? Bool ?? false
        isBigButton = dict["isBigButton"] as? Bool ?? false
        isButton = dict["isButton"] as? Bool ?? false
        isBoldValue = dict["isBoldValue"] as? Bool ?? false
        isBoldName = dict["isBoldName"] as? Bool ?? false
    }
}

struct NotificationModel {
    var id : Int!
    var message : String!
    var date : String!
    
    init(dict : [String : Any])
    {
        id = dict["id"] as? Int ?? 0
        message = dict["message"] as? String ?? ""
        date = dict["date"] as? String ?? ""
    }
}

struct BankModel {
    var id : Int!
    var accountName : String!
    var accountNumber : String!
    var bankBranch : String!
    var bankCode : String!
    var bankMobileNumber : String!
    var bankName : String!
    var branchCode : String!
    var swiftCode : String!
    
    init(dict : [String : Any])
    {
        id = dict["id"] as? Int ?? 0
        if let temp = dict["id"] as? String {
            id = Int(temp)
        }
        accountName = dict["accountName"] as? String ?? ""
        accountNumber = dict["accountNumber"] as? String ?? ""
        bankBranch = dict["bankBranch"] as? String ?? ""
        bankCode = dict["bankCode"] as? String ?? ""
        bankMobileNumber = dict["bankMobileNumber"] as? String ?? ""
        bankName = dict["bankName"] as? String ?? ""
        branchCode = dict["branchCode"] as? String ?? ""
        swiftCode = dict["swiftCode"] as? String ?? ""
    }
}
