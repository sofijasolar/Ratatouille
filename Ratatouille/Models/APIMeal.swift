//
//  APIMeal.swift
//  Ratatouille
//
//  Created by Sofija Solar on 01/12/2023.
//

import Foundation

struct APIMeal: Identifiable, Decodable {
    var id: String
    
    
    let strMeal: String
    let idMeal: String
    let strMealThumb: String?
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strTags: String?
    
    var ingredients: [String] = []
    var measurements: [String] = []
    
    
    enum CodingKeys: String, CodingKey {
        case strMeal
        case idMeal
        case strMealThumb
        case strCategory
        case strArea
        case strInstructions
        case strTags
        
        case strIngredient1
        case strIngredient2
        case strIngredient3
        case strIngredient4
        case strIngredient5
        case strIngredient6
        case strIngredient7
        case strIngredient8
        case strIngredient9
        case strIngredient10
        case strIngredient11
        case strIngredient12
        case strIngredient13
        case strIngredient14
        case strIngredient15
        case strIngredient16
        case strIngredient17
        case strIngredient18
        case strIngredient19
        case strIngredient20

        case strMeasure1
        case strMeasure2
        case strMeasure3
        case strMeasure4
        case strMeasure5
        case strMeasure6
        case strMeasure7
        case strMeasure8
        case strMeasure9
        case strMeasure10
        case strMeasure11
        case strMeasure12
        case strMeasure13
        case strMeasure14
        case strMeasure15
        case strMeasure16
        case strMeasure17
        case strMeasure18
        case strMeasure19
        case strMeasure20
        
        

    }
    
    init(strMeal: String, idMeal: String, strMealThumb: String?, strCategory: String?, strArea: String?, strInstructions: String?, strTags: String?, ingredients: [String]?, measurements: [String]?) {
        self.strMeal = strMeal
        self.idMeal = idMeal
        self.id = idMeal
        self.strMealThumb = strMealThumb
        self.strCategory = strCategory
        self.strArea = strArea
        self.strInstructions = strInstructions
        self.strTags = strTags
        self.ingredients = ingredients ?? []
        self.measurements = measurements ?? []
    }
    
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            self.strMeal = try container.decode(String.self, forKey: .strMeal)
            self.idMeal = try container.decode(String.self, forKey: .idMeal)
            self.id = idMeal
            self.strMealThumb = try container.decodeIfPresent(String.self, forKey: .strMealThumb)
            self.strCategory = try container.decodeIfPresent(String.self, forKey: .strCategory)
            self.strArea = try container.decodeIfPresent(String.self, forKey: .strArea)
            self.strInstructions = try container.decodeIfPresent(String.self, forKey: .strInstructions)
            self.strTags = try container.decodeIfPresent(String.self, forKey: .strTags)
        
            
            var ingredients: [String] = []
            var measurements: [String] = []

            // Loop through the ingredients and measurements
            for i in 1...20 {
                             
                do {
                    let ingredient = try container.decodeIfPresent(String.self, forKey: CodingKeys(rawValue: "strIngredient\(i)")!)
                    let measurement = try container.decodeIfPresent(String.self, forKey: CodingKeys(rawValue: "strMeasure\(i)")!)
                    
                    guard let ingredient = ingredient, !ingredient.isEmpty else {
                        // If ingredient is nil or empty, stop the loop
                        break
                    }
                    
                    // Append ingredients and measurements
                    ingredients.append(ingredient)
                    measurements.append(measurement ?? "") // Use an empty string if measurement is nil
                } catch {
                    // Handle the decoding error, or simply break the loop
                    break
                }
            
                // Assign the arrays to the properties
                self.ingredients = ingredients
                self.measurements = measurements
                
            } //for loop
        
        
        
        }
    
}

extension APIMeal {
    
    static let demoMeals = [
        APIMeal.init(strMeal: "Pizza Express Margherita", idMeal: "1", strMealThumb: "https://www.themealdb.com/images/media/meals/x0lk931587671540.jpg", strCategory: "Miscellaneous", strArea: "Italian", strInstructions: "1 Preheat the oven to 230°C.\r\n\r\n2 Add the sugar and crumble the fresh yeast into warm water.\r\n\r\n3 Allow the mixture to stand for 10 – 15 minutes in a warm place (we find a windowsill on a sunny day works best) until froth develops on the surface.\r\n\r\n4 Sift the flour and salt into a large mixing bowl, make a well in the middle and pour in the yeast mixture and olive oil.\r\n\r\n5 Lightly flour your hands, and slowly mix the ingredients together until they bind.\r\n\r\n6 Generously dust your surface with flour.\r\n\r\n7 Throw down the dough and begin kneading for 10 minutes until smooth, silky and soft.\r\n\r\n8 Place in a lightly oiled, non-stick baking tray (we use a round one, but any shape will do!)\r\n\r\n9 Spread the passata on top making sure you go to the edge.\r\n\r\n10 Evenly place the mozzarella (or other cheese) on top, season with the oregano and black pepper, then drizzle with a little olive oil.\r\n\r\n11 Cook in the oven for 10 – 12 minutes until the cheese slightly colours.\r\n\r\n12 When ready, place the basil leaf on top and tuck in!", strTags: "", ingredients: [], measurements: []),
        APIMeal.init(strMeal: "Pancakes", idMeal: "2", strMealThumb: "https://www.themealdb.com/images/media/meals/sywswr1511383814.jpg", strCategory: "Dessert", strArea: "American", strInstructions: "Put the flour, eggs, milk, 1 tbsp oil and a pinch of salt into a bowl or large jug, then whisk to a smooth batter. Set aside for 30 mins to rest if you have time, or start cooking straight away.\r\nSet a medium frying pan or crêpe pan over a medium heat and carefully wipe it with some oiled kitchen paper. When hot, cook your pancakes for 1 min on each side until golden, keeping them warm in a low oven as you go.\r\nServe with lemon wedges and sugar, or your favourite filling. Once cold, you can layer the pancakes between baking parchment, then wrap in cling film and freeze for up to 2 months.", strTags: "Breakfast,Desert,Sweet,Fruity", ingredients: ["Buckwheat", "Flour", "Salt", "Yeast", "Milk", "Butter", "Egg"], measurements: ["1/2 cup ", "2/3 Cup", "1/2 tsp", "1 tsp ", "1 cup ", "2 tbs", "1 Seperated"])
        
    ]
}
