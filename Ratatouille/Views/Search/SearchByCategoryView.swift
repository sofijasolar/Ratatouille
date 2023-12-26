//
//  CategoryView.swift
//  Ratatouille
//
//  Created by Sofija Solar on 01/12/2023.
//

import SwiftUI

struct SearchByCategoryView: View {
    
    let apiClient = RecipeAPIClient.live
    
    @State var recipes: [APIMeal] = []
    
    @Environment(\.managedObjectContext) private var viewContext
    
        @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)], predicate: NSPredicate(format: "isArchived == %@", NSNumber(value: false)),
            animation: .default)
        private var databaseCategories: FetchedResults<Category>
    
    @State private var selectedCategory : Category?
    @State private var selectedCategoryId: Int16 = 0
    @State private var isCategorySelected = false
    
    
    func onSearch(categoryId: Int16){
        if categoryId > 0 {
            Task {
                do {
                    let category = databaseCategories.first { $0.id == categoryId }
                    let recipes = try await apiClient.getRecipesByCategory(category?.name ?? "")
                    DispatchQueue.main.async {
                        self.recipes = recipes
                    }
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
        
        // alert here? if its saved or something went wrong? 
    }
    
    var body: some View {

            List {
                Picker("Kategori", selection: $selectedCategoryId) {
                    ForEach(databaseCategories){ category in
                        Text(category.name ?? "")
                            .tag(category.id)
                    }
                }
                .onChange(of: selectedCategoryId) { newCategoryId in
                    onSearch(categoryId: newCategoryId)
                    isCategorySelected = true
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
                if !isCategorySelected {
                    // Only set the default category if none is selected
                    selectedCategoryId = databaseCategories.first?.id ?? 0
                }
            }
            
    }
    
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchByCategoryView(recipes: APIMeal.demoMeals)
            
        }
        
    }
}
