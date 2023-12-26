//
//  EditCategoriesViewModel.swift
//  Ratatouille
//
//  Created by Sofija Solar on 02/12/2023.
//

import Foundation
import CoreData
import SwiftUI

class CategoryViewModel: ObservableObject {

    @Published var apiCategories: [APICategory] = []

    private let apiClient = RecipeAPIClient.live
    

    func fetchCategoriesFromAPI() async {
        do {
            let apiCategories = try await apiClient.getCategories()
//            self.apiCategories = apiCategories //.map { APICategory(id: UUID(), name: $0) }
            DispatchQueue.main.async {
                self.apiCategories = apiCategories
            }
        } catch {
            print("Error fetching categories:", error)
        }
    }
    
    

}
