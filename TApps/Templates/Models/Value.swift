//
//  Value.swift
//  uzcard trade
//
//  Created by Muhammadjon Tohirov on 11/29/19.
//  Copyright © 2019 Plum Technologies. All rights reserved.
//

import Foundation

public protocol DynamicVariable: class {
    associatedtype Variable
    dynamic var value: Variable {get}
}

public protocol DynamicValue: DynamicVariable {
    var isRequired: Bool {get set}
    func setValue(_ variable: Variable)
    func getValue() -> Variable
}

public class Value: DynamicValue {
   
    public typealias Variable = String

    public var isRequired: Bool
    
    public var hasError: Bool = false
    
    public var errorMessage: String?

    public var value: Variable {
        didSet {
            if value == "" {
                hasError = false
            }
            self.onChangeValue()
        }
    }
    
    public func setValue(_ variable: Variable) {
        self.value = variable
    }
    
    public func getValue() -> Variable {
        return self.value
    }
    
    public init (val text: Variable, required isRequired: Bool = false) {
        self.value = text
        self.isRequired = isRequired
        
    }
    
    public func onChangeValue() {
        
    }
}
