//
//  BaseViewController.swift
//  uzcard trade
//
//  Created by muhammadjon on 14/11/2019.
//  Copyright © 2019 Plum Technologies. All rights reserved.
//

import UIKit

open class BaseViewController: UIViewController, ThemeDesignable {
    fileprivate lazy var backgroundImageView: UIImageView = {
        let v = UIImageView()
        v.tag = 191
        return v
    }()
    
    public let bottomSafeView: TView = {
        let v = TView()
        v.backgroundColor = .clear
        return v
    }()
    
    public var bottomSafeColor: UIColor = .clear {
        didSet {
            self.bottomSafeView.backgroundColor = self.bottomSafeColor
        }
    }
    
    fileprivate var isRightMenuEnabled = false
    
    public var navigationBarHidden: Bool {
        get {
            return self.navigationController!.isNavigationBarHidden
        }
        set {
            self.navigationController?.isNavigationBarHidden = newValue
        }
    }
    
    open var backgroundImage: UIImage? {
        set {
            if let v = self.view.viewWithTag(191) as? UIImageView {
                v.image = newValue
                return
            } else {
                self.addSubview(self.backgroundImageView)
                self.backgroundImageView.image = newValue
            }
        }
        get {
            return self.backgroundImageView.image
        }
    }
    
    open var top: CGFloat {
        get {
            return UUtil.getStatusBarHeight() + NavigationUtil.getNavigationBarHeight(self)
        }
    }
    
    fileprivate var tapGesture: UITapGestureRecognizer!
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.updateDesign()
        self.addSubview(bottomSafeView)
    }
       
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        backgroundImageView.frame = self.view.frame
        backgroundImageView.clipsToBounds = true
        backgroundImageView.contentMode = .scaleAspectFill
    }
    
    public func initialize() {
        
    }
    
    public func updateSubviewFrames(_ size: CGSize) {
        let x: CGFloat = 0
        let h: CGFloat = self.bottomSafe
        let w: CGFloat = size.width - 2 * x
        let y: CGFloat = size.height - h
        self.bottomSafeView.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    /// update design function is responsible for colors, shadows, transparency and such staffes
    public func updateDesign() {
        self.view.backgroundColor = theme.backgroundColor
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.updateSubviewFrames(self.view.size)
    }
    
    open var hideKeyboardWhenTap: Bool = false {
        didSet {
            if self.hideKeyboardWhenTap {
                if self.tapGesture != nil {
                    return
                }
                self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.tapAction(_:)))
                self.view.addGestureRecognizer(self.tapGesture)
            } else {
                self.view.removeGestureRecognizer(self.tapGesture)
                self.tapGesture = nil
            }
        }
    }
    
    @objc func tapAction(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    open func reloadContent() {
        logger.log(message: "Reload content is not overrided")
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        if themeManager.type == .default {
            return .default
        }
        return .lightContent
    }
}
