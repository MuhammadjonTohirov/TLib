//
//  TAppDelegate.swift
//  2shop
//
//  Created by INTECH on 3/6/20.
//  Copyright © 2020 INTECH. All rights reserved.
//

import UIKit

public let logger = Logging.shared
public let themeManager = TThemeManager()

public var theme: ThemeProtocol = {
    return themeManager.theme
}()

public var appInitializer: TAppInitializer = TAppInitializer.shared

public class TAppInitializer {
     
    public private(set) var window: UIWindow?
    
    public static let shared: TAppInitializer = TAppInitializer()
    
    public init() {
        themeManager.applyTheme(.default)
    }
    
    public func set(window: UIWindow) {
        self.window = window
    }
}
