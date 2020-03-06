//
//  TSearchView.swift
//  uzcard trade
//
//  Created by Muhammadjon Tohirov on 11/27/19.
//  Copyright © 2019 Plum Technologies. All rights reserved.
//

import UIKit

@IBDesignable
public final class TSearchView: TView {
    private let bgView: TView = TView()
    private let imageView: UIImageView = UIImageView()
    private lazy var leftImageView: UIImageView = {
        let v = UIImageView()
        v.tag = 111
        return v
    }()
    
    private let inputField: UITextField = UITextField()
    
    @IBInspectable
    public var leftImage: UIImage? = nil {
        didSet {
            
            if let image = self.leftImage {
                if self.viewWithTag(111) == nil  {
                    self.addSubview(leftImageView)
                }
                self.leftImageView.image = image
                self.leftImageView.isHidden = false
                self.setNeedsLayout()
                return
            }
            self.leftImageView.isHidden = true
        }
    }
    
    public var leftView: UIImageView? {
        return self.viewWithTag(111) as? UIImageView
    }
    
    @IBInspectable
    public var image: UIImage? = nil {
        didSet {
            self.imageView.image = self.image
        }
    }
    
    @IBInspectable
    public var placeholder: String? = nil {
        didSet {
            self.inputField.placeholder = self.placeholder
        }
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
    
    public override func initView() {
        self.addSubview(bgView)
        self.backgroundColor = #colorLiteral(red: 0.00400000019, green: 0.2269999981, blue: 0.5370000005, alpha: 1)
        bgView.backgroundColor = .white
        bgView.radius = 8
        self.bgView.addSubviews(views: imageView, inputField)
        self.leftImageView.contentMode = .scaleAspectFit
        
        self.inputField.font = UIFont.museoSansCyrlRegular(ofSize: 14)
    }
    
    public override func updateFrames(_ size: CGSize) {
        var x: CGFloat = 16
        
        if leftImage != nil {
            x = 56
        }
        
        var h: CGFloat = size.height * 0.57
        var y: CGFloat = (size.height - h) / 2
        var w: CGFloat = size.width - 16 - x
        self.bgView.frame = CGRect(x: x, y: y, width: w, height: h)
        
        h = bgView.height * 0.4
        w = h
        y = (bgView.height - h) / 2
        x = y
        self.imageView.frame = CGRect(x: x, y: y, width: w, height: h)

        x = self.imageView.maxX + x
        h = bgView.height * 0.6
        y = (bgView.height - h) / 2
        w = bgView.width - x
        inputField.frame = CGRect(x: x, y: y, width: w, height: h)

        if leftImage != nil {
            w = size.height * 0.3
            h = w
            x = 16
            y = (size.height - h) / 2
            self.leftImageView.frame = CGRect(x: x, y: y, width: w, height: h)
        }
    }
}
