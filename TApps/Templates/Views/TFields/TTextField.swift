//
//  TTextField.swift
//  uzcard trade
//
//  Created by muhammadjon on 18/11/2019.
//  Copyright © 2019 Plum Technologies. All rights reserved.
//

import UIKit

public class TTextField: TView {
    
    public let textField: ITextField = ITextField()
    private let titleLabel: UILabel = UILabel()

    @IBInspectable
    public var placeholder: String = "" {
        didSet {
            self.textField.placeholder = self.placeholder
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
            self.textField.text = text
        }
    }
    
    @IBInspectable
    public var hintColor: UIColor = .gray {
        didSet {
            self.titleLabel.textColor = self.hintColor
        }
    }
    
    @IBInspectable
    public var fontSize: CGFloat  = 14 {
        didSet {
            self.textField.font = self.textFont.withSize(self.fontSize)
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
            self.textField.font = newValue
        }
        
        get {
            return self.textField.font ?? UIFont.systemFont(ofSize: 14)
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
        self.addSubviews(views: textField, titleLabel)
        self.onClick(self, #selector(onClickBody))
    }
    
    @objc func onClickBody() {
        self.textField.becomeFirstResponder()
    }
    
    public override func updateFrames(_ size: CGSize) {
        super.updateFrames(size)
        self.updateView()
    }
    
    private func updateView() {
        let x: CGFloat = 10
        var y: CGFloat = 4
        let w: CGFloat = self.width - 2 * x
        var h: CGFloat = self.height * 0.3
        self.titleLabel.frame = CGRect(x: x, y: y, width: w, height: h)
                
        y = self.titleLabel.maxY + 1
        h = self.height * 0.7 - 5
        self.textField.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    public func destroy() {
        self.textField.destroy()
    }
    
    deinit {
        logger.log("deinit", message: "TTextField", type: .warning)
    }
}
