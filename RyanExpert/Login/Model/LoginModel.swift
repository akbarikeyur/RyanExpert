//
//  Login.swift
//  RyanUser
//
//  Created by Keyur Akbari on 23/07/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

struct IntroModel {
    var title : String!
    var subTitle : String!
    var image : String!
    
    init(dict : [String : Any])
    {
        title = dict["title"] as? String ?? ""
        subTitle = dict["subTitle"] as? String ?? ""
        image = dict["image"] as? String ?? ""
    }
}

struct UserModel
{
    var age, completedSessions: Int!
    var id, fullName, email, mobileNumber, goal: String!
    var image: String!
    var expertType, speciality, location, level: String!
    var hasCompletedProfile, isOnline: Bool!
    var rating: Double!
    var sessionsDone, heightFt, heightInch, ongoingSessions, productsPurchased, weight: Int!
    var certifications, awards, publishedArticles, Conferences, feedback: [String]!
    var addresses : [AddressModel]!
    
    init(dict : [String : Any])
    {
        id = dict["id"] as? String ?? ""
        age = dict["age"] as? Int ?? 0
        fullName = dict["fullName"] as? String ?? ""
        email = dict["email"] as? String ?? ""
        mobileNumber = dict["mobileNumber"] as? String ?? ""
        image = dict["image"] as? String ?? ""
        expertType = dict["expertType"] as? String ?? ""
        speciality = dict["speciality"] as? String ?? ""
        location = dict["location"] as? String ?? ""
        hasCompletedProfile = dict["hasCompletedProfile"] as? Bool ?? false
        isOnline = dict["isOnline"] as? Bool ?? false
        rating = dict["rating"] as? Double ?? 0
        sessionsDone = dict["sessionsDone"] as? Int ?? 0
        certifications = dict["certifications"] as? [String] ?? [String]()
        awards = dict["awards"] as? [String] ?? [String]()
        publishedArticles = dict["publishedArticles"] as? [String] ?? [String]()
        Conferences = dict["Conferences"] as? [String] ?? [String]()
        feedback = dict["feedback"] as? [String] ?? [String]()
        addresses = [AddressModel]()
        if let tempData = dict["addresses"] as? [[String : Any]] {
            for temp in tempData {
                addresses.append(AddressModel.init(dict: temp))
            }
        }
        completedSessions = dict["completedSessions"] as? Int ?? 0
        goal = dict["goal"] as? String ?? ""
        heightFt = dict["heightFt"] as? Int ?? 0
        heightInch = dict["heightInch"] as? Int ?? 0
        level = dict["level"] as? String ?? ""
        ongoingSessions = dict["ongoingSessions"] as? Int ?? 0
        productsPurchased = dict["productsPurchased"] as? Int ?? 0
        weight = dict["weight"] as? Int ?? 0
    }
    
    func dictionary() -> [String:Any]  {
        return ["id" : id!, "age" : age!, "fullName":fullName!, "email":email!, "mobileNumber":mobileNumber!, "image":image!, "expertType":expertType!, "speciality":speciality!, "location":location!, "hasCompletedProfile":hasCompletedProfile!, "isOnline":isOnline!, "rating":rating!, "sessionsDone":sessionsDone!, "certifications":certifications!, "awards":awards!, "publishedArticles":publishedArticles!, "Conferences":Conferences!, "feedback":feedback!, "completedSessions" : completedSessions!, "goal":goal!, "heightFt":heightFt!, "heightInch":heightInch!, "level":level!, "ongoingSessions":ongoingSessions!, "productsPurchased":productsPurchased!, "weight":weight!]
    }
}
