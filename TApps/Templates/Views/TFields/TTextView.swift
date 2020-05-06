//
//  TTextView.swift
//  uzcard trade
//
//  Created by Muhammadjon Tohirov on 2/4/20.
//  Copyright © 2020 Plum Technologies. All rights reserved.
//

import UIKit

public final class TTextView: TView {
    public let field: ITextView = ITextView()
    internal let titleLabel: TLabel = TLabel()
    
    @IBInspectable
    public var placeholder: String = "" {
        didSet {
            self.field.placeholder = self.placeholder
            self.updateView()
        }
    }
    
    @IBInspectable
    public var hint: String = "" {
        didSet {
            self.titleLabel.text = self.hint
        }
    }
    
    @IBInspectable
    public var strokeWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = self.strokeWidth
        }
    }
    
    @IBInspectable
    public var strokeColor: UIColor = .clear {
        didSet {
            self.layer.borderColor = self.strokeColor.cgColor
        }
    }
    
    @IBInspectable
    public var text: String = "" {
        didSet {
            self.field.text = text
        }
    }
    
    @IBInspectable
    public var hintColor: UIColor = .gray {
        didSet {
            self.titleLabel.textColor = self.hintColor
        }
    }
    
    @IBInspectable
    public var fontSize: CGFloat = 14 {
        didSet {
            self.field.font = self.textFont.withSize(self.fontSize)
            self.titleLabel.font = self.hintFont.withSize(self.fontSize - 4)
        }
    }
    
    public var hintFont: UIFont {
        set {
            self.titleLabel.font = newValue
        }
        
        get {
            return self.titleLabel.font
        }
    }
    
    public var textFont: UIFont {
        set {
            self.field.font = newValue
        }
        
        get {
            return self.field.font ?? UIFont.systemFont(ofSize: 14)
        }
    }
    
    public var fieldBackgroundColor: UIColor {
        set {
            self.field.backgroundColor = newValue
        }
        
        get {
            return self.field.backgroundColor ?? .clear
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
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public override func initView() {
        self.addSubviews(views: field, titleLabel)
        self.onClick(self, #selector(onClickBody))
    }
    
    public func bind(_ value: Value) {
        self.field.bind(value)
    }
    
    @objc func onClickBody() {
        self.field.becomeFirstResponder()
    }
    
    public override func updateFrames(_ size: CGSize) {
        super.updateFrames(size)
        updateView()
    }
    
    private func updateView() {
        let x: CGFloat = 10
        var y: CGFloat = 20
        let w: CGFloat = self.width - 2 * x
        var h: CGFloat = self.height - y * 2
        self.field.frame = CGRect(x: x, y: y, width: w, height: h)
        
        y = 4
        h = 16
        self.titleLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    public func destroy() {
        self.field.destroy()
    }
    
    deinit {
        logger.log("deinit", message: "TTextField", type: .warning)
    }

}
