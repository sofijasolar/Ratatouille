//
//  EditIngredientsView.swift
//  Ratatouille
//
//  Created by Sofija Solar on 02/12/2023.
//

import SwiftUI

struct EditIngredientsView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Ingredient.name, ascending: true)], predicate: NSPredicate(format: "isArchived == %@", NSNumber(value: false)),
        animation: .default) // only false because the ones with relationship to meal have isArchived as null.
    private var manuallySavedDBIngredients: FetchedResults<Ingredient>
    
    @State private var viewModel = IngredientViewModel()
    @State var isShowingSheet = false
    
    func showAddIngredientSheet() {
        Task {
            await viewModel.fetchIngredientsFromAPI()
            isShowingSheet.toggle()
        }
        
    }
    
    func archiveIngredient(ingredient: Ingredient){
        IngredientManager.shared.editIngredientArchiveStatus(ingredient: ingredient, isArchived: true)
        
    }
    
    var body: some View {
        List{
            ForEach(manuallySavedDBIngredients) { ingredient in
                ListIngredientView(ingredient: ingredient)
                    .swipeActions {
                        Button {
                             archiveIngredient(ingredient: ingredient)
                            
                        } label: {
                            Label("Archive", systemImage: "archivebox.fill")
                        }
                        .tint(.blue)
                    }
            }
        }
        
        .navigationBarItems(trailing: addButton)
        .navigationTitle("Igredienser")
        .sheet(isPresented: $isShowingSheet) {
            AddIngredientSheetView(ingredients: viewModel.apiIngredients, isPresented: $isShowingSheet)
            }
    }
    
    private var addButton: some View {
            Button(action: {
                print("Add button tapped")
                showAddIngredientSheet()
            }) {
                Image(systemName: "plus.circle.fill")
            }
        }
}

struct EditIngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        EditIngredientsView()
    }
}


struct ListIngredientView: View {
    
    let ingredient : Ingredient
    
    
    var body: some View {
        HStack {
            
            AsyncImage(url: URL(string: ingredient.thumbnail ?? "https://www.themealdb.com/images/ingredients/\(ingredient.name ?? "")-Small.png"))
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
                Text("\(ingredient.name ?? "")")
                    .padding(8)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            
            
            Spacer()
        }
    }
}
