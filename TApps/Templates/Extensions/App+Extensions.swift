//
//  App+Extensions.swift
//  wtp
//
//  Created by muhammadjon on 11/11/2019.
//  Copyright © 2019 MuhammadjonTohirov. All rights reserved.
//

import UIKit

extension UIApplication {
    func topViewController() -> UIViewController? {
        guard let keyWindow = UIApplication.shared.keyWindow else { return nil }
        return findTopViewController(rootViewController: keyWindow.rootViewController)
    }
    
    private func findTopViewController(rootViewController: UIViewController?) -> UIViewController? {
        if let controller = rootViewController as? UITabBarController {
            return findTopViewController(rootViewController: controller.selectedViewController)
        } else if let controller = rootViewController as? UINavigationController {
            return findTopViewController(rootViewController: controller.visibleViewController)
        } else if let controller = rootViewController?.presentedViewController {
            return findTopViewController(rootViewController: controller)
        }
        return rootViewController
    }
        
    private var visibleController: UIViewController? {
        guard let window = appInitializer.window else {
            logger.log(message: "Please setup app initializer")
            return nil
        }
        
        return (window.rootViewController as? UINavigationController)?.visibleViewController
    }
}

extension UILabel {
    public func setPrice(_ price: Double, _ currency: Currency = .sum, priceSize: CGFloat = 16, currencySize: CGFloat = 12) {
        let format = NumberFormatter()
        format.locale = Locale.current
        format.numberStyle = .decimal
        let priceString = format.string(from: NSNumber(value: price)) ?? "\(price)"
        self.text = priceString
        self.setUnit(currency.text, valueFontSize: UIFont.museoSansCyrlBold(ofSize: priceSize), unitSize: currencySize)
    }
    
    public func setUnit(_ unit: String, valueFontSize: UIFont? = nil, unitSize: CGFloat) {
        guard let title = self.text, !title.isEmpty else {
            return
        }
        
        let realFont = valueFontSize ?? self.font
        
        let text = "\(title) \(unit)"
        
        let priceattr = NSMutableAttributedString(string: text, attributes: [
            NSAttributedString.Key.font: realFont!,
            NSAttributedString.Key.foregroundColor: theme.labelColor
        ])
        
        priceattr.addAttribute(NSAttributedString.Key.font, value: UIFont.museoSansCyrlRegular(ofSize: unitSize), range: NSRange(location: text.count - 3, length: 3))
        
        priceattr.addAttribute(NSAttributedString.Key.foregroundColor, value: theme.labelColor3, range: NSRange(location: text.count - 3, length: 3))
        
        self.attributedText = priceattr
    }
    
    public func readableAmount(_ price: Double) {
        let format = NumberFormatter()
        format.locale = Locale.current
        format.numberStyle = .decimal
        let priceString = format.string(from: NSNumber(value: price)) ?? "\(price)"
        self.text = priceString
    }
}
