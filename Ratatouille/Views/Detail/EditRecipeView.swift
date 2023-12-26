//
//  EditRecipeView.swift
//  Ratatouille
//
//  Created by Sofija Solar on 04/12/2023.
//

import SwiftUI

struct EditRecipeView: View {
//    @ObservedObject var recipeManager: RecipeManager
//    @ObservedObject var editRecipeManager: EditRecipeManager
    
    
    @State private var editedRecipeName: String
    @State private var editedArea: String
    @State private var editedIngredients: [String]
    @State private var editedMeasurements: [String]
    @State private var editedInstructions: String
    
    @Environment(\.presentationMode) var presentationMode
    
    var recipe: Meal
        
    init(recipe: Meal) {
            self.recipe = recipe
        // Initialize the @State properties with the current values from the recipe
        _editedRecipeName = State(initialValue: recipe.name ?? "")
        _editedArea = State(initialValue: recipe.area ?? "")
        _editedIngredients = State(initialValue: recipe.ingredientsArray )
        _editedMeasurements = State(initialValue: recipe.measurementsArray )
        _editedInstructions = State(initialValue: recipe.instructions ?? "")
    }
    
    
    
    var body: some View {
            Form {
                Section(header: Text("Matoppskrift – Detaljer")) {
                    TextField("Recipe Name", text: $editedRecipeName).autocorrectionDisabled()
                    TextField("Area", text: $editedArea).autocorrectionDisabled()
                    
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("Ingredienser")
                            .font(.headline)
                        
                        
                        ForEach(0..<editedIngredients.count, id: \.self) { index in
                            HStack {
                                TextField("Ingredient", text: $editedIngredients[index]).autocorrectionDisabled()
                                TextField("Measurement", text: $editedMeasurements[index]).autocorrectionDisabled()
                            }
                        }
                        
                    }
                    VStack(alignment: .leading, spacing: 10){
                        Text("Fremgangsmåte")
                            .font(.headline)
                        TextEditor(text: $editedInstructions)
                            .frame(height: 100)
                    }
                    
                    
                }
                
                Section {
                    Button("Save Changes") {
                        print("Clicked saved changes")
                        RecipeManager.shared.updateRecipe(recipeId: recipe.idMeal, newName: editedRecipeName, newArea: editedArea, newIngredients: editedIngredients, newMeasurements: editedMeasurements, newInstructions: editedInstructions)
                        
                        // navigate back to the detail view after saving changes
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }.navigationTitle("Rediger matoppskrift")
        
        
    }
}

struct EditRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        EditRecipeView(recipe: Meal(context: PersistenceController.shared.container.viewContext))
    }
}

//class EditRecipeManager: ObservableObject {
//    @Published var editedRecipe: Meal?
//
//    func startEditing(recipe: Meal) {
//        editedRecipe = recipe
//    }
//}
