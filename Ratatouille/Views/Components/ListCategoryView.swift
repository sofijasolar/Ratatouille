//
//  ListCategoryView.swift
//  Ratatouille
//
//  Created by Sofija Solar on 02/12/2023.
//

import SwiftUI

struct ListCategoryView<T: CategoryProtocol>: View {
    
    let category : T
    
    var body: some View {
        HStack {
            
            AsyncImage(url: URL(string: category.categoryThumbnail ?? "https://www.themealdb.com/images/media/meals/sywswr1511383814.jpg"))
            { image in image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        placeholder: {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
            
        }
        .frame(width: 50, height: 50)
        .cornerRadius(50)
        .clipped()
            
            VStack(alignment: .leading){
                Text("\(category.categoryName ?? "")")
                    .padding(8)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            
            
            Spacer()
        }
    }
}

struct ListCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        ListCategoryView(category: APICategory.demoCategories[0])
    }
}
