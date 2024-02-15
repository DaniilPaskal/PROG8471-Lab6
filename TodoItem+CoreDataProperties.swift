//
//  TodoItem+CoreDataProperties.swift
//  Lab6
//
//  Created by user237236 on 2/15/24.
//
//

import Foundation
import CoreData


extension TodoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoItem> {
        return NSFetchRequest<TodoItem>(entityName: "TodoItem")
    }

    @NSManaged public var text: String?
    @NSManaged public var todoID: UUID?

}

extension TodoItem : Identifiable {

}
