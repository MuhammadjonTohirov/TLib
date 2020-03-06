//
//  Logging.swift
//  uzcard trade
//
//  Created by muhammadjon on 14/11/2019.
//  Copyright © 2019 Plum Technologies. All rights reserved.
//

import Foundation

public enum LoggingType: String {
    case log = "log"
    case error = "error"
    case network = "network"
    case warning = "warning"
}

public class Logging {
    public var tag: String = "application"
    private var message: String = ""
    public var type: LoggingType = .log
    
    public static var shared: Logging = Logging()
    
    public func log(_ className: AnyClass, message: String, type: LoggingType = .log) {
        self.type = type
        log(String(describing: className.self), message: message, type: type)
    }
    
    public func log(_ tag: String? = nil, message: String, type: LoggingType = .log) {
        self.type = type
        if let tag = tag {
            self.tag = tag
        }
        self.message = message
        self.print_()
    }
    
    private func print_() {
        print("logger: \(self.tag)(\(self.type.rawValue)): \(message)")
        self.tag = "application"
        self.type = .log
    }
}
