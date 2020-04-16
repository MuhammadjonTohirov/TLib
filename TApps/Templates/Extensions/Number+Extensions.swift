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
    
    public func asCurrency(_ currency: Currency = .sum) -> String {
        var localize = "uz_UZ"
        switch currency {
        case .sum:
            localize = "uz_UZ"
        case .dollar:
            localize = "en_US"
        case .euro:
            localize = "en_GB"
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: localize)
        
        return formatter.string(from: NSNumber(value: self)) ?? "\(self) \(currency.text)"
    }
}
