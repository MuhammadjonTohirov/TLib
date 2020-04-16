//
//  TButton.swift
//  uzcard trade
//
//  Created by muhammadjon on 18/11/2019.
//  Copyright © 2019 Plum Technologies. All rights reserved.
//

import UIKit

@IBDesignable
open class TButton: UIButton, TUIProtocol {
    open var hasClickEffect: Bool = false
    
    @IBInspectable
    open var radius: CGFloat = 0 {
        didSet {
            self.clipsToBounds = true
            self.layer.cornerRadius = self.radius
            self.setNeedsLayout()
        }
    }
     
    
    @IBInspectable
    open var shadowColor: UIColor = UIColor.black.withAlphaComponent(0.5)
      
    @IBInspectable
    open var shadowY: CGFloat = 0 {
        didSet {
            self.setupShadow()
        }
    }
    
    open var labelFont: UIFont  {
        set {
            self.titleLabel?.font = newValue
        }
        
        get {
            return self.titleLabel?.font ?? UIFont.systemFont(ofSize: 12)
        }
    }
     
    @IBInspectable
    open var shadowX: CGFloat = 0 {
        didSet {
            self.setupShadow()
        }
    }
    
    @IBInspectable
    open var shadowRadius: CGFloat = 8 {
        didSet {
            self.setupShadow()
        }
    }

    open func setupShadow() {
        self.addShadow(shadowColor: self.shadowColor, radius: self.shadowRadius, width: self.shadowX, height: self.shadowY)
    }
}


extension TButton {
    open var title: String {
        set {
            self.setTitle(newValue, for: .normal )
        }
        
        get {
            return self.titleLabel?.text ?? ""
        }
    }
    
    open var textAlignment: NSTextAlignment {
        set {
            self.titleLabel?.textAlignment = newValue
        }
        
        get {
            return self.titleLabel?.textAlignment ?? .left
        }
    }
}
