//
//  AddCategorySheetView.swift
//  Ratatouille
//
//  Created by Sofija Solar on 02/12/2023.
//

import SwiftUI

struct AddCategorySheetView: View {
    let categories: [APICategory]
    @Binding var isPresented: Bool
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)],
        animation: .default)
    private var databaseCategories: FetchedResults<Category>


    var body: some View {
        NavigationView {
            List {
                ForEach(categories, id: \.id) { category in
                    //not printing a category that is already saved
                    if !databaseCategories.contains(where: { $0.id == category.categoryId }) {
                        ListCategoryView(category: category)
                            .swipeActions {
                                Button {
                                    saveCategoryTapped(category: category)
                                } label: {
                                    Label("Save", systemImage: "square.grid.3x1.folder.fill.badge.plus")
                                }
                                .tint(.blue)
                            }
                    }
                }
            }
            .navigationTitle("Select Category")
            .navigationBarItems(trailing: closeButton)
        }
    }
    
    func saveCategoryTapped(category: APICategory){
        print("Clicked save category")

        do {
            try saveCategoryToDB(category: category)
        } catch {
            print("Error saving category:", error)
            // Handle the error as needed
        }
        
        // should i have a check mark on the categories that are added already to the database? like when i save it
        
    }
    
    func saveCategoryToDB(category: APICategory) throws {
        let moc = PersistenceController.shared.container.viewContext
        let databaseCategories = try moc.fetch(Category.fetchRequest())
        
        if databaseCategories.contains(where: { $0.id == category.id }){
            throw NSError(domain: "", code: 0, userInfo: nil)
        } else {

            let newCategory = Category(context: moc)
            newCategory.id = category.id
            newCategory.name = category.name
            newCategory.thumbnail = category.thumbnail
            newCategory.isArchived = false
            
            
            do {
                try moc.save()
                print("Category saved to the database.")
            } catch {
                print("Error saving category:", error)
            }
            
        }
        
    }

    private var closeButton: some View {
        Button("Close") {
            isPresented = false
        }
    }
}

struct AddCategorySheetView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategorySheetView(categories: APICategory.demoCategories, isPresented: .constant(true))
    }
}
