//
//  Number+Extensions.swift
//  wtp
//
//  Created by muhammadjon on 22/10/2019.
//  Copyright © 2019 MuhammadjonTohirov. All rights reserved.
//

import UIKit

extension CGFloat {
    public func limitTop(_ n: CGFloat) -> CGFloat {
        return (self > n) ? n : self
    }
    
    public func limitBottom(_ n: CGFloat) -> CGFloat {
        return (self < n) ? n : self
    }
}

extension Double {
    /// Remember: The number will be considered as seconds
    public func asTime() -> String {
        let _seconds = (ceil(self))
        let minutes = Int(_seconds / 60)
        let seconds = Int(_seconds) - minutes * 60
        let secondsString = seconds / 10 == 0 ? "0\(seconds)" : "\(seconds)"
        
        
        let minutesString = minutes / 10 == 0 ? "0\(minutes)" : "\(minutes)"
        
        let hours = Int(minutes / 60)
        let hoursString = hours / 10 == 0 ? "0\(hours)" : "\(hours)"
        let prefix = hours != 0 ? "\(hoursString):" : ""
        return "\(prefix)\(minutesString):\(secondsString)"
    }
    
    func asCurrency(_ currency: Currency = .sum, locale: Locale = .current) -> String {
        
        return "\(self.decimalNumber(locale: locale)) \(currency.text)"
    }
    
    public func decimalNumber(locale: Locale = .current) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.formatterBehavior = .default
        formatter.locale = locale
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }

}
