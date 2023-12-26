//
//  IngredientManager.swift
//  Ratatouille
//
//  Created by Sofija Solar on 03/12/2023.
//

import Foundation
class IngredientManager {
    static let shared = IngredientManager()

    private let moc = PersistenceController.shared.container.viewContext
    
    func saveIngredientToDB(_ apiIngredient: APIIngredient) {
        
        do {
            let databaseIngredients = try moc.fetch(Ingredient.fetchRequest())
            
            if databaseIngredients.contains(where: { $0.idIngredient == apiIngredient.id }){
                throw NSError(domain: "Ingredient already exists", code: 0, userInfo: nil)
            } else {

                let newIngredient = Ingredient(context: moc)
                newIngredient.idIngredient = Int16(apiIngredient.id)
                newIngredient.name = apiIngredient.name
                newIngredient.isArchived = false
                
                let encodedIngredientString = apiIngredient.name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                newIngredient.thumbnail = "https://www.themealdb.com/images/ingredients/\(encodedIngredientString)-Small.png"
                
                do {
                    try moc.save()
                    print("Ingredient saved to the database. \(newIngredient)")
                } catch {
                    print("Error saving ingredient:", error)
                }
                
            }
        } catch let error as NSError {
            print("Error saving ingredient to the database:", error)
            // Handle the error, you can show an alert or perform other actions here
        } catch {
            print("Unexpected error saving ingredient to the database.")
            // Handle other unexpected errors here
        }
    }
    
    func editIngredientArchiveStatus(ingredient: Ingredient, isArchived: Bool) {
        do {
            ingredient.isArchived = isArchived
            
            try moc.save()
            print("ingredient updated successfully: \(ingredient)")
        } catch {
            print("Error editing ingredient:", error)
        }
    }
    
    func deleteIngredient(ingredient: Ingredient){
        do {
            moc.delete(ingredient)
            try moc.save()
            print("ingredient deleted successfully: \(ingredient)")
        }catch {
            print("Error deleting ingredient:", error)
        }
    }
    
    
    
}
