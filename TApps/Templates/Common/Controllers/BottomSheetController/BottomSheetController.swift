//
//  BottomSheetController.swift
//  uzcard trade
//
//  Created by Muhammadjon Tohirov on 1/28/20.
//  Copyright © 2020 Plum Technologies. All rights reserved.
//

import UIKit

public final class BottomSheetController<T>: TransparentViewController where T: BaseViewController {
    public var sheetView: TView = TView()
    
    public var containerController: T?
    
    private var handlerView: TView = TView()
    
    public var defaultHeight: CGFloat!
    
    public var sheetViewDiff: CGFloat = 0
    
    private var sheetViewState: UIGestureRecognizer.State = .possible
    
    private var needToClose: Bool = false
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    public override func initialize() {
        super.initialize()
        containerView.backgroundColor = theme.bootmSheetContainerColor
        handlerView.backgroundColor = theme.bootmSheetHandlerColor
        sheetView.backgroundColor = theme.bottomSheetBackgroundColor
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture(_:)))
        sheetView.addGestureRecognizer(gesture)

        sheetView.shadowColor = UIColor.black.withAlphaComponent(0.2)
        sheetView.shadowRadius = 10

        containerView.addGestureRecognizer(gesture)
        
        onViewAppear = {
            self.addSubview(self.sheetView)
            self.sheetView.addSubviews(views: self.unwrappedContainer().view)
            self.sheetView.addSubviews(views: self.handlerView)
            self.addChild(self.unwrappedContainer())
        }
        
        didViewDisappear = {


            self.unwrappedContainer().removeFromParent()
            self.sheetView.removeFromSuperview()
        }
        
//        self.sheetView.onClick(self, #selector(onClickBody))
    }
    
    public override func updateSubviewFrames(_ size: CGSize) {
        super.updateSubviewFrames(size)
        self.view.backgroundColor = .clear
        var x: CGFloat = 0
        var h: CGFloat = defaultHeight - sheetViewDiff
        var y: CGFloat = size.height - h
        var w: CGFloat = size.width - 2 * x
        if sheetViewState == .ended {
            
            UIView.animate(withDuration: 0.11, animations: {
                self.sheetView.frame = CGRect(x: x, y: y, width: w, height: h)
                self.containerView.alpha = self.needToClose ? 0 : 1
                self.sheetView.alpha = self.needToClose ? 0 : 1
            }) { (_) in
                if self.needToClose {
                    self.onClickBack()
                }
            }
        } else {
            sheetView.frame = CGRect(x: x, y: y, width: w, height: h)
        }
        
        sheetView.roundCorners(corners: [.topLeft, .topRight], radius: 12)
        
        y = 20
        x = 0
        h = sheetView.height - y + sheetViewDiff
        w = sheetView.width
        unwrappedContainer().view.frame = CGRect(x: x, y: y, width: w, height: h)
        
        y = 8
        w = 40
        x = (sheetView.width - w) / 2
        h = 4
        handlerView.frame = CGRect(x: x, y: y, width: w, height: h)
        handlerView.radius = h / 2
    }
    
    @objc func panGesture(_ gesture: UIPanGestureRecognizer) {
        self.sheetViewState = gesture.state
        
        switch gesture.state {
        case .changed:
            let point = gesture.translation(in: containerView)
            let velocity = gesture.velocity(in: containerView)
            
            #if DEBUG
            logger.log("velocity", message: "\(velocity)")
            logger.log("coordinate", message: "\(point)")
            #endif
            
            self.sheetViewDiff = point.y
            self.needToClose = !(self.sheetViewDiff >= 0 && self.sheetViewDiff <= self.sheetView.height / 2)

            if self.sheetViewDiff < 0 {
                self.needToClose = false
                self.sheetViewDiff = 0
            } else {
                let percentage = self.sheetViewDiff / self.sheetView.height
                self.containerView.alpha = (1 - percentage)
                self.sheetView.alpha = 1
            }
            
            if velocity.y >= 600 {
                self.needToClose = true
                self.view.setNeedsLayout()
                return
            }
            
            self.view.setNeedsLayout()
            
        case .ended:
            #if DEBUG
            logger.log("gesture", message: "ended")
            #endif
            
            self.sheetViewDiff = needToClose ? self.defaultHeight : 0
            self.view.setNeedsLayout()
            
        default:
            break
        }
    }
    
    @objc func onClickBody() {
        // empty
    }
    
    public override func onClickBack() {
        super.onClickBack()
        UIView.animate(withDuration: 0.33, animations: {
            self.sheetView.alpha = 0
        }) { (_) in
        }
    }
    
    public func setupContainer(controller: T) {
        self.containerController = controller
        self.defaultHeight = UIScreen.main.bounds.height / 2
    }
    
    public func setHeight(_ height: CGFloat) {
        self.defaultHeight = height
    }
    
    private func unwrappedContainer() -> T {
        guard let container = self.containerController else {
            fatalError("you did not set container controller")
        }
        
        return container
    }
}
