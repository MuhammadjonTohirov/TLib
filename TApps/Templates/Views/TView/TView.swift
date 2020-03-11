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
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.updateFrames(self.size)
    }
    
    /// init function
    public func initView() {
        self.updateDesign()
    }
    
    /// layouts subviews function
    open func updateFrames(_ size: CGSize) {
        
    }
    
    /// update design, colors or fonts
    open func updateDesign() {
        
    }
    
    open func makeDashedBorderDashed(_ color: UIColor, _ space: NSNumber = 5) {
        let v = CAShapeLayer()
        v.strokeColor = color.cgColor
        v.lineDashPattern = [3, space]
        v.lineWidth = 3
        v.frame = self.bounds
        v.fillColor = UIColor.clear.cgColor
        v.path = UIBezierPath(rect: self.bounds).cgPath
        v.cornerRadius = 8
        self.layer.addSublayer(v)
    }
}
