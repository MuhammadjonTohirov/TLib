//
//  TTableViewCell.swift
//  uzcard trade
//
//  Created by Muhammadjon Tohirov on 11/26/19.
//  Copyright © 2019 Plum Technologies. All rights reserved.
//

import UIKit

open class TTableViewCell: UITableViewCell, TUIContainerProtocol {
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func initView() {
        self.updateDesign()
        self.selectionStyle = .none
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.updateFrames(size)
    }
    
    public func updateFrames(_ size: CGSize) {
        
    }
    
    public func updateDesign() {
        
    }
    
    func populate<T>(_ item: T) {
        
    }
}
