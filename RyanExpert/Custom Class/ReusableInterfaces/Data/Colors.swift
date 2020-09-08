//
//  Colors.swift
//  Cozy Up
//
//  Created by Keyur on 15/10/18.
//  Copyright © 2018 Keyur. All rights reserved.
//

import UIKit

var ClearColor = UIColor.clear
var WhiteColor = UIColor.white
var DarkTextColor = colorFromHex(hex: "0A0A0A")
var LightTextColor = colorFromHex(hex: "726F6F")
var LightGrayColor = colorFromHex(hex: "D4D4D4")
var BlackColor = UIColor.black
var GreenColor = colorFromHex(hex: "79AE42")
var BackGroundColor = colorFromHex(hex: "FCFBFB")
var PurpleColor = colorFromHex(hex: "8E44AD")
var DarkRedColor = colorFromHex(hex: "C1373E")
var LightGreenColor = colorFromHex(hex: "79AE42", alpha: 0.6)
var ExtraLightGreenColor = colorFromHex(hex: "79AE42", alpha: 0.3)
var LightWhiteColor = colorFromHex(hex: "FFFFFF", alpha: 0.6)
var ExtraLightWhiteColor = colorFromHex(hex: "FFFFFF", alpha: 0.3)

enum ColorType : Int32 {
    case Clear = 0
    case White = 1
    case DarkText = 2
    case LightText = 3
    case LightGray = 4
    case Black = 5
    case Green = 6
    case BackGround = 7
    case Purple = 8
    case DarkRed = 9
    case LightGreen = 10
    case ExtraLightGreen = 11
    case LightWhite = 12
    case ExtraLightWhite = 13
}

extension ColorType {
    var value: UIColor {
        get {
            switch self {
                case .Clear:
                    return ClearColor
                case .White:
                    return WhiteColor
                case .DarkText:
                    return DarkTextColor
                case .LightText:
                    return LightTextColor
                case .LightGray:
                    return LightGrayColor
                case .Black:
                    return BlackColor
                case .Green:
                    return GreenColor
                case .BackGround:
                    return BackGroundColor
                case .Purple:
                    return PurpleColor
                case .DarkRed:
                    return DarkRedColor
                case .LightGreen:
                    return LightGreenColor
                case .ExtraLightGreen:
                    return ExtraLightGreenColor
                case .LightWhite:
                    return LightWhiteColor
                case .ExtraLightWhite:
                    return ExtraLightWhiteColor
            }
        }
    }
}

enum GradientColorType : Int32 {
    case Clear = 0
    case Login = 1
}

extension GradientColorType {
    var layer : GradientLayer {
        get {
            let gradient = GradientLayer()
            switch self {
            case .Clear: //0
                gradient.frame = CGRect.zero
            case .Login: //1
                gradient.colors = [
                    DarkRedColor.cgColor,
                    GreenColor.cgColor
                ]
                gradient.locations = [0, 1]
                gradient.startPoint = CGPoint.zero
                gradient.endPoint = CGPoint(x: 1, y: 0)
            }
            
            return gradient
        }
    }
}


enum GradientColorTypeForView : Int32 {
    case Clear = 0
    case App = 1
}


extension GradientColorTypeForView {
    var layer : GradientLayer {
        get {
            let gradient = GradientLayer()
            switch self {
            case .Clear: //0
                gradient.frame = CGRect.zero
            case .App: //1
                gradient.colors = [
                    DarkRedColor.cgColor,
                    GreenColor.cgColor
                ]
                gradient.locations = [0, 1]
                gradient.startPoint = CGPoint.zero
                gradient.endPoint = CGPoint(x: 1, y: 0)
            }
            
            return gradient
        }
    }
}

