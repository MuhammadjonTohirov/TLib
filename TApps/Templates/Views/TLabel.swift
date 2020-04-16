//
//  TLabel.swift
//  uzcard trade
//
//  Created by Muhammadjon Tohirov on 12/25/19.
//  Copyright © 2019 Plum Technologies. All rights reserved.
//

import UIKit

open class TLabel: TView {
    public lazy var label: UILabel = {
        let l = UILabel()
        l.textAlignment = .left
        return l
    }()
    
    open var estimatedHeight: CGFloat {
        return (self.label.text ?? "").heightWithWidth(width: self.width, font: self.label.font) + 8
    }
    
    open func estimatedHeight(_ w: CGFloat) -> CGFloat {
        return (self.label.text ?? "").heightWithWidth(width: w, font: self.label.font) + 4
    }
    
    open func estimatedHeight(_ w: CGFloat, _ lineHeightMultiple: CGFloat) -> CGFloat {
        return (self.label.text ?? "").heightWithWidth(width: w, font: self.label.font) + 4
    }
    
    open var estimatedWidth: CGFloat {
        return (self.label.text ?? "").width(self.label.font) + 16
    }
    
    public var offset: UIOffset = UIOffset(horizontal: 0, vertical: 0)
    
    open override func initView() {
        super.initView()
        self.addSubview(label)
    }
    
    open override func updateFrames(_ size: CGSize) {
        super.updateFrames(size)
        let x: CGFloat = offset.horizontal
        let y: CGFloat = offset.vertical
        let w: CGFloat = size.width - 2 * x
        let h: CGFloat = size.height - 2 * y
        self.label.frame = CGRect(x: x, y: y, width: w, height: h)
           
    }
}

extension TLabel {
    public var text: String {
        set {
            self.label.text = newValue
        }
        
        get {
            return self.label.text ?? ""
        }
    }
    
    public var font: UIFont {
        set {
            self.label.font = newValue
        }
        
        get {
            return self.label.font
        }
    }
    
    public var textColor: UIColor {
        set {
            self.label.textColor = newValue
        }
        
        get {
            return self.label.textColor
        }
    }
    
    public var textAlignment: NSTextAlignment {
        set {
            self.label.textAlignment = newValue
        }
        get {
            return self.label.textAlignment
        }
    }
}
