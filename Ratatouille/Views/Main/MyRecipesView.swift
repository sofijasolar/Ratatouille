//
//  MyRecipesView.swift
//  Ratatouille
//
//  Created by Sofija Solar on 15/11/2023.
//

import SwiftUI

struct MyRecipesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    //fetch unarchived/saved recipes
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Meal.name, ascending: true)], predicate: NSPredicate(format: "isArchived == %@", NSNumber(value: false)),
        animation: .default)
    
    private var recipes: FetchedResults<Meal>
    
    func archiveRecipe(recipe: Meal){
        RecipeManager.shared.editRecipeArchiveStatus(recipe: recipe, isArchived: true)
        
    }
    
    func toggleFavoriteRecipe(recipe: Meal){
        RecipeManager.shared.toggleRecipeFavoriteStatus(recipe: recipe)
        print(recipe)
    }
    
    
    
    var body: some View {
        NavigationView {
            if recipes.isEmpty{
                NoRecipesView()
            }else {
                List{
                    ForEach(recipes) { recipe in
                        HStack{
                            NavigationLink {
                                MyRecipeDetailView(recipeManager: RecipeManager.shared, recipe: recipe)
                            } label: {
                                ListMyRecipeView(recipe: recipe)
                                    .swipeActions(edge: .leading) {
                                        Button {
                                            toggleFavoriteRecipe(recipe: recipe)
                                        } label: {
                                            Label("Favorite", systemImage: "star")
                                        }
                                        .tint(.yellow)
                                    }
                                    .swipeActions (edge: .trailing){
                                        Button {
                                            archiveRecipe(recipe: recipe)
                                            
                                        } label: {
                                            Label("Archive", systemImage: "archivebox.fill")
                                        }
                                        .tint(.blue)
                                    }
                            }//nav
                            
                            
                        }//HStack
                        .padding(.horizontal)
                        .padding(.vertical, 2)
                    }// for each
                    
                    
                
                }//list
//                                .listStyle(.plain)
                .navigationTitle("Ratatouille")
                .navigationBarItems(trailing:
                                        Image("ratatouille-badge")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 60))
            }
            
            
        }
        
        
    }
    
    
}


struct ListMyRecipeView: View {

    let recipe : Meal
    @State private var isFavorite : Bool

    init(recipe: Meal) {
            self.recipe = recipe
            self._isFavorite = State(initialValue: recipe.isFavorite)
        }

    var body: some View {
        HStack {

            AsyncImage(url: URL(string: recipe.thumbnail ?? "https://www.themealdb.com/images/media/meals/sywswr1511383814.jpg"))
            { image in image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
            }
            placeholder: {
                Image(systemName: "photo")
                   .resizable()
                   .scaledToFit()

            }
                .frame(width: 100, height: 100)
                .cornerRadius(10)
                .clipped()

            VStack(alignment: .leading){
                Text("\(recipe.name ?? "")")
                    .padding(8)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                Spacer()
            }

            Spacer()
            // if recipe favorite show an icon of star filled in yellow
            if isFavorite {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
        }
        .onChange(of: recipe.isFavorite) { newValue in
                    isFavorite = newValue
                }
        
    }


}

struct NoRecipesView: View {
    
    var body: some View {
        VStack {
            
            Image(systemName: "square.stack.3d.up.slash")
                
            Text("Ingen matoppskrifter")
                .navigationTitle("Ratatouille")
        }
    }
}
