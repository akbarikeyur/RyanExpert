//
//  AppModel.swift
//  Cozy Up
//
//  Created by Amisha on 15/10/18.
//  Copyright © 2018 Amisha. All rights reserved.
//
import UIKit

class AppModel: NSObject {
    static let shared = AppModel()
    var currentUser : UserModel!
    
    func resetAllModel()
    {
        currentUser = UserModel.init(dict: [String : Any]())
    }
}



struct AddressModel
{
    var addressLine1 : String!
    var addressLine2 : String!
    var city : Int!
    var country : String!
    var stateProvince : String!
    var zipPostalCode : String!
    
    init(dict : [String : Any])
    {
        addressLine1 = dict["addressLine1"] as? String ?? ""
        addressLine2 = dict["addressLine2"] as? String ?? ""
        city = dict["city"] as? Int ?? 0
        country = dict["country"] as? String ?? ""
        stateProvince = dict["stateProvince"] as? String ?? ""
        zipPostalCode = dict["zipPostalCode"] as? String ?? ""
    }
    
    func dictionary() -> [String:Any]  {
        return ["addressLine1":addressLine1!, "addressLine2":addressLine2!, "city":city!, "country":country!, "stateProvince":stateProvince!, "zipPostalCode":zipPostalCode!]
    }
}

struct CityModel {
    var id: Int!
    var name: String!
    var status: Int!
    var pincode: String!

    init(dict : [String : Any])
    {
        id = dict["id"] as? Int ?? 0
        name = dict["name"] as? String ?? ""
        status = dict["status"] as? Int ?? 0
        pincode = dict["pincode"] as? String ?? ""
    }
}

struct BannerModel {
    var id: Int!
    var image_url: String!
    var status: Int!
    var title: String!

    init(dict : [String : Any])
    {
        id = dict["id"] as? Int ?? 0
        image_url = dict["image_url"] as? String ?? ""
        status = dict["status"] as? Int ?? 0
        title = dict["title"] as? String ?? ""
    }
}

struct CategoryModel {
    var desc: String!
    var id: Int!
    var imagePath, name: String!
    var productOffer: [[String : Any]]!
    var status: Int!

    init(dict : [String : Any])
    {
        desc = dict["description"] as? String ?? ""
        id = dict["id"] as? Int ?? 0
        imagePath = dict["imagePath"] as? String ?? ""
        name = dict["name"] as? String ?? ""
        status = dict["status"] as? Int ?? 0
        productOffer = dict["productOffer"] as? [[String : Any]] ?? [[String : Any]]()
    }
}

struct ProductModel {
    var category_id : Int!
    var desc: String!
    var id: Int!
    var name: String!
    var product_image: [[String : Any]]!
    var product_offer: [[String : Any]]!
    var product_price: [[String : Any]]!
    var status: Int!
    var stock_qty: Int!

    init(dict : [String : Any])
    {
        category_id = dict["category_id"] as? Int ?? 0
        desc = dict["description"] as? String ?? ""
        id = dict["id"] as? Int ?? 0
        name = dict["name"] as? String ?? ""
        status = dict["status"] as? Int ?? 0
        stock_qty = dict["stock_qty"] as? Int ?? 0
        product_image = dict["product_image"] as? [[String : Any]] ?? [[String : Any]]()
        product_offer = dict["product_offer"] as? [[String : Any]] ?? [[String : Any]]()
        product_price = dict["product_price"] as? [[String : Any]] ?? [[String : Any]]()
    }
}
