//
//  EditCategoriesView.swift
//  Ratatouille
//
//  Created by Sofija Solar on 02/12/2023.
//

import SwiftUI

struct EditCategoriesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
        @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)], predicate: NSPredicate(format: "isArchived == %@", NSNumber(value: false)),
            animation: .default)
        private var databaseCategories: FetchedResults<Category>
        
    
//    @State var categories: [Category]
    
    @State private var viewModel = CategoryViewModel()
    @State var isShowingSheet = false
    
    
    
    func onAppear(){
    }
    
    func showAddCategorySheet() {
        Task {
                await viewModel.fetchCategoriesFromAPI()
                isShowingSheet.toggle()
            }
        
    }
    
    func archiveCategory(category: Category){
        CategoryManager.shared.editCategory(category: category, isArchived: true)
        
    }
    
    
    
    
    var body: some View {
//        NavigationView {
            
            List{
                ForEach(databaseCategories) { category in
                    ListCategoryView(category: category)
                        .swipeActions {
                            Button {
                                 archiveCategory(category: category)
                                
                            } label: {
                                Label("Archive", systemImage: "archivebox.fill")
                            }
                            .tint(.blue)
                        }
                }
            }
            
            .navigationBarItems(trailing: addButton)
            .navigationTitle("Kategorier")
            .sheet(isPresented: $isShowingSheet) {
                AddCategorySheetView(categories: viewModel.apiCategories, isPresented: $isShowingSheet)
                }
            
            
//        }
//        .border(.blue)
//        .ignoresSafeArea()
        
        
    }
    
    private var addButton: some View {
            Button(action: {
                print("Add button tapped")
                showAddCategorySheet()
            }) {
                Image(systemName: "plus.circle.fill")
            }
        }
    
    
}

struct EditCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        EditCategoriesView()
    }
}



