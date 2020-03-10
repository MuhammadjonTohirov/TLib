//
//  Theme.swift
//  2shop
//
//  Created by INTECH on 3/6/20.
//  Copyright © 2020 INTECH. All rights reserved.
//

import UIKit

public protocol ThemeProtocol {
    var backgroundColor: UIColor {get}
    var bootmSheetContainerColor: UIColor {get}
    var bootmSheetHandlerColor: UIColor {get}
    var bottomSheetBackgroundColor: UIColor {get}
    
    var labelColor: UIColor {get}
    var labelColor2: UIColor {get}
    var labelColor3: UIColor {get}
    
    var iconColor: UIColor {get}
    var iconColor2: UIColor {get}
    var iconColor3: UIColor {get}
}

public class DefaultTheme: ThemeProtocol {
    public var bootmSheetContainerColor: UIColor = UIColor.white
    
    public var bootmSheetHandlerColor: UIColor = UIColor.systemGray
    
    public var bottomSheetBackgroundColor: UIColor = UIColor.white
    
    public var backgroundColor: UIColor = UIColor.white
    
    public var labelColor: UIColor = UIColor.appBlack
    
    public var labelColor2: UIColor = UIColor.appBlackLight
    
    public var labelColor3: UIColor = UIColor.appDarkGray
    
    /// color code: #363636
    public var iconColor: UIColor = UIColor.appBlack
    
    /// color code: #515155
    public var iconColor2: UIColor = UIColor.appDarkGray
    
    /// color code: #363636 with opacity 0.5
    public var iconColor3: UIColor = UIColor.appBlack.withAlphaComponent(0.5)
}


public enum TThemeType: Int {
    case `default` = 0
    case secondary
    
    public static func identify(_ id: Int?) -> TThemeType {
        switch id {
        case 0:
            return .default
        case 1:
            return .secondary
        default:
            return .default
        }
    }
}


open class TThemeManager {
    public static let shared = TThemeManager()
    
    open var type: TThemeType = .default
    
    open var theme: ThemeProtocol = DefaultTheme()
    
    open func applyTheme(_ type: TThemeType) {
        self.type = type
        switch type {
        case .default:
            self.theme = DefaultTheme()
        case .secondary:
            self.theme = DefaultTheme()
        }
    }
}
