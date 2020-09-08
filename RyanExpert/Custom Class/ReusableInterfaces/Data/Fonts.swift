//
//  Fonts.swift
//  Cozy Up
//
//  Created by Keyur on 22/05/18.
//  Copyright © 2018 Keyur. All rights reserved.
//

import Foundation
import UIKit

let APP_REGULAR = "Poppins-Regular"
let APP_SEMIBOLD = "Poppins-SemiBold"
let APP_BOLD = "Poppins-Bold"
let APP_EXTRA_BOLD = "Poppins-ExtraBold"
let APP_LIGHT = "Poppins-Light"
let APP_ITALIC = "Poppins-Italic"
let APP_MEDIUM = "Poppins-Medium"
let SF_REGULAR = "SFUIDisplay-Regular"

enum FontType : String {
    case Clear = ""
    case ARegular = "ar"
    case ASemiBold = "as"
    case ABold = "ab"
    case AExtraBold = "aeb"
    case ALight = "al"
    case AItalic = "ai"
    case AMedium = "am"
    case SRedular = "sr"
}


extension FontType {
    var value: String {
        get {
            switch self {
                case .Clear:
                    return APP_REGULAR
                case .ARegular:
                    return APP_REGULAR
                case .ASemiBold:
                    return APP_SEMIBOLD
                case .ABold:
                    return APP_BOLD
                case .AExtraBold:
                    return APP_EXTRA_BOLD
                case .ALight:
                    return APP_LIGHT
                case .AItalic:
                    return APP_ITALIC
                case .AMedium:
                    return APP_MEDIUM
                case .SRedular:
                    return SF_REGULAR
                
            }
        }
    }
}

