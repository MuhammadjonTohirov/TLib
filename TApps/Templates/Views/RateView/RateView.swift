//
//  RateView.swift
//  wtp
//
//  Created by muhammadjon on 22/10/2019.
//  Copyright © 2019 MuhammadjonTohirov. All rights reserved.
//

import Foundation

import UIKit

public enum Rate: Int {
    case zero = 0
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
}

open class RateView: UIView {
    open var numberOfStars: Int = 5
    
    open var starImage: UIImage = #imageLiteral(resourceName: "icon_star_medium")
    
    open var rateable: Bool = false
    
    open var didStarSelected: ((_ selectedStarOrder: Int) -> Void)?
    
    public var starColor: UIColor = UIColor.yellow
    
    public var emptyStarColor: UIColor = UIColor.yellow.withAlphaComponent(0.5)
     
    public convenience init(_ numberOfStars: Rate, rateable: Bool = false) {
        self.init(frame: .zero)
        self.numberOfStars = numberOfStars.rawValue
        self.rateable = rateable
        self.generateStars()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented method")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.frameForStars()
        
    }
    
    open func generateStars() {
        for i in 0..<numberOfStars {
            let image = self.createStar(tag: i + 100)
            self.addSubview(image)
            if rateable {
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onStarClick(_:)))
                image.isUserInteractionEnabled = true
                
                image.addGestureRecognizer(tapGesture)
            }
        }
    }
    
    deinit {
        
    }
    
    @objc public func onStarClick(_ gesture: UITapGestureRecognizer) {
        if !self.rateable {
            return
        }
        
        if let imageView = gesture.view as? UIImageView {
            let n = imageView.tag - 100
            updateRate(rate: n + 1)
            self.didStarSelected?(n + 1)
        }
    }
    
    private func frameForStars() {
        
        var h = self.height
        var w: CGFloat = self.width / CGFloat(numberOfStars + 2)
        var d = (size.width - (h * CGFloat(numberOfStars))) / CGFloat(numberOfStars)
        let minDistance: CGFloat = 2
        w = d >= 0 ? h : (self.width / (CGFloat(numberOfStars)) - minDistance)
        d = d.limitBottom(minDistance)
        var x: CGFloat = d / 2
        
        if d >= 0 {
            h = w.limitTop(self.height)
        } else {
            h = h.limitTop(w)
        }
        
        let y: CGFloat = (self.height - h) / 2
        
        
        for i in 0..<numberOfStars {
            if let image = (self.viewWithTag(i + 100) as? UIImageView) {
                
                image.frame = CGRect(x: x, y: y, width: w, height: h)
            }
            x = x + w + d
        }
    }
    
    private func createStar(tag: Int) -> UIImageView {
        let image = UIImageView(image: starImage.changeColor(theme.iconColor3))
        image.tag = tag
        
        return image
    }
    
    open func updateRate(rate: Int) {

        let r = rate > numberOfStars ? numberOfStars : rate
    
        for i in 0..<numberOfStars {
            
            guard let imageView = (self.viewWithTag(i + 100) as? UIImageView) else {
                fatalError("not an image view error")
            }
            
            if i < r {
                imageView.image = starImage.changeColor(starColor)
            } else {
                imageView.image = starImage.changeColor(emptyStarColor)
            }
        }
    }
}
