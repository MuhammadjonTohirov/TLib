//
//  FormInputListener.swift
//  uzcard trade
//
//  Created by Muhammadjon Tohirov on 11/29/19.
//  Copyright © 2019 Plum Technologies. All rights reserved.
//

import UIKit

public class FormInputListener: NSObject {
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
    
    open func addChangeListener() {
        switch self.field {
        case is ITextField:
            (field as! ITextField).addTarget(self, action: #selector(self.onChange(_:)), for: .editingChanged)
            self.onChange(field as! ITextField)
        case is ITextView:
            (field as! ITextView).delegate = self
        default:
            if let f = self.field as? UITextField {
                f.addTarget(self, action: #selector(self.onChange(_:)), for: .editingChanged)
            }
            break
        }
    }
    
    @objc func onChange(_ sender: UITextField) {
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
        let format = value.mask.formprivatisedat
        let formatter = DefaultTextFormatter(textPattern: value.mask.format, patternSymbol: "#")
        
        var phoneText = text.removeSpaces().separateBySpace(format: format)
        
        if let prefix = value.prefix, !phoneText.hasPrefix(prefix) {
            if prefix.count > text.count {
                phoneText = prefix
            } else {
                phoneText.insert(contentsOf: prefix, at: phoneText.startIndex)
            }
        }
        
        if phoneText.count <= value.maxSize {
            if let prefix = value.prefix, !text.hasPrefix(prefix) {
                if prefix.count > value.getValue().count {
                    self.model?.setValue("\(prefix)")
                } else {
                    self.model?.setValue("\(prefix)\(text)")
                }
            } else {
                self.model?.setValue(text)
            }
            (self.field as? ITextField)?.text = phoneText
        } else {
            var t = phoneText
            t.removeLast()
            (self.field as? ITextField)?.text = phoneText
        }
    }
    
    internal func isTextInRange(text: String, range: Int) -> Bool {
        return text.count <= range
    }
    
    internal func logicForStringValue(_ text: String, value: StringValue) {
        
        if isTextInRange(text: text, range: value.maxSize) {
            self.model?.setValue(text)
        } else {
            var t = text
            t.removeLast()
            self.model?.setValue(t, true)
            (self.field as? ITextField)?.text = t
        }
    }
    
    @objc func onChangeTextView(_ sender: UITextView) {
        guard let text = sender.text, let value = self.model?.value as? StringValue else {
            return
        }
        
        if isTextInRange(text: text, range: value.maxSize) {
            self.model?.setValue(text)
        } else {
            var t = text
            t.removeLast()
            (self.field as? ITextView)?.text = t
        }
    }
}

extension FormInputListener: UITextViewDelegate {
    
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        editableActiveView = (self.field as? ITextView)
        return true
    }

    public func textViewDidChange(_ textView: UITextView) {
        self.onChangeTextView(textView)
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let char = text.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                return true
            }
        }
        
        if text.count > 1 {
            let t1 = textView.text ?? ""
            let t = "\(t1)\(text)"
            if let val = self.model?.value as? StringValue  {
                return self.isTextInRange(text: t, range: val.maxSize)
            }
        }
        
        return true
    }
}
