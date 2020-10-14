//
//  GlobalConstant.swift
//  Cozy Up
//
//  Created by Keyur on 15/10/18.
//  Copyright © 2018 Keyur. All rights reserved.
//

import Foundation
import UIKit

let APP_VERSION = 1.0
let BUILD_VERSION = 1
let DEVICE_ID = UIDevice.current.identifierForVendor?.uuidString


let APPLE_LANGUAGE_KEY = "AppleLanguages"

var ABOUT_URL = ""
var FAQ_URL = ""
var TERMS_URL = ""
var POLICY_URL = ""

struct SCREEN
{
    static var WIDTH = UIScreen.main.bounds.size.width
    static var HEIGHT = UIScreen.main.bounds.size.height
}

struct DATE_FORMAT {
    static var SERVER_DATE_FORMAT = "YYYY-MM-dd"
    static var SERVER_TIME_FORMAT = "HH:mm a"
    static var SERVER_DATE_TIME_FORMAT = "yyyy-MM-dd" //HH:mm:ss"
    static var DISPLAY_DATE_FORMAT = "yyyy-MM-dd"
    static var DISPLAY_DATE_FORMAT1 = "MM/dd/yyyy"
    static var DISPLAY_TIME_FORMAT = "dd-MM-YYYY"
    static var DISPLAY_DATE_TIME_FORMAT = "YYYY-MM-dd HH:mm:ss"
}

struct CONSTANT{
    static var DP_IMAGE_WIDTH     =  1000
    static var DP_IMAGE_HEIGHT    =  1000
    
    static let MAX_EMAIL_CHAR = 254
    static let MAX_PREFER_NAME_CHAR = 40
    static let MIN_PWD_CHAR = 8
    static let MAX_PWD_CHAR = 16
    static let MAX_FIRST_NAME_CHAR = 40
    static let MAX_MIDDLE_NAME_CHAR = 40
    static let MAX_LAST_NAME_CHAR = 40
    
    static let DOB_CHAR = 8
    static let DOB_SPACE_CHAR = 4
    static let DOB_DATE_CHAR = 2
    static let DOB_MONTH_CHAR = 2
    static let DOB_YEAR_CHAR = 4
    
    static let MOBILE_NUMBER_CHAR = 8
    static let MOBILE_NUMBER_SPACE_CHAR = 2
    static let MOBILE_NUMBER_CODE = ""
    
    static let CARD_NUMBER_CHAR = 16
    static let CARD_NUMBER_DASH_CHAR = 3
    static let CARD_EXP_DATE_CHAR = 5
    static let CARD_CVV_CHAR = 3
    
    static let SMS_CODE_CHAR = 4
    static let SMS_CODE_SPACE_CHAR = 3
    
    static let IMAGE_QUALITY   =  1
    
    static let CURRENCY   =  "Ksh"
    static let DIST_MEASURE   =  "km"
    static let TIME_ZONE = "Australia/Sydney"
    
    static let DEF_TAKE : Int = 24
    
    static let LIMIT_DATA : Int = 10
}

struct DEVICE {
    static var IS_IPHONE_X = (fabs(Double(SCREEN.HEIGHT - 812)) < Double.ulpOfOne)
}

struct MEDIA {
    static var IMAGE = "IMAGE"
    static var VIDEO = "VIDEO"
}

struct IMAGE {
    static var USER_PLACEHOLDER = "temp_user"
    static var PLACEHOLDER = "ic_placeholder"
}

struct STORYBOARD {
    static var MAIN = UIStoryboard(name: "Main", bundle: nil)
    static var HOME = UIStoryboard(name: "Home", bundle: nil)
    static var PROFILE = UIStoryboard(name: "Profile", bundle: nil)
    
}

struct NOTIFICATION {
    static var UPDATE_CURRENT_USER_DATA     =   "UPDATE_CURRENT_USER_DATA"
    static var REDICT_TAB_BAR               =   "REDICT_TAB_BAR"
    static var NOTIFICATION_TAB_CLICK       =   "NOTIFICATION_TAB_CLICK"
    static var PAYMENT_SUCCESS              =   "PAYMENT_SUCCESS"
    static var REFRESH_SESSION_LIST         =   "REFRESH_SESSION_LIST"
    static var REFRESH_PAYMENT_DETAILS      =   "REFRESH_PAYMENT_DETAILS"
}



struct Platform {
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
}

struct MENU {
    static var CREATE_GROUP = "Create group"
    static var PERSONALITY_QUESTION = "Personality Questions"
    static var PROFILE = "Profile"
    static var SETTING = "Settings"
    static var LOGOUT = "Logout"
    
    static var CREATE_EVENT = "Create Event"
    static var SHARED_MEDIA = "Shared Media"
    static var EXPORT_CHAT = "Export Chat"
    static var REPORT = "Report"
    static var MUTE_NOTIFICATION = "Mute notifications"
    static var GROUP_INFO = "Group Info"
    static var EXIT_GROUP = "Exit group"
    
}
