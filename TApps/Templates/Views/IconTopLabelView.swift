//
//  TIconView.swift
//  uzcard trade
//
//  Created by Muhammadjon Tohirov on 11/28/19.
//  Copyright © 2019 Plum Technologies. All rights reserved.
//

import UIKit

public final class IconTopLabelView: TView {
    private let imageView: UIImageView = UIImageView()
    private let textLabel: UILabel = UILabel()
    
    public var titleColor: UIColor = UIColor.appBlackLight {
        didSet {
            self.textLabel.textColor = self.titleColor
        }
    }
    
    public var iconColor: UIColor = theme.iconColor {
        didSet {
            self.imageView.image = self.imageView.image?.changeColor(self.iconColor)
        }
    }
    
    public var withShadow: Bool = false {
        didSet {
            let radius = CGFloat(self.withShadow ? 3 : 0)
            let height = CGFloat(self.withShadow ? 1 : 0)
            self.imageView.addShadow(shadowColor: theme.backgroundColor.withAlphaComponent(0.6), radius: radius, width: 0, height: height)        }
    }
    
    public override func initView() {
        super.initView()
        self.addSubviews(views: imageView, textLabel)
        self.textLabel.font = UIFont.museoSansCyrlBold(ofSize: 11)
        self.textLabel.textAlignment = .center
        self.imageView.contentMode = .scaleAspectFit
        
        self.backgroundColor = .clear
        self.imageView.image = self.imageView.image?.changeColor(self.iconColor)
        self.textLabel.textColor = self.titleColor
    }
    
    public override func updateFrames(_ size: CGSize) {
        super.updateFrames(size)
        let x: CGFloat = 0
        var y: CGFloat = 0
        var h: CGFloat = size.height * 0.4
        let w: CGFloat = size.width
        self.imageView.frame = CGRect(x: x, y: y, width: w, height: h)
        
        y = self.imageView.maxY + 10
        h = size.height - y
        self.textLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    public func populate(_ title: String, _ image: UIImage) {
        self.textLabel.text = title
        self.imageView.image = image
    }
}

