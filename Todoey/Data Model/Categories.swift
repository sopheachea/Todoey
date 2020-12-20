//
//  Categories.swift
//  Todoey
//
//  Created by sophea chea on 19/12/20.
//

import Foundation
import RealmSwift

class Categories: Object {
    @objc dynamic var name: String = ""
    
    let items = List<Items>()
    
    
}
