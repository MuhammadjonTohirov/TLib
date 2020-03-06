//
//  TTableView.swift
//  uzcard trade
//
//  Created by Muhammadjon Tohirov on 11/26/19.
//  Copyright © 2019 Plum Technologies. All rights reserved.
//

import UIKit

open class TTableView: UITableView, TUIContainerProtocol {

    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.initView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initView()
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.updateFrames(self.size)

    }
    
    open func initView() {
        self.updateDesign()
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.separatorColor = .clear
    }
    
    public func updateFrames(_ size: CGSize) {
        
    }
    
    public func updateDesign() {
        
    }
    
    public func register<T: UITableViewCell>(classObj: T.Type) {
        self.register(classObj, forCellReuseIdentifier: String(describing: classObj))
    }
    
    public func dequeue<T: UITableViewCell>(classObj: T.Type, indexPath: IndexPath) -> T? {
        return self.dequeueReusableCell(withIdentifier: String(describing: classObj), for: indexPath) as? T
    }
    
    open override func reloadRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        super.reloadRows(at: indexPaths, with: animation)
    }
    
    open override func reloadData() {
        super.reloadData()
    }
}
