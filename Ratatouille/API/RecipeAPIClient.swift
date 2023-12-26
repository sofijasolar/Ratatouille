//
//  RecipeAPIClient.swift
//  Ratatouille
//
//  Created by Sofija Solar on 15/11/2023.
//

import Foundation

struct RecipeAPIClient {
    var getRecipes: ( () async throws -> [APIMeal] )
    var getRecipesByCategory: ( (_ cat: String) async throws -> [APIMeal] )
    var getMealById: ((_ id: String) async throws -> APIMeal)
    var getRecipesByName: ( (_ name: String) async throws -> [APIMeal] )
    var getRecipesByArea: ( (_ area: String) async throws -> [APIMeal] )
    var getRecipesByIngredient: ( (_ ingredient: String) async throws -> [APIMeal] )
    
    
    var getCategories: ( () async throws -> [APICategory])
    var getAreas: ( () async throws -> [APIArea])
    var getIngredients: ( () async throws -> [APIIngredient])
    
    
}

/// det er veldig mye kode-repetisjon i koden under, dette kunne bli optimalisert med å grupere koden som får samme type response fra listene og bare forandre på url-endepunktene (hadde ikke god tid på å fikse det)
extension RecipeAPIClient {
    
    static let live = RecipeAPIClient(getRecipes: {
        
            let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=dessert")!
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            urlRequest.allHTTPHeaderFields = ["accept" : "application/json"]
            
            do {
                let (data, response) = try await URLSession.shared.data(for: urlRequest)
                let stringValue = String.init(data: data, encoding: .utf8)
//                print(stringValue)
                
                let mealsResponse = try JSONDecoder().decode(MealsResponse.self, from: data)
                let meals = mealsResponse.meals

                return meals
                
//                try PersistenceController.shared.container.viewContext.save()
                
            }catch let error {
                print(error)
                throw error
            }
            
        
    }, getRecipesByCategory:{ cat in

        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(cat)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = ["accept" : "application/json"]
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            let stringValue = String.init(data: data, encoding: .utf8)
            
            let mealsResponse = try JSONDecoder().decode(MealsResponse.self, from: data)
            let meals = mealsResponse.meals

            return meals
            
            
        }catch let error {
            print(error)
            throw error
        }

    }, getMealById: { id in
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = ["accept" : "application/json"]
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            let stringValue = String.init(data: data, encoding: .utf8)
            
            let mealsResponse = try JSONDecoder().decode(MealsResponse.self, from: data)
            let meal = mealsResponse.meals[0]

            return meal
            
            
        }catch let error {
            print(error)
            throw error
        }
    }, getRecipesByName: { name in
    
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?s=\(name)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = ["accept" : "application/json"]
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            let stringValue = String.init(data: data, encoding: .utf8)
            
            let mealsResponse = try JSONDecoder().decode(MealsResponse.self, from: data)
            let meals = mealsResponse.meals

            return meals
            
            
        }catch let error {
            print(error)
            throw error
        }
        
    }, getRecipesByArea: { area in
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?a=\(area)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = ["accept" : "application/json"]
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            let stringValue = String.init(data: data, encoding: .utf8)
            
            let mealsResponse = try JSONDecoder().decode(MealsResponse.self, from: data)
            let meals = mealsResponse.meals

            return meals
            
            
        }catch let error {
            print(error)
            throw error
        }
        
    }, getRecipesByIngredient: { ingredient in
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?i=\(ingredient)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = ["accept" : "application/json"]
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            let stringValue = String.init(data: data, encoding: .utf8)
            
            let mealsResponse = try JSONDecoder().decode(MealsResponse.self, from: data)
            let meals = mealsResponse.meals

            return meals
            
        }catch let error {
            print(error)
            throw error
        }
        
    }, getCategories: {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = ["accept" : "application/json"]
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            let stringValue = String.init(data: data, encoding: .utf8)
            
            let categoriesResponse = try JSONDecoder().decode(CategoriesResponse.self, from: data)
            let categories = categoriesResponse.categories

            return categories
            
            
        }catch let error {
            print(error)
            throw error
        }
    }, getAreas: {
    
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/list.php?a=list")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = ["accept" : "application/json"]
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            let stringValue = String.init(data: data, encoding: .utf8)
            
            let areasResponse = try JSONDecoder().decode(AreasResponse.self, from: data)
            let areas = areasResponse.meals

            return areas
            
            
        }catch let error {
            print(error)
            throw error
        }
    }, getIngredients: {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/list.php?i=list")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = ["accept" : "application/json"]
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            let stringValue = String.init(data: data, encoding: .utf8)
            
            let ingredientsResponse = try JSONDecoder().decode(IngredientsResponse.self, from: data)
            let ingredients = ingredientsResponse.meals

            return ingredients
            
            
        }catch let error {
            print(error)
            throw error
        }
    }
                                      
    )
    
    
    
    
}

struct MealsResponse: Decodable {
    let meals: [APIMeal]
}
struct CategoriesResponse: Decodable {
    let categories: [APICategory]
}
struct AreasResponse: Decodable {
    let meals: [APIArea]
}
struct IngredientsResponse: Decodable {
    let meals: [APIIngredient]
}
