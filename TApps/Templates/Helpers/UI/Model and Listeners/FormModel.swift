//
//  FormModel.swift
//  uzcard trade
//
//  Created by Muhammadjon Tohirov on 11/29/19.
//  Copyright © 2019 Plum Technologies. All rights reserved.
//

import Foundation

public typealias FormModelChange = ((_ text: String) -> Void)

public final class FormModel {
    public var value: Value?
    fileprivate var listeners: Array<FormModelChange>?

    public init(_ value: Value) {
        self.value = value
    }
    
    @discardableResult
    public func addListener(_ modelChange: @escaping FormModelChange) -> FormModel {
        if self.listeners == nil {
            self.listeners = []
        }
        self.listeners?.append(modelChange)
        return self
    }
    
    
    public func setValue(_ text: String, _ isSilent: Bool = false) {
        self.value?.setValue(text)
        if isSilent {
            return
        }
        self.notifyListeners()
    }
    
    private func notifyListeners() {
        self.listeners?.forEach { (listener) in
            listener(value?.getValue() ?? "")
        }
    }
    
    public func destroy() {
        self.listeners?.removeAll()
    }
}
