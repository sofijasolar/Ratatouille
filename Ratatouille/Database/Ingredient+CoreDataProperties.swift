//
//  Ingredient+CoreDataProperties.swift
//  Ratatouille
//
//  Created by Sofija Solar on 04/12/2023.
//
//

import Foundation
import CoreData


extension Ingredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredient> {
        return NSFetchRequest<Ingredient>(entityName: "Ingredient")
    }

    @NSManaged public var idIngredient: Int16
    @NSManaged public var isArchived: Bool
    @NSManaged public var name: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var index: Int16

}

extension Ingredient : Identifiable {

}
