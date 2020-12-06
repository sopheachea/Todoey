//
//  Objects.swift
//  Todoey
//
//  Created by sophea chea on 5/12/20.
//

import Foundation

class Items {
    var title : String = ""
    var done : Bool = false
    
    init(){}
    
    init(title: String){
        self.title = title
        self.done = false
    }
}
