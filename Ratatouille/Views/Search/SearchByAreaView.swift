//
//  SearchAreaView.swift
//  Ratatouille
//
//  Created by Sofija Solar on 03/12/2023.
//

import SwiftUI

struct SearchByAreaView: View {
    
    let apiClient = RecipeAPIClient.live
    
    @State var recipes: [APIMeal] = []
    
    @Environment(\.managedObjectContext) private var viewContext
    
        @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Area.area, ascending: true)],
            predicate: NSPredicate(format: "isArchived == %@", NSNumber(value: false)),
            animation: .default)
        private var databaseAreas: FetchedResults<Area>
    
    @State private var selectedArea : Area?
//    @State private var selectedAreaId: Area.ID?
    @State private var selectedAreaTag: Int?
    @State private var isAreaSelected = false
    
    func onSearch(area: String){
//        if categoryId > 0 {
            Task {
                do {
                    
                    let recipes = try await apiClient.getRecipesByArea(area)
                    DispatchQueue.main.async {
                        self.recipes = recipes
                    }
                } catch let error {
                    print("Error fetching recipes by category: \(error)")
                    // Display an alert or log it
                }
            }
//        }
    }
    
    private func saveRecipe(recipe: APIMeal) {
        print("save recipe clicked")
        Task {
            await RecipeManager.shared.saveRecipeToDB(recipe)
        }
        
        // alert here? (visually) if its saved or something went wrong?
    }
    
    var body: some View {
        List {
            Picker("Landområde", selection: $selectedAreaTag) {
                ForEach(databaseAreas){ area in
                    Text(area.area ?? "")
                        .tag(area.area?.hashValue)
                }
            }
//            .onChange(of: selectedArea) { newSelectedArea in
//                    guard let area = newSelectedArea else { return }
//                    onSearch(area: area.area ?? "")
//                    isAreaSelected = true
//                }
            .onChange(of: selectedAreaTag) { newSelectedAreaTag in
                    if let selectedArea = databaseAreas.first(where: { $0.area?.hashValue == newSelectedAreaTag }) {
                        onSearch(area: selectedArea.area ?? "")
                    }
                isAreaSelected = true
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
            if !isAreaSelected {
                // Only set the default area if none is selected
//                selectedArea = databaseAreas.first
                if selectedArea == nil {
                    selectedAreaTag = databaseAreas.first?.area?.hashValue
                }
            }
            
        }
    }
}

struct SearchAreaView_Previews: PreviewProvider {
    static var previews: some View {
        SearchByAreaView()
    }
}
