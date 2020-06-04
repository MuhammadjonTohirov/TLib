//
//  UIView+Extensions.swift
//  wtp
//
//  Created by muhammadjon on 02/10/2019.
//  Copyright © 2019 MuhammadjonTohirov. All rights reserved.
//

import UIKit

extension UIView {
    
    convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        self.init()
        self.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    open func addSubviews(views: UIView...) {
        views.forEach { (v) in
            self.addSubview(v)
        }
    }
    
    open func resizeToFitSubviews() {
        var width: CGFloat = 0
        var height: CGFloat = 0
        for someView in self.subviews {
            let aView = someView
            let newWidth = aView.x + aView.width
            let newHeight = aView.y + aView.height
            width = max(width, newWidth)
            height = max(height, newHeight)
        }
        frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    /// EZSwiftExtensions, resizes this view so it fits the largest subview
    open func resizeToFitSubviews(_ tagsToIgnore: [Int]) {
        var width: CGFloat = 0
        var height: CGFloat = 0
        for someView in self.subviews {
            let aView = someView
            if !tagsToIgnore.contains(someView.tag) {
                let newWidth = aView.x + aView.width
                let newHeight = aView.y + aView.height
                width = max(width, newWidth)
                height = max(height, newHeight)
            }
        }
        frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    /// EZSwiftExtensions
    open func resizeToFitWidth() {
        let currentHeight = self.height
        self.sizeToFit()
        self.height = currentHeight
    }
    
    /// EZSwiftExtensions
    open func resizeToFitHeight() {
        let currentWidth = self.width
        self.sizeToFit()
        self.width = currentWidth
    }
    
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set(newX) {
            self.layer.frame.origin.x = newX
        }
    }
    
    public var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set(newY) {
            self.layer.frame.origin.y = newY
        }
    }
    
    public var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set(newWidth) {
            self.size.width = newWidth
        }
    }
    
    public var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set(newHeight) {
            self.size.height = newHeight
        }
    }
    public var minX: CGFloat {
        get {
            return self.frame.minX
        }
    }
    public var midX: CGFloat {
        get {
            return self.frame.midX
        }
    }
    public var maxX: CGFloat {
        get {
            return self.frame.maxX
        }
    }
    
    public var minY: CGFloat {
        get {
            return self.frame.minY
        }
    }
    public var midY: CGFloat {
        get {
            return self.frame.midY
        }
    }
    public var maxY: CGFloat {
        get {
            return self.frame.maxY
        }
    }
    
    public var size: CGSize {
        get {
            return self.frame.size
        } set {
            self.frame.size = newValue
        }
    }
    
    public var origin: CGPoint {
        get {
            return self.frame.origin
        } set {
            self.frame.origin = newValue
        }
    }
    
    /// EZSwiftExtensions
    public var left: CGFloat {
        get {
            return self.x
        } set(value) {
            self.x = value
        }
    }
    
    ///
    public var right: CGFloat {
        get {
            return self.x + self.width
        } set(value) {
            self.x = value - self.width
        }
    }
    
    ///
    public var top: CGFloat {
        get {
            return self.y
        } set(value) {
            self.y = value
        }
    }
    
    ///
    public var bottom: CGFloat {
        get {
            return self.y + self.height
        } set(value) {
            self.y = value - self.height
        }
    }
    
    ///
    public var centerX: CGFloat {
        get {
            return self.center.x
        } set(value) {
            self.center.x = value
        }
    }
    
    ///
    public var centerY: CGFloat {
        get {
            return self.center.y
        } set(value) {
            self.center.y = value
        }
    }
    
    ///
    open func leftOffset(_ offset: CGFloat) -> CGFloat {
        return self.left - offset
    }
    
    ///
    open func rightOffset(_ offset: CGFloat) -> CGFloat {
        return self.right + offset
    }
    
    ///
    open func topOffset(_ offset: CGFloat) -> CGFloat {
        return self.top - offset
    }
    
    ///
    open func bottomOffset(_ offset: CGFloat) -> CGFloat {
        return self.bottom + offset
    }
    
    //TODO: Add to readme
    open func alignRight(_ offset: CGFloat) -> CGFloat {
        return self.width - offset
    }
}

extension UIView {
    open func addGradient(colors: CGColor..., points: (CGPoint, CGPoint) = (CGPoint(x: 0.5, y: 0), CGPoint(x: 0.5, y: 1)), location: [NSNumber] = [0, 1]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = points.0
        gradientLayer.endPoint = points.1
        gradientLayer.locations = location
        gradientLayer.frame = self.bounds
        
        if let oldLayer = layer.sublayers?.firstIndex(where: {$0.name == "gradient123"}) {
            layer.sublayers?.remove(at: oldLayer)
        }
        gradientLayer.name = "gradient123"
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    /// To use this method, make sure that your view has non zero frame
    /// - Parameter style: Blur effect style
    /// - Returns: Int (tag of added blur effect)
    @discardableResult
    open func makeBlur(style: UIBlurEffect.Style = .dark) -> Int {
        if let _ = self.viewWithTag(1232) {
            return 1232
        }
        
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.7
        blurEffectView.tag = 1232
        self.addSubview(blurEffectView)
        return blurEffectView.tag
    }
    
    public func clearFromBlur() {
        self.subviews.forEach { (view) in
            (view as? UIVisualEffectView)?.removeFromSuperview()
        }
    }
    
    public func view<C>(tag: Int, class: C.Type) -> C? {
        return self.viewWithTag(tag) as? C
    }
    
    public func addDotToRightTop(color: UIColor = UIColor.appRed, top: CGFloat = 6, right: CGFloat = 5) {
        let w: CGFloat = 10
        let h: CGFloat = 10
        let y: CGFloat = top
        let x: CGFloat = self.width - right - w
        
        if let v = self.viewWithTag(91) {
            v.frame = CGRect(x: x, y: y, width: w, height: h)
            return
        }
        
        let dotView = UIView(x: x, y: y, w: w, h: h)
        dotView.tag = 91
        dotView.layer.cornerRadius = h / 2
        dotView.clipsToBounds = true
        dotView.backgroundColor = color
        dotView.layer.borderWidth = 1
        dotView.layer.borderColor = theme.backgroundColor.cgColor
        self.addSubview(dotView)
    }
    
    public func removeRightDot() {
        if let v = self.viewWithTag(91) {
            v.removeFromSuperview()
        }
    }
}

extension UIView {
    public func asImage() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }
    
    public func asImage(frame frm: CGRect) -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: frm)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(frm.size)
            self.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }
    
    public func addShadow(shadowColor: UIColor, radius: CGFloat? = 2, width: CGFloat? = 0, height: CGFloat? = 0) {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = radius!
        self.layer.shadowOpacity = 0.8
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: width!, height: height!)
    }
    
    
}

extension UIView {
    public func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    static public func reportUser(_ message: String) {
        if let keyWindow = UIApplication.shared.keyWindow {
            let bounds = UIScreen.main.bounds
            
            let view = UIView()
            view.backgroundColor = UIColor.lightGray
            view.alpha = 0
            
            let label = UILabel()
            label.text = message
            label.textColor = UIColor.white
            label.font = UIFont.robotoMedium(12)
            label.textAlignment = .center
            
            view.addSubview(label)
            keyWindow.addSubview(view)
            
            var h = CGFloat(50)
            var w = CGFloat(180)
            var x = bounds.midX - w/2
            var y = bounds.midY - h/2
            view.frame = CGRect(x: x, y: y, width: w, height: h)
            view.layer.cornerRadius = h/2
            
            x = 5
            w = view.bounds.width - 2 * x
            h = label.textHeight(w)
            y = view.bounds.midY - h/2
            label.frame = CGRect(x: x, y: y, width: w, height: h)
            
            /// Report user with animation
            UIView.animate(withDuration: 1.0, delay: 0, options: [.curveLinear], animations: {
                view.alpha = 1.0
            }, completion: { (success) in
                if success {
                    UIView.animate(withDuration: 0.7, delay: 0.3, options: [.curveLinear], animations: {
                        view.alpha = 0.0
                    }, completion: { (success) in
                        if success {
                            view.removeFromSuperview()
                        }
                    })
                }
            })
        }
    }
    
    public func onClick(_ target: Any?, _ selector: Selector) {
        let gesture = UITapGestureRecognizer(target: target, action: selector)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(gesture)
    }
    
    func fadeIn() {
        UIView.animate(withDuration: 0.33, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            
            self.alpha = 1.0 // Instead of a specific instance of, say, birdTypeLabel, we simply set [thisInstance] (ie, self)'s alpha
        }, completion: nil)
    }
    
    func fadeOut() {
        UIView.animate(withDuration: 0.33, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: nil)
    }
    
    public var isVisible: Bool {
        set {
            newValue ? show() : hide()
        }
        get {
            return !self.isHidden
        }
    }
    
    private func show() {
        self.isHidden = false
        UIView.animate(withDuration: 0.12, animations: {
            self.setNeedsLayout()
            self.alpha = 1
        }) {_ in
            
        }

    }
    
    private func hide() {
        UIView.animate(withDuration: 0.12, animations: {
            self.setNeedsLayout()
            self.alpha = 0
        }) { (isCompleted) in
            if isCompleted {
                self.isHidden = true
            }
        }
    }

}
