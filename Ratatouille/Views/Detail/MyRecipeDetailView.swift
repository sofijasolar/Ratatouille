//
//  MyRecipeDetailView.swift
//  Ratatouille
//
//  Created by Sofija Solar on 03/12/2023.
//

import SwiftUI

struct MyRecipeDetailView: View {
    @ObservedObject var recipeManager = RecipeManager.shared
    
     var recipe: Meal
    
    
    @State private var isEditing: Bool = false
    
    init(recipeManager: RecipeManager, recipe: Meal) {
            self.recipeManager = recipeManager
            self.recipe = recipe
//            self._recipe = State(initialValue: recipe)
        }
    
    var body: some View {
        ScrollView {
            
            AsyncImage(url: URL(string: recipe.thumbnail ?? "https://www.themealdb.com/images/media/meals/sywswr1511383814.jpg")) { image in image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                
            }
            
            VStack(spacing: 30){
                Text("\(recipe.name ?? "")")
                    .font(.largeTitle)
                    .bold()
                
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    if let detailedTags = recipe.tags, !detailedTags.isEmpty {
                        TagView(tags: detailedTags)
                    }
                    Text(" – \(recipe.area ?? "") – " )
                    
                    
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Ingredienser")
                            .font(.headline)
                        
                        ForEach(0..<recipe.ingredientsArray.count, id: \.self) { index in
                            Text("\(recipe.ingredientsArray[index]) - \(recipe.measurementsArray[index])")
                        }
                        
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Fremgangsmåten")
                            .font(.headline)
                        if let detailedInstructions = recipe.instructions, !detailedInstructions.isEmpty {
                            Text(detailedInstructions)
                        }
                    }
                    
                    
                }
                
                NavigationLink(
                    destination: EditRecipeView(recipe: recipe),
                    isActive: $isEditing,
                    label: {
                        Text("Rediger matoppskrift")
                    }
                )
                .buttonStyle(.bordered)
                .cornerRadius(20)
                .onTapGesture {
                    isEditing = true
                }
                
                
            }
            .padding()
            .frame(maxWidth: .infinity)
            
            
        }
        .ignoresSafeArea(edges: .top)
        .onAppear{
            
            
        }
    }
    
}


