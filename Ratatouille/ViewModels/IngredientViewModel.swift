//
//  IngredientViewModel.swift
//  Ratatouille
//
//  Created by Sofija Solar on 04/12/2023.
//

import Foundation

class IngredientViewModel: ObservableObject {
    
    @Published var apiIngredients: [APIIngredient] = []
    
    private let apiClient = RecipeAPIClient.live
    
    func fetchIngredientsFromAPI() async {
        do {
            let apiIngredients = try await apiClient.getIngredients()
            DispatchQueue.main.async {
                self.apiIngredients = apiIngredients
            }
        } catch {
            print("Error fetching ingredients:", error)
        }
    }
    
    
}
