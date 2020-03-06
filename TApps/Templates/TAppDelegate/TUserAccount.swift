//
//  TUserAccount.swift
//  2shop
//
//  Created by INTECH on 3/6/20.
//  Copyright © 2020 INTECH. All rights reserved.
//

import Foundation

public class TUserAccount {
    fileprivate struct Identifiers {
        static public let languageID = "T-LABS-LANGUAGE-IDENTIFIER"
    }
    
    static public let shared = TUserAccount()
    
    private var standard: UserDefaults {
        return UserDefaults(suiteName: "uz.t_labs")!
    }

    public var language: Language {
        get {
            let rawValue = standard.integer(forKey: Identifiers.languageID)
            return Language(rawValue: rawValue)!
        } set(newLanguage) {
            standard.set(newLanguage.rawValue, forKey: Identifiers.languageID)
        }
    }

}
