//
//  NUtil.swift
//  uzcard trade
//
//  Created by muhammadjon on 14/11/2019.
//  Copyright © 2019 Plum Technologies. All rights reserved.
//

import UIKit

class NavigationUtil {
    static func getDefaultNavigationBarHeight() -> CGFloat {
        let navCon = UINavigationController()
        return navCon.navigationBar.frame.height
    }
    
    static func getNavigationBarSize(_ controller: UIViewController) -> CGSize {
        return controller.navigationController?.navigationBar.frame.size ?? CGSize(width: 0, height: 0)
    }
    
    static func getNavigationBarWidth(_ controller: UIViewController) -> CGFloat {
        return getNavigationBarSize(controller).width
    }
    
    static func getNavigationBarHeight(_ controller: UIViewController) -> CGFloat {
        return getNavigationBarSize(controller).height
    }
    
    static func getNavigationBarMaxY(_ controller: UIViewController) -> CGFloat {
        return controller.navigationController?.navigationBar.frame.maxY ?? UIApplication.shared.statusBarFrame.maxY
    }
    
    static func getNavigationBarMaxY() -> CGFloat {
        let navCon = UINavigationController()
        return navCon.navigationBar.frame.maxY + UIApplication.shared.statusBarFrame.maxY
    }
}

public enum Direction {
    case horizontal
    case vertical
}

public enum Result<T> {
    case success(T)
    case failure(Error)
}
