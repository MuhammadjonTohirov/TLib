//
//  PViewToPresenter.swift
//  TApps
//
//  Created by INTECH on 3/11/20.
//  Copyright © 2020 INTECH. All rights reserved.
//

import Foundation

/// a view presenter
public protocol PViewToPresenter: class {
    func viewDidLoad()
    func viewWillAppear()
    func onDismiss()
}

extension PViewToPresenter {
    public func viewDidLoad() {
        logger.log(message: "not implemented")
    }
    
    public func viewWillAppear() {
        logger.log(message: "not implemented")
    }
    
    public func onDismiss() {
        logger.log(message: "not implemented")
    }
}

/// a connector between a presenter and view, should have a variable inside the view
public protocol PPresenterToView: class {
    func showLoader()
    func hideLoader()
    func showAlert(title: String, message: String)
    func showAlert(message: String, completion: @escaping Completion<Bool, Void>)
    func showLoader(title: String)
}

extension PPresenterToView {
    public func showLoader() {
        logger.log(message: "not implemented")
    }
    
    public func hideLoader() {
        logger.log(message: "not implemented")
    }
    
    public func showAlert(title: String, message: String) {
        logger.log(message: "not implemented")
    }
    
    public func showAlert(message: String, completion: @escaping Completion<Bool, Void>) {
        logger.log(message: "not implemented")
    }
    
    public func showLoader(title: String) {
        logger.log(message: "not implemented")
    }
}

/// an interactor to a presenter
public protocol PPresenterToInteractor: class {
    
}

/// a connector between a presenter and an interface, should have a variable inside the interactor
public protocol PInteractorToPesenter: class {
    
}

public protocol PPresenterToRouter: class {
    
}

public protocol PRouterToPresenter: class {
    
}
