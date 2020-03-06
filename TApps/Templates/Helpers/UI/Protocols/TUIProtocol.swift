//
//  TUIProtocol.swift
//  uzcard trade
//
//  Created by Muhammadjon Tohirov on 11/26/19.
//  Copyright © 2019 Plum Technologies. All rights reserved.
//

import UIKit

public protocol ThemeDesignable {
    func updateDesign()
}

public protocol TUIContainerProtocol: ThemeDesignable {
    func initView()
    func updateFrames(_ size: CGSize)
}

extension TUIContainerProtocol {
    public func updateDesign() {
        
    }
}

public protocol TUIProtocol {
    var radius: CGFloat {get set}
    var shadowColor: UIColor {get set}
    var shadowY: CGFloat {get set}
    var shadowX: CGFloat {get set}
    var shadowRadius: CGFloat {get set}
    func setupShadow()
}

extension TUIContainerProtocol {
    public func initView() {
        
    }
    
    public func updateFrames(_ size: CGSize) {
        
    }
}
