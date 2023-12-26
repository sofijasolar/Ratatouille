//
//  Category+CoreDataProperties.swift
//  Ratatouille
//
//  Created by Sofija Solar on 02/12/2023.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var isArchived: Bool

}

extension Category : Identifiable {

}

/// CategoryProtocol is used in order to use one same view on both APICategory object and Category model from the database
extension Category: CategoryProtocol {
    
    var categoryId: Int16 {
        return self.id
    }
    
    var categoryName: String? {
        return self.name
    }
    var categoryThumbnail: String? {
            return self.thumbnail
        }
    
    
}

