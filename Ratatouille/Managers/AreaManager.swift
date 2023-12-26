//
//  AreaManager.swift
//  Ratatouille
//
//  Created by Sofija Solar on 03/12/2023.
//

import Foundation

class AreaManager {
    static let shared = AreaManager()

    private let moc = PersistenceController.shared.container.viewContext
    
    func saveAreaToDB(_ apiArea: APIArea) {
        
        do {
            let databaseAreas = try moc.fetch(Area.fetchRequest())
            
            if databaseAreas.contains(where: { $0.area == apiArea.areaName }){
                throw NSError(domain: "Area already exists", code: 0, userInfo: nil)
            } else {
                guard let areaCode = areaCodeMapping[apiArea.areaName] else {
                        print("Area code not found for \(apiArea.areaName)")
                        return
                    }

                let newArea = Area(context: moc)
                newArea.area = apiArea.areaName
                newArea.isArchived = false
                
                newArea.flag = areaCode
//                newArea.flag = "https://flagsapi.com/\(areaCode)/flat/64.png"
                
                do {
                    try moc.save()
                    print("Area saved to the database. \(newArea)")
                } catch {
                    print("Error saving area:", error)
                }
                
            }
        } catch let error as NSError {
            print("Error saving area to the database:", error)
            // Handle the error, you can show an alert or perform other actions here
        } catch {
            print("Unexpected error saving area to the database.")
            // Handle other unexpected errors here
        }
    }
    
    func editAreaArchiveStatus(area: Area, isArchived: Bool) {
        do {
            area.isArchived = isArchived
            
            try moc.save()
            print("Area updated successfully: \(area)")
        } catch {
            print("Error editing area:", error)
        }
    }
    
    func deleteArea(area: Area){
        do {
            moc.delete(area)
            try moc.save()
            print("Area deleted successfully: \(area)")
        }catch {
            print("Error deleting area:", error)
        }
    }
    
    let areaCodeMapping: [String: String] = [
        "American": "US",
        "British": "GB",
        "Canadian": "CA",
        "Chinese": "CN",
        "Croatian": "HR",
        "Dutch": "NL",
        "Egyptian": "EG",
        "Filipino": "PH",
        "French": "FR",
        "Greek": "GR",
        "Indian": "IN",
        "Irish": "IE",
        "Italian": "IT",
        "Jamaican": "JM",
        "Japanese": "JP",
        "Kenyan": "KE",
        "Malaysian": "MY",
        "Mexican": "MX",
        "Moroccan": "MA",
        "Polish": "PL",
        "Portuguese": "PT",
        "Russian": "RU",
        "Spanish": "ES",
        "Thai": "TH",
        "Tunisian": "TN",
        "Turkish": "TR",
        "Unknown": "",
        "Vietnamese": "VN"
    ]

    
}
