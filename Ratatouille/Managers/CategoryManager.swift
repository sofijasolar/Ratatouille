//
//  CategoryManager.swift
//  Ratatouille
//
//  Created by Sofija Solar on 03/12/2023.
//

import Foundation
import CoreData

class CategoryManager {
    static let shared = CategoryManager()

    private let context = PersistenceController.shared.container.viewContext

    func editCategory(category: Category, isArchived: Bool) {
        do {
            category.isArchived = isArchived
            
            try context.save()
            print("Category updated successfully: \(category)")
        } catch {
            print("Error editing category:", error)
        }
    }
    
    func fetchNonArchivedCategories() -> [Category] {
            let request: NSFetchRequest<Category> = Category.fetchRequest()
            request.predicate = NSPredicate(format: "isArchived == %@", NSNumber(value: false))
            do {
                return try context.fetch(request)
            } catch {
                print("Error fetching non-archived categories:", error)
                return []
            }
        }
    
    func deleteCategory(category: Category){
        do {
            context.delete(category)
            try context.save()
            print("Category deleted successfully: \(category)")
        }catch {
            print("Error deleting category:", error)
        }
    }
    
    
}

