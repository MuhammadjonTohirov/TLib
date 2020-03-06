//
//  AlertView.swift
//  uzcard trade
//
//  Created by muhammadjon on 14/11/2019.
//  Copyright © 2019 Plum Technologies. All rights reserved.
//

import UIKit

public typealias Action = () -> ()

open class AlertView: NSObject, UIAlertViewDelegate {
    
    fileprivate var title: String?
    fileprivate var message: String?
    fileprivate var actions: Array<Action> = []
    fileprivate var names: Array<String> = []
    
    fileprivate var isAlert: Bool = false
    
    fileprivate var positiveAction: Action!
    
    open func title(_ title: String) -> AlertView {
        self.title = title
        return self
    }
    
    open func message(_ message: String) -> AlertView {
        self.message = message
        return self
    }
    
    fileprivate func optionPrivate(_ name: String, action: @escaping Action) -> AlertView {
        self.names.append(name)
        self.actions.append(action)
        return self
    }
    
    open func option(_ name: String, action: @escaping Action) -> AlertView {
        return optionPrivate(name, action: action)
    }
    
    open func optionEntity<T>(_ values: Array<T>, action: ActionFacade<T>) -> AlertView {
        for val: T in values {
            _ = self.optionPrivate(action.getName(val), action: { () -> () in
                action.apply(val)
            })
        }
        
        return self
    }
    
    open func show(_ controller: UIViewController) {
        self.show(controller, positiveAction: nil)
    }
    
    open func show(_ controller: UIViewController, positiveAction: Action?) {
        self.show(controller, positiveAction: positiveAction, isAlert: false)
    }
    
    open func showAlert(_ controller: UIViewController, positiveAction: Action?) {
        self.show(controller, positiveAction: positiveAction, isAlert: true)
    }
    
    fileprivate func show(_ controller: UIViewController, positiveAction: Action?, isAlert: Bool) {
        self.isAlert = isAlert
        let title = self.title
        let message = self.message
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        if self.names.count > 0 {
            alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
            
            if let _ = positiveAction {
                fatalError("Unsupported")
            }
            
            for (index, name) in self.names.enumerated() {
                let action = UIAlertAction(title: name, style: UIAlertAction.Style.default, handler: { (a: UIAlertAction) -> Void in
                    self.actions[index]()
                })
                alert.addAction(action)
            }
            
            let negative = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (a: UIAlertAction) -> Void in
                alert.dismiss(animated: true, completion: nil)
            })
            alert.addAction(negative)
            
        } else if let pA = positiveAction {
            if isAlert {
                let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (a: UIAlertAction) -> Void in
                    pA()
                })
                alert.addAction(action)
            } else {
                let positive = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { (a: UIAlertAction) -> Void in
                    pA()
                })
                alert.addAction(positive)
                let negative = UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { (a: UIAlertAction) -> Void in
                    alert.dismiss(animated: true, completion: nil)
                })
                alert.addAction(negative)
            }
        } else {
            let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (a: UIAlertAction) -> Void in
                alert.dismiss(animated: true, completion: nil)
            })
            alert.addAction(action)
        }
        
        controller.present(alert, animated: true, completion: nil)
        self.positiveAction = positiveAction
    }
}

public struct ActionFacade<T> {
    public typealias getClosure = ((_ value: T) -> String)
    public typealias applyClosure = ((_ value: T) -> Void)
    
    public let getName: getClosure!
    public let apply: applyClosure!
    
    public init (getName: @escaping getClosure, apply: @escaping applyClosure) {
        self.getName = getName
        self.apply = apply
    }
}


