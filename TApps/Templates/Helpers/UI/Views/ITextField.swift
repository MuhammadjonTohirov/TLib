//
//  IndexableTextField.swift
//  uzcard trade
//
//  Created by Muhammadjon Tohirov on 11/29/19.
//  Copyright © 2019 Plum Technologies. All rights reserved.
//

import UIKit

open class ITextField: UITextField, Indexable {
    public var index: NSObject?
    
    public var model: FormModel?
    
    public var formListener: FormInputListener?
    
    public func bind(_ value: Value) {
        self.model = FormModel(value)
        self.formListener = FormInputListener(self, model!)
        self.formListener?.addChangeListener()
        
    }

    public func destroy() {
        self.model = nil
        self.formListener = nil
    }
    
    deinit {
        logger.log("deinit", message: "ITextField", type: .warning)
    }
}
