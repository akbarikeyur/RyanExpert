//
//  HomeModel.swift
//  RyanExpert
//
//  Created by Keyur Akbari on 03/09/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import Foundation

struct SessionModel {
    var id, dateTime, duration: Int!
    var roomID: String!
    var price, status, paymentStatus: Int!
    var user: UserModel!
    
    init(dict : [String : Any])
    {
        id = dict["id"] as? Int ?? 0
        dateTime = dict["dateTime"] as? Int ?? 0
        duration = dict["duration"] as? Int ?? 0
        roomID = dict["roomID"] as? String ?? ""
        price = dict["price"] as? Int ?? 0
        status = dict["status"] as? Int ?? 0
        paymentStatus = dict["paymentStatus"] as? Int ?? 0
        user = UserModel.init(dict: dict["user"] as? [String : Any] ?? [String : Any]())
    }
}
