//
//  TView.swift
//  uzcard trade
//
//  Created by muhammadjon on 18/11/2019.
//  Copyright © 2019 Plum Technologies. All rights reserved.
//

import UIKit

@IBDesignable
open class TView: UIView, TUIProtocol, TUIContainerProtocol {
    public var hasClickEffect = false
    
    @IBInspectable
    public var radius: CGFloat = 0 {
        didSet {
            self.clipsToBounds = true
            self.layer.cornerRadius = self.radius
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
    
    public var stroke: TStroke {
        set {
            self.layer.borderColor = newValue.color.cgColor
            self.layer.borderWidth = newValue.width
        }
        
        get {
            return TStroke(
                width: self.layer.borderWidth,
                color: UIColor(cgColor: (self.layer.borderColor ?? UIColor.black.cgColor)))
        }
    }
    
    public var framesUpdated: ((_ requiredSize: CGSize) -> Void)?
    
    open func setupShadow() {
        self.addShadow(shadowColor: self.shadowColor, radius: self.shadowRadius, width: self.shadowX, height: self.shadowY)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initView()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.updateFrames(self.size)
    }
    
    /// init function
    open func initView() {
        self.updateDesign()
    }
    
    /// layouts subviews function
    open func updateFrames(_ size: CGSize) {
        
    }
    
    /// update design, colors or fonts
    open func updateDesign() {
        
    }
    
}
