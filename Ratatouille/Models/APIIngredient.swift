//
//  APIIngredient.swift
//  Ratatouille
//
//  Created by Sofija Solar on 03/12/2023.
//

import Foundation

struct APIIngredient: Identifiable, Decodable {
    
    
    let id: Int16
    let name: String
    let description: String?

    private enum CodingKeys: String, CodingKey {
        case id = "idIngredient"
        case name = "strIngredient"
        case description = "strDescription"
    }
    
    init(id: Int16, name: String, description: String?) {
            self.id = id
            self.name = name
            self.description = description
        }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let idString = try container.decode(String.self, forKey: .id)
        guard let id = Int16(idString) else {
            throw DecodingError.dataCorruptedError(forKey: .id, in: container, debugDescription: "Invalid value for id")
        }
        self.id = id
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
    
    }
    
    
    
}
