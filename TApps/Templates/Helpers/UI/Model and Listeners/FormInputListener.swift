//
//  FormInputListener.swift
//  uzcard trade
//
//  Created by Muhammadjon Tohirov on 11/29/19.
//  Copyright © 2019 Plum Technologies. All rights reserved.
//

import UIKit

public final class FormInputListener: NSObject {
    public var model: FormModel?
    private unowned let field: Indexable?
    
    public init(_ textField: Indexable, _ model: FormModel) {
        self.model = model
        self.field = textField
        
        if let field = self.field as? ITextField {
            field.text = model.value?.getValue()
        }
        
        if let textView = self.field as? ITextView {
            textView.text = model.value?.getValue()
        }
    }
    
    func addChangeListener() {
        switch self.field {
        case is ITextField:
            (field as! ITextField).addTarget(self, action: #selector(self.onChange(_:)), for: .editingChanged)
            self.onChange(field as! ITextField)
        case is TTextField:
            (field as! ITextView).delegate = self
        default:
            break
        }
    }
    
    @objc func onChange(_ sender: ITextField) {
        guard let text = sender.text, let val = self.model?.value else {
            return
        }
        
        switch val {
        case is PhoneValue:
            self.logicForPhoneValue(text, value: val as! PhoneValue)
            break
        case is StringValue:
            self.logicForStringValue(text, value: val as! StringValue)
            break
        default:
            self.model?.setValue(text)
            break
        }
    }
    
    internal func logicForPhoneValue(_ text: String, value: PhoneValue) {
        let phoneText = text.removeSpaces().formattedString(mask: value.mask)
        if phoneText.count <= value.maxSize {
            self.model?.setValue(text)
            (self.field as? ITextField)?.text = phoneText
        } else {
            var t = phoneText
            t.removeLast()
            
            (self.field as? ITextField)?.text = phoneText
        }
    }
    
    internal func logicForStringValue(_ text: String, value: StringValue) {
        if text.count <= value.maxSize {
            self.model?.setValue(text)
        } else {
            var t = text
            t.removeLast()
            (self.field as? ITextField)?.text = t
        }
    }
    
    @objc func onChangeTextView(_ sender: UITextView) {
        guard let text = sender.text else {
            return
        }
        
        self.model?.setValue(text)
    }
}

extension FormInputListener: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        self.onChangeTextView(textView)
    }
}
