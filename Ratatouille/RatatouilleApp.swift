//
//  RatatouilleApp.swift
//  Ratatouille
//
//  Created by Sofija Solar on 15/11/2023.
//

import SwiftUI

@main
struct RatatouilleApp: App {
    let persistenceController = PersistenceController.shared
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false

    var body: some Scene {
        WindowGroup {
            
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(isDarkModeOn ? .dark : .light)
        }
    }
}

