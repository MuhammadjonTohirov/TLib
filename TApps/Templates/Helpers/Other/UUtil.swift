//
//  UUtil.swift
//  uzcard trade
//
//  Created by muhammadjon on 14/11/2019.
//  Copyright © 2019 Plum Technologies. All rights reserved.
//

import UIKit

public typealias Completion<I, R> = (I) -> R

public func mainThread(_ completion: @escaping Completion<String, Void>) {
    DispatchQueue.main.async {
        completion("DispatchQueue.main.label")
    }
}

open class UUtil {
    
    public static func getWindow() -> UIWindow
    {
        return UIApplication.shared.delegate!.window!!
    }
    public static func getStatusBarHeight() -> CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    public static func dialog() -> AlertView {
        
        return AlertView()
    }
    
    public static func alert(_ controller: UIViewController, title: String, message: String, action: Action? = nil) {
        DispatchQueue.main.async(execute: { () -> Void in
            self.dialog().title(title).message(message).showAlert(controller,positiveAction: action)
        })
    }
    
    public static func alertError(_ controller: UIViewController, message: String) {
        self.alert(controller, title: "Error", message: message)
    }
    
    public static func confirm(_ controller: UIViewController, title: String, message: String, action: @escaping Action) {
        DispatchQueue.main.async(execute: { () -> Void in
            self.dialog().title(title).message(message).show(controller, positiveAction: action)
        })
    }
    
    public static func changeColorOfStatusBar(_ color: UIColor) {
        if let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            if statusBar.responds(to: #selector(setter: UIView.backgroundColor)) {
                statusBar.backgroundColor = color
            }
        }
    }
}

