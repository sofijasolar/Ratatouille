//
//  Area+CoreDataProperties.swift
//  Ratatouille
//
//  Created by Sofija Solar on 02/12/2023.
//
//

import Foundation
import CoreData


extension Area {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Area> {
        return NSFetchRequest<Area>(entityName: "Area")
    }

    @NSManaged public var area: String?
    @NSManaged public var isArchived: Bool
    @NSManaged public var flag: String?

}

extension Area : Identifiable {

}
