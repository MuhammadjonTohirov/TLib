//
//  EmailValue.swift
//  Shaffaf
//
//  Created by Muhammadjon Tohirov on 1/14/20.
//  Copyright © 2020 TxC. All rights reserved.
//

import Foundation

public class EmailValue: StringValue {
    public override init(_ maxSize: Int, _ value: String = "", required: Bool = false) {
        super.init(maxSize, value, required: required)
        
    }
    
    public override func onChangeValue() {
        super.onChangeValue()
        self.hasError = self.hasError()
        self.setErrorMessage()
    }
    
    public override func hasError() -> Bool {
        let superError = super.hasError()
        let hasError = superError || !(self.isValidEmail())
        
        return hasError
    }
    
    private func setErrorMessage () {
        if super.hasError() {
            return
        }
        
        if self.hasError() {
            self.errorMessage = "It is not a valid email"
            return
        }
        
        self.errorMessage = nil
    }
    
    public func isValidEmail() -> Bool {
        return self.getValue().isEmail
    }
}
