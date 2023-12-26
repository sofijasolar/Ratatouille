//
//  Meal+CoreDataProperties.swift
//  Ratatouille
//
//  Created by Sofija Solar on 03/12/2023.
//
//

import Foundation
import CoreData


extension Meal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meal> {
        return NSFetchRequest<Meal>(entityName: "Meal")
    }

    @NSManaged public var area: String?
    @NSManaged public var category: String?
    @NSManaged public var idMeal: Int32
    @NSManaged public var instructions: String?
    @NSManaged public var isArchived: Bool
    @NSManaged public var isFavorite: Bool
    @NSManaged public var name: String?
    @NSManaged public var tags: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var measurements: String?
    @NSManaged public var areaRelationship: Area?
    @NSManaged public var categoryRelationship: Category?
    @NSManaged public var ingredients: NSSet?
    
    
    
    /// variables made to make UI implementation easier
    var ingredientsArray: [String] {
//        guard let mealIngredients = ingredients as? Set<Ingredient> else {
//            return []
//        }
//        return mealIngredients.map { $0.name ?? "" }
        guard let mealIngredients = ingredients as? Set<Ingredient> else {
            return []
        }
        let sortedIngredients = mealIngredients.sorted { $0.index < $1.index }
        return sortedIngredients.map { $0.name ?? "" }
    }


    var measurementsArray: [String] {
        return measurements?.components(separatedBy: ", ") ?? []
    }

}

// MARK: Generated accessors for ingredients
extension Meal {

    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: Ingredient)

    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: Ingredient)

    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSSet)

    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSSet)

}

extension Meal : Identifiable {

}
