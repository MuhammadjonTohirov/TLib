//
//  Language.swift
//  uzcard trade
//
//  Created by muhammadjon on 19/11/2019.
//  Copyright © 2019 Plum Technologies. All rights reserved.
//

import Foundation

public enum Language: Int {
    case uzbek = 0
    case russian
    case english

    public var code: String {
        switch self {
        case .uzbek:
            return "uz"

        case .russian:
            return "ru"

        case .english:
            return "en"
        }
    }
    
    public var officialCode: String {
        switch self {
        case .uzbek:
            return "uz"
            
        case .russian:
            return "ru"
            
        case .english:
            return "en"
        }
    }

    public static var all: [Language] { return [.uzbek, .russian, .english]}

    
    public static func text(_ uz: String?, _ en: String?, _ ru: String?) -> String {
        switch TUserAccount.shared.language {
        case .uzbek: return uz ?? ""
        case .english: return en ?? ""
        case .russian: return ru ?? ""
        }
    }
}
