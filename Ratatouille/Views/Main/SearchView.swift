//
//  SearchView.swift
//  Ratatouille
//
//  Created by Sofija Solar on 15/11/2023.
//

import SwiftUI

enum Criteria: String, CaseIterable, Identifiable {
    case area
    case category
    case ingredient
    case name
    
    var id: Criteria { self }
    
    var iconName: String {
        switch self {
        case .area: return "globe"
        case .category: return "rectangle.3.group.bubble.left"
        case .ingredient: return "carrot.fill"
        case .name: return "magnifyingglass"
        }
    }
}

struct CriterionData {
    var name: String
    // Add other properties you need for each criterion
    
    init(name: String) {
        self.name = name
    }
}

struct SearchView: View {
    
    @State private var selectedCriteria = Criteria.area
    @State private var criterionData: CriterionData?
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading) {
//                VStack {
                    Picker("Criteria", selection: $selectedCriteria) {
                        ForEach(Criteria.allCases) { criteria in
//                            Text(criteria.rawValue.capitalized)
                            Image(systemName: criteria.iconName)
                        }
                    }
                    .pickerStyle(.segmented)
//                    .padding()
                Text("Søk")
                    .font(.title)
                    .bold()
                    
                
                    // Additional views or controls based on the selected criterion
                    switch selectedCriteria {
                    case .area:
                        SearchByAreaView(recipes: [])
                    case .category:
                        SearchByCategoryView(recipes: [])
                    case .ingredient:
                        SearchByIngredientView()
                    case .name:
                        SearchByNameView()
                    }
                
               
                    
//                }
                
                Spacer()
            }
            .padding()
//            .navigationTitle("Søk")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
