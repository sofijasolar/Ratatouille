//
//  RecipeManager.swift
//  Ratatouille
//
//  Created by Sofija Solar on 02/12/2023.
//

import Foundation
import CoreData

class RecipeManager: ObservableObject {
    
    static let shared = RecipeManager()

    private let context = PersistenceController.shared.container.viewContext // your managed object context

    @Published var recipes: [Meal] = []
    
    
    func fetchSavedRecipes() -> [Meal] {
        do {
            return try  context.fetch(Meal.fetchRequest())
        } catch {
            print("Error fetching saved recipes: \(error)")
            return []
        }
    }
    
    func fetchRecipeById(_ id: Int32) -> Meal? {
            return recipes.first { $0.idMeal == id }
        }
    
    func saveRecipeToDB(_ apiMeal: APIMeal) async {
        let apiClient = RecipeAPIClient.live
        let moc = PersistenceController.shared.container.viewContext
        do {
            let recipes = try moc.fetch(Meal.fetchRequest())
            
            if recipes.contains(where: { $0.idMeal == Int32(apiMeal.idMeal) }){
                throw NSError(domain: "Exists already", code: 0, userInfo: nil)
            } else {
                let detailedRecipe = try await apiClient.getMealById(apiMeal.idMeal)
                
                let meal = Meal(context: moc)
                meal.idMeal = Int32( apiMeal.id)!
                meal.name = detailedRecipe.strMeal
                meal.area = detailedRecipe.strArea
                meal.category = detailedRecipe.strCategory
                meal.instructions = detailedRecipe.strInstructions
                meal.thumbnail = detailedRecipe.strMealThumb
                meal.tags = detailedRecipe.strTags
                meal.isArchived = false
                meal.isFavorite = false
                // Handle empty measurements by replacing them with an empty string
                meal.measurements = detailedRecipe.measurements.map { $0.isEmpty ? "" : $0 }.joined(separator: ", ")

//                meal.measurements = detailedRecipe.measurements.joined(separator: ", ")
                
                let ingredientSet = NSMutableSet()
                
                for (index, ingredient) in detailedRecipe.ingredients.enumerated() {
                    let ingredientEntity = Ingredient(context: context)
                    ingredientEntity.name = ingredient
                    ingredientEntity.index = Int16(index)
                    ingredientSet.add(ingredientEntity)
                }
                
                meal.ingredients = ingredientSet
                
                
                do {
                    try moc.save()
                    print("Recipe saved to the database.")
                } catch {
                    print("Error saving recipe:", error)
                }
                
            }
        }catch let error as NSError {
            print("Error saving recipe to the database:", error)
            // Handle the error, you can show an alert or perform other actions here
        } catch {
            print("Unexpected error saving recipe to the database.")
            // Handle other unexpected errors here
        }

    }
    
    func editRecipeArchiveStatus(recipe: Meal, isArchived: Bool) {
        do {
            recipe.isArchived = isArchived
            
            try context.save()
            print("Recipe updated successfully: \(recipe)")
        } catch {
            print("Error editing category:", error)
        }
    }
    
    func toggleRecipeFavoriteStatus(recipe: Meal) {
            do {
                recipe.isFavorite.toggle()
                try context.save()
                print("Recipe updated successfully: \(recipe)")
            } catch {
                print("Error editing recipe:", error)
            }
        }
    
    func updateRecipe(recipeId: Int32, newName: String, newArea: String, newIngredients: [String], newMeasurements: [String], newInstructions: String){
        do {
            // fetching data again to ensure that data is most accurate and updated
            
                let fetchRequest: NSFetchRequest<Meal> = Meal.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "idMeal == %d", recipeId)
                
                let recipes = try context.fetch(fetchRequest)
                
                if let recipeToUpdate = recipes.first {
                    // Update recipe properties
                    recipeToUpdate.name = newName
                    recipeToUpdate.area = newArea
                    recipeToUpdate.instructions = newInstructions
                    recipeToUpdate.measurements = newMeasurements.joined(separator: ", ")
                    
                    // Clear existing ingredients and add new ingredients
//                    let newIngredientSet = NSMutableSet()
//                    for (_, ingredient) in newIngredients.enumerated() {
//                        let ingredientEntity = Ingredient(context: context)
//                        ingredientEntity.name = ingredient
//                        newIngredientSet.add(ingredientEntity)
//                    }
//
//                    recipeToUpdate.ingredients = newIngredientSet
                    
                    if let existingIngredients = recipeToUpdate.ingredients {
                        // Clear existing ingredients
                        for case let ingredient as Ingredient in existingIngredients {
                            context.delete(ingredient)
                        }
                    }

                    // Add new ingredients with preserving the order
                    for (index, ingredient) in newIngredients.enumerated() {
                        let ingredientEntity = Ingredient(context: context)
                        ingredientEntity.name = ingredient
                        ingredientEntity.index = Int16(index)
                        recipeToUpdate.addToIngredients(ingredientEntity)
                    }
                    
                    try context.save()
                    print("Recipe updated successfully: \(recipeToUpdate)")
                } else {
                    print("Recipe not found with ID: \(recipeId)")
                }
            } catch {
                print("Error updating recipe:", error)
            }
        
    }
    
    func deleteRecipe(recipe: Meal){
        do {
            context.delete(recipe)
            try context.save()
            print("Recipe deleted successfully: \(recipe)")
        }catch {
            print("Error deleting recipe:", error)
        }
    }
}
