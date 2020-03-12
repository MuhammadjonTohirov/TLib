//
//  ViewController+Extension.swift
//  wtp
//
//  Created by muhammadjon on 02/10/2019.
//  Copyright © 2019 MuhammadjonTohirov. All rights reserved.
//

import UIKit

extension UIViewController {
    open func addSubview(_ view: UIView) {
        self.view.addSubview(view)
    }
    
    open func addSubviews(_ views: UIView...) {
        views.forEach { (v) in
            self.view.addSubview(v)
        }
    }
    
    open var topSafe: CGFloat {
        get {
            var h = (self.navigationController?.isNavigationBarHidden ?? false) ? 0 : NavigationUtil.getNavigationBarHeight(self)
            return UUtil.getStatusBarHeight() + h
        }
    }
    
    open var bottomSafe: CGFloat {
        get {
            return self.view.safeAreaInsets.bottom
        }
    }
    
    public func setLeftNavigationItems(_ items: [UIBarButtonItem]?, isAfterBackButton: Bool = false) {
        self.navigationItem.leftItemsSupplementBackButton = isAfterBackButton
        self.navigationItem.leftBarButtonItems = items
    }
    public func addLeftNavigationItem(_ item: UIBarButtonItem) {
        if self.navigationItem.leftBarButtonItems == nil {
            self.navigationItem.leftBarButtonItems = []
        }
        self.navigationItem.leftBarButtonItems?.append(item)
    }
    
    public func setRightNavigationItems(_ items: [UIBarButtonItem]?) {
        self.navigationItem.rightBarButtonItems = items
    }
    public func setRightNavigationItemsWithDistance(_ items: [UIBarButtonItem]?) {
        var its = items
        if items?.count ?? 0 > 0 {
            its = []
            for item in items! {
                its?.append(item)
                let dis = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
                dis.width = -100
                its?.append(dis)
            }
        }
        self.navigationItem.rightBarButtonItems = its
    }
    public func addRightNavigationItem(_ item: UIBarButtonItem) {
        if self.navigationItem.rightBarButtonItems == nil {
            self.navigationItem.rightBarButtonItems = []
        }
        self.navigationItem.rightBarButtonItems?.append(item)
    }
}
