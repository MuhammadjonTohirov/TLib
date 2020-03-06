//
//  CountryPhones.swift
//  uzcard trade
//
//  Created by Muhammadjon Tohirov on 12/6/19.
//  Copyright © 2019 Plum Technologies. All rights reserved.
//

import Foundation

public enum CountryCode: String {
    case uzbekistan = "+998"
    case russia = "+7"
}


public enum Currency: Int {
    case sum = 0
    case dollar = 1
    case euro = 2
    
    public var text: String {
        switch self {
        case .sum:
            return "sum".localized
        case .dollar:
            return "dollar".localized
        case .euro:
            return "euro".localized
        }
    }
    
    public var sign: String {
        switch self {
        case .sum:
            return "sum"
        case .dollar:
            return "$"
        case .euro:
            return "€"
        }
    }
}
