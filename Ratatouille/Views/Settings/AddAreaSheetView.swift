//
//  AddAreaSheetView.swift
//  Ratatouille
//
//  Created by Sofija Solar on 03/12/2023.
//

import SwiftUI

struct AddAreaSheetView: View {
    
    let areas: [APIArea]
    @Binding var isPresented: Bool
    
    @Environment(\.managedObjectContext) private var viewContext
    
    //Fetch all, even archived ones. so we can check if it is in database before (printing))
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Area.area, ascending: true)],
        animation: .default)
    private var databaseAreas: FetchedResults<Area>
    
    
    func saveAreaTapped(area: APIArea){
        print("Clicked save area")
        AreaManager.shared.saveAreaToDB(area)
        
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(areas) { area in
                    if !databaseAreas.contains(where: { $0.area == area.areaName }) {
                        Text("\(area.areaName)")
                            .swipeActions {
                                Button {
                                    saveAreaTapped(area: area)
                                } label: {
                                    Label("Save", systemImage: "square.grid.3x1.folder.fill.badge.plus")
                                }
                                .tint(.blue)
                            }
                    }
                }
            }
            .navigationTitle("Select Category")
            .navigationBarItems(trailing: closeButton)
        }
    }
    
    private var closeButton: some View {
        Button("Close") {
            isPresented = false
        }
    }
}

struct AddAreaSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AddAreaSheetView(areas: APIArea.demoAreas, isPresented: .constant(true))
    }
}
