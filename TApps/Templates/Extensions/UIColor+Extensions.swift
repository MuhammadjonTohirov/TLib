//
//  UIColor+Extensions.swift
//  wtp
//
//  Created by muhammadjon on 09/10/2019.
//  Copyright © 2019 MuhammadjonTohirov. All rights reserved.
//

import UIKit

extension UIColor {
    ///
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    }
    ///
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    public convenience init(hex: String) {
        let h = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Foundation.Scanner(string: h).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch h.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
   
}

extension UIColor {
    public static let appSecondaryGray: UIColor = #colorLiteral(red: 0.6642268896, green: 0.6642268896, blue: 0.6642268896, alpha: 1)
    public static let appLightGray: UIColor = #colorLiteral(red: 0.5854491591, green: 0.5802605152, blue: 0.6431558728, alpha: 1)
    public static let appMainGray: UIColor = #colorLiteral(red: 0.5137254902, green: 0.5058823529, blue: 0.5764705882, alpha: 1)
    public static let appDarkGray = #colorLiteral(red: 0.3176470588, green: 0.3176470588, blue: 0.3333333333, alpha: 1)
    
    public static let appBlack: UIColor = #colorLiteral(red: 0.1098039216, green: 0.1098039216, blue: 0.1176470588, alpha: 1)
    
    public static let appBlackLight: UIColor = #colorLiteral(red: 0.2048211349, green: 0.2048211349, blue: 0.2048211349, alpha: 1)
    public static let appViolet: UIColor = #colorLiteral(red: 0.5402135253, green: 0.190811187, blue: 0.880767405, alpha: 1)
    public static let appRed: UIColor = #colorLiteral(red: 0.9122664332, green: 0.1302212179, blue: 0, alpha: 1)
    public static let appLightGreen: UIColor = #colorLiteral(red: 0.1410683692, green: 0.8668701053, blue: 0.7982269526, alpha: 1)
    public static let facebookBlue: UIColor = #colorLiteral(red: 0.2935177684, green: 0.4324832559, blue: 0.6613974571, alpha: 1)
    public static let instagram: (top: UIColor, center: UIColor, bottom: UIColor) = (#colorLiteral(red: 0.6822286248, green: 0.264833957, blue: 0.7444463372, alpha: 1),#colorLiteral(red: 0.975289762, green: 0.358186841, blue: 0.2708096504, alpha: 1),#colorLiteral(red: 1, green: 0.7939705253, blue: 0, alpha: 1))
    public static let appBlue: UIColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
    public static let appWhite2: UIColor = #colorLiteral(red: 0.8765067458, green: 0.876527369, blue: 0.8765162826, alpha: 1)
}
