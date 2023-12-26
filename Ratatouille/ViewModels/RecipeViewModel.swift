//
//  RecipeDetailViewModel.swift
//  Ratatouille
//
//  Created by Sofija Solar on 02/12/2023.
//

import Foundation

class RecipeViewModel: ObservableObject {
    @Published var detailedRecipe: APIMeal?

    private let apiClient = RecipeAPIClient.live

    func fetchDetailedRecipe(byId id: String) {
        Task {
            do {
                let detailedRecipe = try await apiClient.getMealById(id)
                DispatchQueue.main.async {
                    self.detailedRecipe = detailedRecipe
                }
            } catch let error {
                print("Error fetching detailed recipe:", error)
            }
        }
    }
    
//    func fetchRecipesByName(byName name: String){
//        Task {
//            do {
//
//            }catch let error {
//
//            }
//        }
//    }
    
    
}
