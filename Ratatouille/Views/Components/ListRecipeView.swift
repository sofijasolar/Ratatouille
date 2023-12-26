//
//  ListRecipeView.swift
//  Ratatouille
//
//  Created by Sofija Solar on 01/12/2023.
//

import SwiftUI

struct ListRecipeView: View {
    
    let recipe : APIMeal
    
    init(recipe: APIMeal) {
            self.recipe = recipe
        }
    
    var body: some View {
        HStack {
            
            AsyncImage(url: URL(string: recipe.strMealThumb ?? "https://www.themealdb.com/images/media/meals/sywswr1511383814.jpg"))
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
                Text("\(recipe.strMeal)")
                    .padding(8)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            
            
            Spacer()
            
        }
    }
    
    
}


struct ListRecipeView_Previews: PreviewProvider {
    static var previews: some View {
    
        ListRecipeView(recipe: APIMeal.demoMeals[0])
    }
}
