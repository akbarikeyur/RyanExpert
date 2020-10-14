//
//  HomeModel.swift
//  RyanExpert
//
//  Created by Keyur Akbari on 03/09/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import Foundation

struct SessionModel {
    var id: Int!
    var dateTime : Double!
    var duration, roomID: String!
    var price, status, paymentStatus: Int!
    var user: UserModel!
    
    init(dict : [String : Any])
    {
        id = dict["id"] as? Int ?? 0
        dateTime = 0
        if let temp = dict["dateTime"] as? Double {
            dateTime = temp
        }
        else if let temp = dict["dateTime"] as? String, temp != "" {
            dateTime = Double(temp)
        }
        duration = ""
        if let temp = dict["duration"] as? String {
            duration = temp
        }
        else if let temp = dict["duration"] as? Double {
            duration = String(temp)
        }
        roomID = dict["roomID"] as? String ?? ""
        price = 0
        if let temp = dict["price"] as? Int {
            price = temp
        }
        else if let temp = dict["price"] as? String, temp != "" {
            price = Int(temp)
        }
        status = 0
        if let temp = dict["status"] as? Int {
            status = temp
        }
        else if let temp = dict["status"] as? String, temp != "" {
            status = Int(temp)
        }
        paymentStatus = dict["paymentStatus"] as? Int ?? 0
        user = UserModel.init(dict: dict["user"] as? [String : Any] ?? [String : Any]())
    }
}
