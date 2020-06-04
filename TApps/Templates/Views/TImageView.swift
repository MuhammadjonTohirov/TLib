//
//  TImageView.swift
//  uzcard trade
//
//  Created by Muhammadjon Tohirov on 12/2/19.
//  Copyright © 2019 Plum Technologies. All rights reserved.
//

import UIKit

@IBDesignable
open class TImageView: TView {
    public let imageView: UIImageView = UIImageView()
    
    open var image: UIImage? {
        set {
            self.imageView.image = newValue
        }
        
        get {
            return self.imageView.image
        }
    }
    
    public private(set) var padding: (left: CGFloat, top: CGFloat, right: CGFloat, bottom: CGFloat) = (0, 0, 0, 0)
    
    public override var radius: CGFloat {
        didSet {
            self.imageView.clipsToBounds = true
            let totalHeight = self.height - (padding.top + padding.bottom)
            self.imageView.layer.cornerRadius = self.radius.limitTop(totalHeight / 2)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    public convenience init(frame: CGRect = .zero, padding val: CGFloat) {
        self.init(frame: frame)
        self.padding = (left: val, top: val, right: val, bottom: val)
        self.initialize()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.updateFrames(self.size)
    }
    
    public override var contentMode: UIView.ContentMode {
        didSet {
            self.imageView.contentMode = self.contentMode
        }
    }
    
    /// init function
    open func initialize() {
        self.updateDesign()
        self.addSubview(imageView)
    }
    
    /// layouts subviews function
    open override func updateFrames(_ size: CGSize) {
        super.updateFrames(size)
        imageView.frame = self.bounds.inset(by: UIEdgeInsets(top: padding.top, left: padding.left, bottom: padding.bottom, right: padding.right))
    }
    
    /// update design, colors or fonts
    open override func updateDesign() {
        
    }
    
    public func estimatedWidth(height h: CGFloat) -> CGFloat {
        if let image = self.image {
            let d = image.size.width / image.size.height
            return d * h
        }
        
        return 0
    }
    
    public func estimatedHeight(width w: CGFloat) -> CGFloat {
        if let image = self.image {
            let d = image.size.height / image.size.width
            return d * w
        }
        
        return 0
    }
    
    public override func setupShadow() {
        
        self.addShadow(shadowColor: self.shadowColor)
    }
}
