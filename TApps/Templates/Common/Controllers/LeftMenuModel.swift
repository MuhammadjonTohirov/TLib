//
//  LeftMenuModel.swift
//  uzcard trade
//
//  Created by Muhammadjon Tohirov on 12/2/19.
//  Copyright © 2019 Plum Technologies. All rights reserved.
//

import Foundation

public class LeftMenuItem {
    public let id: Int
    public let title: String
    
    public private(set) var data: Data?
    
    public init(_ item: (id: Int, title: String)) {
        self.id = item.id
        self.title = item.title
    }
    
    public func set(data: Data) {
        self.data = data
    }
}


public class LeftMenuModel {
    public var items: [LeftMenuItem] = []
    
    public var defaults: [(Int, String)] {
        return [
            (0, "all"),
            (1, "tv"),
            (2, "computers"),
            (3, "audio techs")
        ]
    }
    
    public init(_ items: [LeftMenuItem] = []) {
        items.forEach { (item) in
            self.items.append(item)
        }
        self.items.sort(by: {$0.id < $1.id})
    }
}
