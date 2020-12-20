//
//  Items.swift
//  Todoey
//
//  Created by sophea chea on 19/12/20.
//

import Foundation
import RealmSwift

class Items : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    var parentCategories = LinkingObjects(fromType: Categories.self, property: "items")
}
