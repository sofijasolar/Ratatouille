//
//  SearchByNameView.swift
//  Ratatouille
//
//  Created by Sofija Solar on 02/12/2023.
//

import SwiftUI

struct SearchByNameView: View {
    
    @State var mealInput: String = ""
    
    let apiClient = RecipeAPIClient.live
    
    @State var recipes: [APIMeal] = []
    
    func searchRecipes()  {
        Task {
            do {
                if !mealInput.isEmpty {
                    let encodedName = mealInput.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                    let result = try await apiClient.getRecipesByName(encodedName)
                    recipes = result
                } else {
                    // Handle empty search input if needed
                    recipes = []
                }
            } catch {
                // Handle errors
                print("Error searching recipes:", error)
            }
        }
            
        }
    
    func saveRecipe(recipe: APIMeal) {
         Task {
             await RecipeManager.shared.saveRecipeToDB(recipe)
         }
    }
    
    var body: some View {
        NavigationStack {
            List {
                TextField("Søk matoppskrift", text: $mealInput)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.cyan, lineWidth: 2)
                    )
                    .onChange(of: mealInput, perform: { newValue in
                        searchRecipes()
                        
                    })
                    .autocorrectionDisabled()
                ForEach(recipes){ recipe in
                    NavigationLink {
                        RecipeDetailView(recipe: recipe)
                    } label: {
                        ListRecipeView(recipe: recipe)
                            
                    }
                    .swipeActions (edge: .trailing){
                        Button {
                            saveRecipe(recipe: recipe)
                        } label: {
                            Label("Save", systemImage: "square.grid.3x1.folder.fill.badge.plus")
                        }
                        .tint(.blue)
                    }
                    
                }
            }
//            .border(.blue)
            .listStyle(.plain)
            
            
            
                
            
        }
    }
}

struct SearchByNameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchByNameView(recipes: APIMeal.demoMeals)
        }
    }
}
