//
//  StringValue.swift
//  uzcard trade
//
//  Created by Muhammadjon Tohirov on 11/29/19.
//  Copyright © 2019 Plum Technologies. All rights reserved.
//

import Foundation

public class StringValue: Value {
    public private(set) var maxSize: Int
    
    public init(_ maxSize: Int, _ value: String = "", required: Bool = false) {
        self.maxSize = maxSize
        super.init(val: value, required: required)
        self.value = value
        self.isRequired = required
    }

    public func hasError() -> Bool {
        if self.isRequired {
            return value.isEmpty || (maxSize < value.count)
        }
        
        return maxSize < value.count
    }
    
    public override func onChangeValue() {
        super.onChangeValue()
        if isRequired && value.isEmpty {
            self.hasError = true
            self.errorMessage = "This field is required"
            return
        }
        self.hasError = false
        self.errorMessage = nil
    }
    
    public override func setValue(_ variable: String) {
        super.setValue(variable)
        self.value = variable
    }
}
