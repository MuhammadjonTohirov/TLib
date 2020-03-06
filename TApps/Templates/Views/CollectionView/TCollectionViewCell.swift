//
//  TCollectionViewCell.swift
//  uzcard trade
//
//  Created by Muhammadjon Tohirov on 11/28/19.
//  Copyright © 2019 Plum Technologies. All rights reserved.
//

import UIKit

public class TCollectionViewCell: UICollectionViewCell, TUIContainerProtocol {
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
    
    /// init function
    public func initView() {
        self.updateDesign()
    }
    
    /// layouts subviews function
    public func updateFrames(_ size: CGSize) {
        
    }
    
    public func updateDesign() {
        
    }
}
