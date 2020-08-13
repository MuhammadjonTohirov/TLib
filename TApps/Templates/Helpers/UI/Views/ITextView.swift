//
//  ITextView.swift
//  uzcard trade
//
//  Created by Muhammadjon Tohirov on 2/4/20.
//  Copyright © 2020 Plum Technologies. All rights reserved.
//

import UIKit

open class ITextView: UITextView, Indexable {
    public var index: NSObject?
    
    public var model: FormModel?
    
    public var formListener: FormInputListener?
    
    public func bind(_ value: Value) {
        self.model = FormModel(value)
        self.formListener = FormInputListener(self, model!)
        self.formListener?.addChangeListener()
        self.setupAccessoryView()
        
    }
    public func destroy() {
        self.model = nil
        self.formListener = nil
    }
    
    private func setupAccessoryView() {
        let toolBar = UIToolbar()
        toolBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 45)
        
        let doneButton = UIBarButtonItem(title: "done".localized, style: .done, target: self, action: #selector(onClickDone))
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.items = [space, doneButton]
        self.inputAccessoryView = toolBar
    }
    
    @objc private func onClickDone() {
        self.resignFirstResponder()
    }
    
    deinit {
        logger.log("deinit", message: "ITextView", type: .warning)
    }
}
