//
//  Item.swift
//  todoApp
//
//  Created by Marmago on 01/12/2020.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory =  LinkingObjects(fromType: Category.self, property: "items")
    
}
