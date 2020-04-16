//
//  TView+Extensions.swift
//  uzcard trade
//
//  Created by Muhammadjon Tohirov on 1/14/20.
//  Copyright © 2020 Plum Technologies. All rights reserved.
//

import UIKit

extension TView {
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.layoutIfNeeded()
        if !self.hasClickEffect {return}
        UIView.animate(withDuration: 0.11) {
            self.alpha = 0.5
            self.subviews.forEach { (view) in
                view.alpha = 0.5
            }
        }
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        self.layoutIfNeeded()
        if !self.hasClickEffect {return}
        UIView.animate(withDuration: 0.11) {
            self.alpha = 1
            self.subviews.forEach { (view) in
                view.alpha = 1
            }
        }
        
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.layoutIfNeeded()
        if !self.hasClickEffect {return}
        UIView.animate(withDuration: 0.11) {
            self.alpha = 1
            self.subviews.forEach { (view) in
                view.alpha = 1
            }
        }
    }
}

extension TButton {
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.layoutIfNeeded()
        if !self.hasClickEffect {return}
        UIView.animate(withDuration: 0.11) {
            self.alpha = 0.5
            self.subviews.forEach { (view) in
                view.alpha = 0.5
            }
        }
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        self.layoutIfNeeded()
        if !self.hasClickEffect {return}
        UIView.animate(withDuration: 0.11) {
            self.alpha = 1
            self.subviews.forEach { (view) in
                view.alpha = 1
            }
        }
        
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.layoutIfNeeded()
        if !self.hasClickEffect {return}
        UIView.animate(withDuration: 0.11) {
            self.alpha = 1
            self.subviews.forEach { (view) in
                view.alpha = 1
            }
        }
    }
}
