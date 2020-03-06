//
//  FormattedStringValue.swift
//  uzcard trade
//
//  Created by Muhammadjon Tohirov on 2/12/20.
//  Copyright © 2020 Plum Technologies. All rights reserved.
//

import Foundation

public class FormattedStringValue: StringValue {
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
