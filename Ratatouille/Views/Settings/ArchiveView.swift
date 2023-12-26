//
//  ArchiveView.swift
//  Ratatouille
//
//  Created by Sofija Solar on 03/12/2023.
//

import SwiftUI

struct ArchiveView: View {
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Area.area, ascending: true)],
            predicate: NSPredicate(format: "isArchived == %@", NSNumber(value: true)),
            animation: .default)
        private var archivedAreas: FetchedResults<Area>
    
    @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)],
            predicate: NSPredicate(format: "isArchived == %@", NSNumber(value: true)),
            animation: .default)
        private var archivedCategories: FetchedResults<Category>
    
    @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Ingredient.name, ascending: true)],
            predicate: NSPredicate(format: "isArchived == %@", NSNumber(value: true)),
            animation: .default)
        private var archivedIngredients: FetchedResults<Ingredient>
    
    @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Meal.name, ascending: true)],
            predicate: NSPredicate(format: "isArchived == %@", NSNumber(value: true)),
            animation: .default)
    private var archivedMeals: FetchedResults<Meal>
    
    
    func restoreArea(area: Area){
        AreaManager.shared.editAreaArchiveStatus(area: area, isArchived: false)
    }
    
    func restoreCategory(category: Category){
        CategoryManager.shared.editCategory(category: category, isArchived: false)
    }
    func restoreIngredient(ingredient: Ingredient){
        IngredientManager.shared.editIngredientArchiveStatus(ingredient: ingredient, isArchived: false)
    }
    
    func restoreMeal(meal: Meal){
        RecipeManager.shared.editRecipeArchiveStatus(recipe: meal, isArchived: false)
    }
    
    func deleteAreaPerm(area: Area){
        AreaManager.shared.deleteArea(area: area)
    }
    
    func deleteCategoryPerm(category: Category){
        CategoryManager.shared.deleteCategory(category: category)
    }
    func deleteIngredientPerm(ingredient: Ingredient){
        IngredientManager.shared.deleteIngredient(ingredient: ingredient)
    }
    
    func deleteMealPerm(meal: Meal){
        RecipeManager.shared.deleteRecipe(recipe: meal)
    }
    
    
    var body: some View {
        Form {
            Section(header: Text("Landområder")) {
                if archivedAreas.isEmpty {
                    Label("Ingen arkiverte landområder", systemImage: "globe")
                } else {
                    ForEach(archivedAreas) {area  in
                        AreaRow(area: area)
                            .swipeActions {
                                Button {
                                    restoreArea(area: area)
                                    
                                } label: {
                                    Label("Restore", systemImage: "tray.and.arrow.up.fill")
                                }
                                .tint(.gray)
                                Button (role: .destructive) {
                                    print("Delete pressed")
                                    deleteAreaPerm(area: area)
                                } label: {
                                    Label("Delete", systemImage: "trash.fill")
                                }
                            }
                    }
                }
            }
            Section (header: Text("Kategorier"), content: {
                if archivedCategories.isEmpty {
                    Label("Ingen arkiverte kategorier", systemImage: "rectangle.3.group.bubble.left")
                } else {
                    ForEach(archivedCategories) {category  in
                        ListCategoryView(category: category)
                            .swipeActions {
                                Button {
                                    restoreCategory(category: category)
                                    
                                } label: {
                                    Label("Restore", systemImage: "tray.and.arrow.up.fill")
                                }
                                .tint(.gray)
                                Button (role: .destructive) {
                                    print("Delete pressed")
                                    deleteCategoryPerm(category: category)
                                } label: {
                                    Label("Delete", systemImage: "trash.fill")
                                }
                            }
                        
                    }
                }
            })
            Section (header: Text("Ingredienser"), content: {
                if archivedIngredients.isEmpty {
                    Label("Ingen arkiverte ingredienser", systemImage: "carrot.fill")
                } else {
                    ForEach(archivedIngredients) {ingredient  in
                        ListIngredientView(ingredient: ingredient)
                            .swipeActions {
                                Button {
                                    restoreIngredient(ingredient: ingredient)
                                    
                                } label: {
                                    Label("Restore", systemImage: "tray.and.arrow.up.fill")
                                }
                                .tint(.gray)
                                Button (role: .destructive) {
                                    print("Delete pressed")
                                    deleteIngredientPerm(ingredient: ingredient)
                                } label: {
                                    Label("Delete", systemImage: "trash.fill")
                                }
                            }
                        
                    }
                }
            })
            Section(header: Text("Matoppskrifter")) {
                if archivedMeals.isEmpty{
                    Label("Ingen arkiverte matoppskrifter", systemImage: "fork.knife.circle.fill")
                }else {
                    ForEach(archivedMeals) { meal  in
                        ListMyRecipeView(recipe: meal)
                            .swipeActions {
                                Button {
                                    restoreMeal(meal: meal)
                                    
                                } label: {
                                    Label("Restore", systemImage: "tray.and.arrow.up.fill")
                                }
                                .tint(.gray)
                                Button (role: .destructive){
                                    print("Delete pressed")
                                    deleteMealPerm(meal: meal)
                                }label: {
                                    Label("Delete", systemImage: "trash.fill")
                                }
                                .tint(.red)
                            }
                    }
                }
                
            }
        }
    }
}

struct ArchiveView_Previews: PreviewProvider {
    static var previews: some View {
        ArchiveView()
    }
}
