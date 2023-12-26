//
//  APICategory.swift
//  Ratatouille
//
//  Created by Sofija Solar on 02/12/2023.
//

import Foundation

struct APICategory: Identifiable, Decodable {
    
    
    let id: Int16
    let name: String
    let thumbnail: String?
    let description: String?

    private enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case name = "strCategory"
        case thumbnail = "strCategoryThumb"
        case description = "strCategoryDescription"
    }
    
    init(id: Int16, name: String, thumbnail: String?, description: String?) {
            self.id = id
            self.name = name
            self.thumbnail = thumbnail
            self.description = description
        }
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            if let idString = try container.decodeIfPresent(String.self, forKey: .id),
               let id = Int16(idString) {
                self.id = id
            } else {
                self.id = 0 // Provide a default value or handle the absence of id appropriately?? it should NOT be no id.
            }

            self.name = try container.decode(String.self, forKey: .name)
            self.thumbnail = try container.decodeIfPresent(String.self, forKey: .thumbnail)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
        }
    
    
    
}

extension APICategory {
    static let demoCategories: [APICategory] = [
            APICategory(id: 1, name: "Dessert", thumbnail: "https://www.themealdb.com/images/category/dessert.png", description: "Description 1"),
            APICategory(id: 2, name: "Side", thumbnail:     "https://www.themealdb.com/images/category/side.png", description: "Description 2")
        ]
}

/// CategoryProtocol is used in order to use one same view on both APICategory object and Category model from the database
protocol CategoryProtocol {
    var categoryId: Int16 { get }
    var categoryName: String? { get }
    var categoryThumbnail: String? { get }
}

extension APICategory : CategoryProtocol {
    var categoryId: Int16 {
        return self.id
    }
    
    var categoryName: String? {
        return self.name
    }
    var categoryThumbnail: String?{
        return self.thumbnail
    }
    
    
    
}
