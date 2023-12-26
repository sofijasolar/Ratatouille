//
//  AreaViewModel.swift
//  Ratatouille
//
//  Created by Sofija Solar on 03/12/2023.
//

import Foundation

class AreaViewModel: ObservableObject {
    
    @Published var apiAreas: [APIArea] = []
    
    private let apiClient = RecipeAPIClient.live
    
    func fetchAreasFromAPI() async {
        do {
            let apiAreas = try await apiClient.getAreas()
            DispatchQueue.main.async {
                self.apiAreas = apiAreas
            }
        } catch {
            print("Error fetching areas:", error)
        }
    }
    
    
    
}
