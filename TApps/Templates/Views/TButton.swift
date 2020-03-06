//
//  TButton.swift
//  uzcard trade
//
//  Created by muhammadjon on 18/11/2019.
//  Copyright © 2019 Plum Technologies. All rights reserved.
//

import UIKit

@IBDesignable
public class TButton: UIButton, TUIProtocol {
    @IBInspectable
    public var radius: CGFloat = 0 {
        didSet {
            self.clipsToBounds = true
            self.layer.cornerRadius = self.radius
            self.setNeedsLayout()
        }
    }
     
    
    @IBInspectable
    public var shadowColor: UIColor = UIColor.black.withAlphaComponent(0.5)
      
    @IBInspectable
    public var shadowY: CGFloat = 0 {
        didSet {
            self.setupShadow()
        }
    }
    
    public var labelFont: UIFont  {
        set {
            self.titleLabel?.font = newValue
        }
        
        get {
            return self.titleLabel?.font ?? UIFont.systemFont(ofSize: 12)
        }
    }
     
    @IBInspectable
    public var shadowX: CGFloat = 0 {
        didSet {
            self.setupShadow()
        }
    }
    
    @IBInspectable
    public var shadowRadius: CGFloat = 8 {
        didSet {
            self.setupShadow()
        }
    }

    public func setupShadow() {
        self.addShadow(shadowColor: self.shadowColor, radius: self.shadowRadius, width: self.shadowX, height: self.shadowY)
    }
}


extension TButton {
    public var title: String {
        set {
            self.setTitle(newValue, for: .normal )
        }
        
        get {
            return self.titleLabel?.text ?? ""
        }
    }
    
    public var textAlignment: NSTextAlignment {
        set {
            self.titleLabel?.textAlignment = newValue
        }
        
        get {
            return self.titleLabel?.textAlignment ?? .left
        }
    }
}
