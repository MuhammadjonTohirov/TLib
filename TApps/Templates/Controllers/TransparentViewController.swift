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
    public var didViewDisappear: (() -> Void)?
    public var onViewAppear: (() -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        self.containerView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.initialize()
    }
    
    public override func initialize() {
        super.initialize()
        self.containerView.alpha = 0
        self.addSubview(containerView)
        self.containerView.onClick(self, #selector(onClickBack))
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.containerView.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.33) {
            self.containerView.alpha = 1
            self.onViewAppear?()
        }
    }
    
    public override func updateSubviewFrames(_ size: CGSize) {
        super.updateSubviewFrames(size)
        self.containerView.frame = self.view.bounds
    }
    
    @objc func onClickBack() {
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
