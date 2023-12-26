//
//  ContentView.swift
//  Ratatouille
//
//  Created by Sofija Solar on 15/11/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {

    func clearCategoryData() {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Category")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)

        do {
            try PersistenceController.shared.container.viewContext.execute(deleteRequest)
            print("Category data cleared.")
        } catch {
            print("Error clearing category data:", error)
        }
    }
    
    @State private var showSplashScreen = true
    
    var body: some View {
        if showSplashScreen {
            SplashView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        showSplashScreen = false
                    }
                }
        } else {
            TabView {
                
                MyRecipesView()
                    .tabItem {
                        Label("Mine oppskrifter", systemImage: "fork.knife.circle.fill")
                    }
                
                SearchView()
                    .tabItem {
                        Label("Søk", systemImage: "magnifyingglass.circle.fill")
                    }
                
                
                SettingsView()
                    .tabItem {
                        Label("Innstillinger", systemImage: "gearshape.fill")
                    }
                
                
            }
            .onAppear{
                //            clearCategoryData()
            }
            
        }}
    

    

}

