//
//  SearchByIngredientView.swift
//  Ratatouille
//
//  Created by Sofija Solar on 04/12/2023.
//

import SwiftUI

struct SearchByIngredientView: View {
    
    let apiClient = RecipeAPIClient.live
    
    @State var recipes: [APIMeal] = []
    
    @Environment(\.managedObjectContext) private var viewContext
    
        @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Ingredient.name, ascending: true)], predicate: NSPredicate(format: "isArchived == %@", NSNumber(value: false)),
            animation: .default)
        private var databaseIngredients: FetchedResults<Ingredient> // only ones manually saved and unarchived
    
    @State private var selectedIngredient : Ingredient?
    @State private var selectedIngredientId: Int16 = 0
    @State private var isIngredientSelected = false
    
    

    
    func onSearch(ingredientId: Int16){
        if ingredientId > 0 {
            Task {
                do {
                    let ingredient = databaseIngredients.first { $0.idIngredient == ingredientId }
                    let encodedIngredient = ingredient?.name?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                    let result = try await apiClient.getRecipesByIngredient(encodedIngredient)
                    recipes = result
                } catch let error {
                    print("Error fetching recipes by category: \(error)")
                    // Display an alert or log it
                }
            }
        }
    }
    
    private func saveRecipe(recipe: APIMeal) {
        print("save recipe clicked")
        Task {
            await RecipeManager.shared.saveRecipeToDB(recipe)
        }
        
    }
    
    var body: some View {
        List {
            Picker("Ingrediens", selection: $selectedIngredientId) {
                ForEach(databaseIngredients){ ingredient in
                    Text(ingredient.name ?? "")
                        .tag(ingredient.idIngredient)
                }
            }
            .onChange(of: selectedIngredientId) { newIngredientId in
                onSearch(ingredientId: newIngredientId)
                isIngredientSelected = true
            }
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
                
            } // forEach
            
            
        }// list
        .listStyle(.plain)
        .onAppear {
            if !isIngredientSelected {
                // Only set the default category if none is selected
                selectedIngredientId = databaseIngredients.first?.idIngredient ?? 0
            }
        }
    }
}

struct SearchByIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        SearchByIngredientView()
    }
}
