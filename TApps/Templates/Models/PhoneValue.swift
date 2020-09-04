//
//  PhoneValue.swift
//  Shaffaf
//
//  Created by Muhammadjon Tohirov on 1/13/20.
//  Copyright © 2020 TxC. All rights reserved.
//

import Foundation

public class PhoneValue: StringValue {
    public private(set) var mask: (format: String, replacer: String)
    
    public private(set) var prefix: String?
    
    public var formattedValue: ((_ text: String) -> String)?
    
    public init(_ maxSize: Int, _ mask: (format: String, replacer: String), _ value: String = "", required: Bool = false) {
        self.mask = mask
        super.init(maxSize, value, required: required)
        self.manipulateMaks()
    }
    
    private func manipulateMaks() {
        var m = mask
        m.format.removeAll(where: {$0 == mask.replacer.first ?? "X"})
        self.set(prefix: m.format.removeSpaces())
    }
    
    public func set(prefix: String) {
        self.prefix = prefix
    }
    
    public override func onChangeValue() {
        super.onChangeValue()
        
    }
    
    /// For formatting a phone number
    /// - Parameter mask: The mask of number. ex: +XX XXX XXX XXXX
    public func formattedNumber() -> String {
        if let closure = formattedValue {
            return closure(self.getValue())
        }
        
        return value.formattedString(mask: self.mask.format, replacer: self.mask.replacer.first ?? "X")
    }
}
