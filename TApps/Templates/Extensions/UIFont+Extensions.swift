//
//  UIFont+Extensions.swift
//  wtp
//
//  Created by muhammadjon on 10/10/2019.
//  Copyright © 2019 MuhammadjonTohirov. All rights reserved.
//

import UIKit

extension UIFont {
    public static func sfFontRegular(_ ofSize: CGFloat) -> UIFont {
        return UIFont(name: "SFProText-Regular", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.regular)
    }
    
    public static func sfFontRegularItalic(_ ofSize: CGFloat) -> UIFont {
        return UIFont(name: "SFProText-RegularItalic", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.regular)
    }
    
    public static func sfFontMedium(_ ofSize: CGFloat) -> UIFont {
        return UIFont(name: "SFProText-Medium", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.medium)
    }
    
    public static func sfFontSemibold(_ ofSize: CGFloat) -> UIFont {
        return UIFont(name: "SFProText-Semibold", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.regular)
    }
    
    public static func sfFontSemiboldItalic(_ ofSize: CGFloat) -> UIFont {
           return UIFont(name: "SFProText-SemiboldItalic", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.regular)
    }
    
    public static func sfFontThin(_ ofSize: CGFloat) -> UIFont {
           return UIFont(name: "SFProText-Thin", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.regular)
    }
    
    public static func sfFontBold(_ ofSize: CGFloat) -> UIFont {
           return UIFont(name: "SFProText-Bold", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.regular)
    }
    
    public static func sfFontBoldItalic(_ ofSize: CGFloat) -> UIFont {
           return UIFont(name: "SFProText-BoldItalic", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.regular)
    }
    
    public static func sfProRoundedRegular(_ ofSize: CGFloat) -> UIFont {
           return UIFont(name: "SFProRounded-Regular", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.regular)
    }
    
    public static func sfProRoundedSemibold(_ ofSize: CGFloat) -> UIFont {
           return UIFont(name: "SFProRounded-Semibold", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.regular)
    }
    
    public static func sfProRoundedBold(_ ofSize: CGFloat) -> UIFont {
           return UIFont(name: "SFProRounded-Bold", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.regular)
    }
    
    public static func sfProRoundedThin(_ ofSize: CGFloat) -> UIFont {
           return UIFont(name: "SFProRounded-Thin", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.regular)
    }
    
    public static func robotoRegular(_ ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Regular", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.regular)
    }
    
    public static func robotoBold(_ ofSize: CGFloat) -> UIFont {
        return  UIFont(name: "Roboto-Bold", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.bold)
    }
    
    public static func robotoBlack(_ ofSize: CGFloat) -> UIFont {
        return  UIFont(name: "Roboto-Black", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.bold)
    }
    
    public static func robotoBlackItalic(_ ofSize: CGFloat) -> UIFont {
        return  UIFont(name: "Roboto-BlackItalic", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.bold)
    }
    
    public static func robotoItalic(_ ofSize: CGFloat) -> UIFont {
        return  UIFont(name: "Roboto-Italic", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.bold)
    }
    
    public static func robotoLight(_ ofSize: CGFloat) -> UIFont {
        return  UIFont(name: "Roboto-Light", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.bold)
    }
    
    public static func robotoLightItalic(_ ofSize: CGFloat) -> UIFont {
        return  UIFont(name: "Roboto-LightItalic", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.bold)
    }
    
    public static func robotoMedium(_ ofSize: CGFloat) -> UIFont {
        return  UIFont(name: "Roboto-Medium", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.bold)
    }
    
    public static func robotoMediumItalic(_ ofSize: CGFloat) -> UIFont {
        return  UIFont(name: "Roboto-MediumItalic", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.bold)
    }
    
    public static func robotoThin(_ ofSize: CGFloat) -> UIFont {
        return  UIFont(name: "Roboto-Thin", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.bold)
    }
    
    public static func robotoThinItalic(_ ofSize: CGFloat) -> UIFont {
        return  UIFont(name: "Roboto-ThinItalic", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.bold)
    }
}

extension UIFont {
    public static func robotoMonoBold(_ ofSize: CGFloat) -> UIFont {
        return  UIFont(name: "RobotoMono-Bold", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.bold)
    }
    
    public static func robotoMonoBoldItalic(_ ofSize: CGFloat) -> UIFont {
        return  UIFont(name: "RobotoMono-BoldItalic", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.bold)
    }
    
    public static func robotoMonoItalic(_ ofSize: CGFloat) -> UIFont {
        return  UIFont(name: "RobotoMono-Italic", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.bold)
    }
    
    public static func robotoMonoLight(_ ofSize: CGFloat) -> UIFont {
        return  UIFont(name: "RobotoMono-Light", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.bold)
    }
    
    public static func robotoMonoLightItalic(_ ofSize: CGFloat) -> UIFont {
        return  UIFont(name: "RobotoMono-LightItalic", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.bold)
    }
    public static func robotoMonoMedium(_ ofSize: CGFloat) -> UIFont {
        return  UIFont(name: "RobotoMono-Medium", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.bold)
    }
    
    public static func robotoMonoMediumItalic(_ ofSize: CGFloat) -> UIFont {
        return  UIFont(name: "RobotoMono-MediumItalic", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.bold)
    }
    
    public static func robotoMonoRegular(_ ofSize: CGFloat) -> UIFont {
        return UIFont(name: "RobotoMono-Regular", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.regular)
    }
    
    public static func robotoMonoThin(_ ofSize: CGFloat) -> UIFont {
        return  UIFont(name: "RobotoMono-Thin", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.bold)
    }
    
    public static func robotoMonoThinItalic(_ ofSize: CGFloat) -> UIFont {
        return  UIFont(name: "RobotoMono-ThinItalic", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.bold)
    }
}

extension UIFont {
    public static func robotoCondensedBold(_ ofSize: CGFloat) -> UIFont {
        return  UIFont(name: "RobotoCondensed-Bold", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.bold)
    }
    
    public static func robotoCondensedBoldItalic(_ ofSize: CGFloat) -> UIFont {
        return  UIFont(name: "RobotoCondensed-BoldItalic", size: ofSize) ?? UIFont.italicSystemFont(ofSize: ofSize)
    }
    
    public static func robotoCondensedItalic(_ ofSize: CGFloat) -> UIFont {
        return  UIFont(name: "RobotoCondensed-Italic", size: ofSize) ?? UIFont.italicSystemFont(ofSize: ofSize)
    }
    
    public static func robotoCondensedLight(_ ofSize: CGFloat) -> UIFont {
        return  UIFont(name: "RobotoCondensed-Light", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.light)
    }
    
    public static func robotoCondensedLightItalic(_ ofSize: CGFloat) -> UIFont {
        return  UIFont(name: "RobotoCondensed-LightItalic", size: ofSize) ?? UIFont.italicSystemFont(ofSize: ofSize)
    }
    
    public static func robotoCondensedRegular(_ ofSize: CGFloat) -> UIFont {
        return UIFont(name: "RobotoCondensed-Regular", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.regular)
    }
}

extension UIFont {
    public static func robotoSlabBold(_ ofSize: CGFloat) -> UIFont {
        return  UIFont(name: "RobotoSlab-Bold", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.bold)
    }
    
    public static func robotoSlabLight(_ ofSize: CGFloat) -> UIFont {
        return  UIFont(name: "RobotoSlab-Light", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.light)
    }
    
    public static func robotoSlabThin(_ ofSize: CGFloat) -> UIFont {
        return  UIFont(name: "RobotoSlab-LightItalic", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.thin)
    }
    
    public static func robotoSlabRegular(_ ofSize: CGFloat) -> UIFont {
        return UIFont(name: "RobotoSlab-Regular", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.regular)
    }
}

extension UIFont {
    
    public static func ocrAStd(_ ofSize: CGFloat) -> UIFont {
        return UIFont(name: "OCRAStd", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.regular)
    }
    
    public static func segoeUI(_ ofSize: CGFloat) -> UIFont {
        return UIFont(name: "SegoeUI", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.regular)
    }
}

extension UIFont {
    
    /// 100 weight
    public static func museoSansCyrlThin(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "MuseoSansCyrl-100", size: size) ?? UIFont.systemFont(ofSize: size, weight: UIFont.Weight.thin)
    }
    
    /// 300 weight
    public static func museoSansCyrlLight(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "MuseoSansCyrl-300", size: size) ?? UIFont.systemFont(ofSize: size, weight: UIFont.Weight.light)
    }
    
    /// 500 weight
    public static func museoSansCyrlRegular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "MuseoSansCyrl-500", size: size) ?? UIFont.systemFont(ofSize: size, weight: UIFont.Weight.regular)
    }
    
    /// 700 weight
    public static func museoSansCyrlBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "MuseoSansCyrl-700", size: size) ?? UIFont.systemFont(ofSize: size, weight: UIFont.Weight.bold)
    }
    
    /// 900 weight
    public static func museoSansCyrlBlack(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "MuseoSansCyrl-900", size: size) ?? UIFont.systemFont(ofSize: size, weight: UIFont.Weight.black)
    }
}
