//
//  UITextField+Extension.swift
//  wtp
//
//  Created by muhammadjon on 01/11/2019.
//  Copyright © 2019 MuhammadjonTohirov. All rights reserved.
//

import UIKit

extension UITextField {
    
}

extension UITextView {

    fileprivate func placeholderLbl() -> UILabel {
        if let lbl = self.viewWithTag(234) as? UILabel {
            return lbl
        } else {
            let plLbl = UILabel()
            plLbl.tag = 234
            plLbl.font = UIFont.museoSansCyrlRegular(ofSize: 14)
            plLbl.backgroundColor = UIColor.clear
            plLbl.textColor = UIColor.lightGray
            self.addSubview(plLbl)
            return plLbl
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        if let lbl = self.viewWithTag(234) {
            lbl.frame = self.bounds
        }
    }
    
    open var placeholder: String? {
        get {
            return self.placeholderLbl().text
        }
        set {
            self.placeholderLbl().text = newValue
        }
    }
    
    open var placeholderHidden: Bool {
        get {
            return self.placeholderLbl().isHidden
        }
        set {
            self.placeholderLbl().isHidden = newValue
        }
    }
}
