//
//  TransparentViewController.swift
//  uzcard trade
//
//  Created by Muhammadjon Tohirov on 1/25/20.
//  Copyright © 2020 Plum Technologies. All rights reserved.
//

import UIKit

open class TransparentViewController: BaseViewController {
    public let containerView: TView = TView()
    open var didViewDisappear: (() -> Void)?
    open var onViewAppear: (() -> Void)?
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.containerView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.initialize()
    }
    
    open override func initialize() {
        super.initialize()
        self.containerView.alpha = 0
        self.addSubview(containerView)
        self.containerView.onClick(self, #selector(onClickBack))
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.containerView.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.33) {
            self.containerView.alpha = 1
            self.onViewAppear?()
        }
        self.view.backgroundColor = .clear
    }
    
    open override func updateDesign() {
        super.updateDesign()
        self.view.backgroundColor = .clear
    }
    
    open override func updateSubviewFrames(_ size: CGSize) {
        super.updateSubviewFrames(size)
        self.containerView.frame = self.view.bounds
    }
    
    @objc open func onClickBack() {
        self.customDismiss()
    }
    
    open func customDismiss() {
        self.containerView.layoutIfNeeded()
        UIView.animate(withDuration: 0.33, animations: {
            self.containerView.alpha = 0
        }) { [weak self](isOK) in
            if isOK {
                if let nav = self?.navigationController {
                    nav.popViewController(animated: false)
                    _ = self?.didViewDisappear
                    return
                }
                
                self?.dismiss(animated: false, completion: self?.didViewDisappear)
            }
        }
    }
}
