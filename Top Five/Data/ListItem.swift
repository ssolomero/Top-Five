//
//  ListItems.swift
//  Top Five
//
//  Created by Sharence Solomero on 5/5/20.
//  Copyright © 2020 Sharence Solomero. All rights reserved.
//

import Foundation
import RealmSwift

class ListItem: Object {
    @objc dynamic var itemName: String = ""
    
    var parentList = LinkingObjects(fromType: TopFiveList.self, property: "items")
}
