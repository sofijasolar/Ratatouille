//
//  AddIngredientSheetView.swift
//  Ratatouille
//
//  Created by Sofija Solar on 04/12/2023.
//

import SwiftUI

struct AddIngredientSheetView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Ingredient.name, ascending: true)], predicate: NSPredicate(format: "isArchived != nil AND (isArchived == %@ OR isArchived == %@)", NSNumber(value: false), NSNumber(value: true)),
        animation: .default) // false, the ones with relationship to meal have isArchived as null.
    private var manuallySavedIngredients: FetchedResults<Ingredient>
    
    let ingredients: [APIIngredient]
    @Binding var isPresented: Bool
    
    func saveIngredientTapped(ingredient: APIIngredient){
        print("Clicked save ingredient")
        IngredientManager.shared.saveIngredientToDB(ingredient)
        
    }
   
    var body: some View {
        NavigationView {
            List {
                ForEach(ingredients, id: \.id) { ingredient in
                    
                    if !manuallySavedIngredients.contains(where: { $0.idIngredient == ingredient.id }) {
                    Text(ingredient.name)
                                .swipeActions {
                                    Button {
                                        saveIngredientTapped(ingredient: ingredient)
                                    } label: {
                                        Label("Save", systemImage: "square.grid.3x1.folder.fill.badge.plus")
                                    }
                                    .tint(.blue)
                                }
                        }
                    
                }
            }
            .navigationTitle("Select Ingredients")
            .navigationBarItems(trailing: closeButton)
        }
    }
    
    private var closeButton: some View {
        Button("Close") {
            isPresented = false
        }
    }
}

struct AddIngredientSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AddIngredientSheetView(ingredients: [], isPresented: .constant(true))
    }
}


