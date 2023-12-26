//
//  SettingsView.swift
//  Ratatouille
//
//  Created by Sofija Solar on 15/11/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
    
    var body: some View {
        NavigationView{
            Form {
                Section{
                    NavigationLink(destination: EditAreasView()) {
                        Label("Redigere landområder", systemImage: "globe")
                    }

                    NavigationLink(destination: EditCategoriesView()) {
                        Label("Redigere kategorier", systemImage: "rectangle.3.group.bubble.left")
                    }

                    NavigationLink(destination: EditIngredientsView()) {
                        Label("Redigere ingredienser", systemImage: "carrot.fill")
                    }
                }
                Section {
                    Toggle(isOn: $isDarkModeOn) {
                        Label("Aktiver mørk modus", systemImage: "moon.circle")
                    }
                }
                Section {
                    NavigationLink(destination: ArchiveView()) {
                        Label("Administrere arkiv", systemImage: "archivebox.fill")
                    }
                    
                }
            }
            .navigationTitle("Innstillinger")
        }
//        .border(.blue)
        .ignoresSafeArea()
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
