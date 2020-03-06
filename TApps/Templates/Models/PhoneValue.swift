//
//  PhoneValue.swift
//  Shaffaf
//
//  Created by Muhammadjon Tohirov on 1/13/20.
//  Copyright © 2020 TxC. All rights reserved.
//

import Foundation

public class PhoneValue: StringValue {
    public private(set) var mask: String
    
    public init(_ maxSize: Int, _ mask: String, _ value: String = "", required: Bool = false) {
        self.mask = mask
        super.init(maxSize, value, required: required)
    }
    
    public override func onChangeValue() {
        super.onChangeValue()
        
    }
    
    /// For formatting a phone number
    /// - Parameter mask: The mask of number. ex: +XX XXX XXX XXXX
    public func formattedNumber() -> String {
        return value.formattedString(mask: self.mask)
    }
}
