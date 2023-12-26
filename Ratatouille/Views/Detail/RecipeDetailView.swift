//
//  RecipeDetailView.swift
//  Ratatouille
//
//  Created by Sofija Solar on 24/11/2023.
//

import SwiftUI

struct RecipeDetailView: View {
    var recipe: APIMeal
    @StateObject private var viewModel = RecipeViewModel()
    
    
    var body: some View {
        ScrollView {

            AsyncImage(url: URL(string: recipe.strMealThumb ?? "https://www.themealdb.com/images/media/meals/sywswr1511383814.jpg")) { image in image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
            } placeholder: {
                Image(systemName: "photo")
                   .resizable()
                   .scaledToFit()

            }
            
            VStack(spacing: 30){
                Text("\(recipe.strMeal)")
                    .font(.largeTitle)
                    .bold()
                
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    if let detailedTags = viewModel.detailedRecipe?.strTags, !detailedTags.isEmpty {
                            TagView(tags: detailedTags)
                        } else if let recipeTags = recipe.strTags, !recipeTags.isEmpty {
                            TagView(tags: recipeTags)
                        }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Ingredienser")
                            .font(.headline)

                        let ingredientsCount = viewModel.detailedRecipe?.ingredients.count ?? recipe.ingredients.count
                            
                            ForEach(0..<ingredientsCount, id: \.self) { index in
                                let ingredient = viewModel.detailedRecipe?.ingredients[index] ?? recipe.ingredients[index]
                                let measurement = viewModel.detailedRecipe?.measurements[index] ?? recipe.measurements[index]

                                Text("\(ingredient) - \(measurement)")
                            }
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Fremgangsmåte")
                            .font(.headline)
                        if let detailedInstructions = viewModel.detailedRecipe?.strInstructions, !detailedInstructions.isEmpty {
                            Text(detailedInstructions)
                        } else if let recipeInstructions = recipe.strInstructions, !recipeInstructions.isEmpty {
                            Text(recipeInstructions)
                        }
                    }
                    
                    
                }
                    
                
            }
                .padding()
                .frame(maxWidth: .infinity)
            
            
        }
        .ignoresSafeArea(edges: .top)
        .onAppear{
            viewModel.fetchDetailedRecipe(byId: recipe.idMeal)
        }
    }
        
}

struct TagView: View {
    @State var tags: String
    
    
    var body: some View {
        let tagsArray = tags.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }


        return ScrollView(.horizontal, showsIndicators: false) {
            HStack{
                ForEach(tagsArray, id: \.self) { tag in
                    Text(tag)
                        .padding(7)
                        .padding(.horizontal, 5)
                        .background(Capsule().fill(.cyan))
                        .foregroundColor(.white)

                }
            }
                
        }
        
    }
    
    
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: APIMeal.demoMeals[1])
    }
}
