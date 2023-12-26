//
//  APIArea.swift
//  Ratatouille
//
//  Created by Sofija Solar on 03/12/2023.
//

import Foundation

struct APIArea: Identifiable, Decodable {
    
    let areaName: String // unique
    
    private enum CodingKeys: String, CodingKey {
        case areaName = "strArea"
    }
    
    var id: String {
            return areaName
        }

    init(areaName: String) {
        self.areaName = areaName
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.areaName = try container.decode(String.self, forKey: .areaName)
    }
    
    
    
}

extension APIArea {
    static let demoAreas = [
        APIArea.init(areaName: "Italian"),
        APIArea(areaName: "Croatian"),
        APIArea(areaName: "Dutch"),
    ]
}
