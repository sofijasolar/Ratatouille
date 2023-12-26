//
//  EditAreasView.swift
//  Ratatouille
//
//  Created by Sofija Solar on 02/12/2023.
//

import SwiftUI

struct EditAreasView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Area.area, ascending: true)],
        predicate: NSPredicate(format: "isArchived == %@", NSNumber(value: false)),
        animation: .default)
    private var databaseAreas: FetchedResults<Area>
    
    @State private var viewModel = AreaViewModel()
    @State var isShowingSheet = false
    
    
    
    func showAddAreaSheet() {
        Task {
            await viewModel.fetchAreasFromAPI()
            isShowingSheet.toggle()
        }
        
    }
    
    func archiveArea(area: Area){
        AreaManager.shared.editAreaArchiveStatus(area: area, isArchived: true)
        
    }
    
    var body: some View {
//        NavigationView {
            
            List{
                ForEach(databaseAreas) { area in
//                    Text(area.area ?? "")
                    AreaRow(area: area)
                        .swipeActions {
                            Button {
                                archiveArea(area: area)
                            } label: {
                                Label("Archive", systemImage: "archivebox.fill")
                            }
                            .tint(.blue)
                        }
                }
//                .border(.red)
            }
            .navigationTitle("Landområder")
            .navigationBarItems(trailing: addButton)
            .sheet(isPresented: $isShowingSheet) {
                AddAreaSheetView(areas: viewModel.apiAreas, isPresented: $isShowingSheet)
                }
            
            
    }
    
    private var addButton: some View {
            Button(action: {
                print("Add button tapped")
                showAddAreaSheet()
            }) {
                Image(systemName: "plus.circle.fill")
            }
        }
}

struct AreaRow: View {
    
    let area : Area
    
    var body: some View {
        HStack {
            
            AsyncImage(url: URL(string: "https://flagsapi.com/\(area.flag ?? "")/flat/64.png" ))
            { image in image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                
            }
            .frame(width: 25, height: 25)
            .cornerRadius(1)
            .clipped()
                
                Text("\(area.area ?? "")")
                    .font(.headline)
               
        }
    }
}

struct EditAreasView_Previews: PreviewProvider {
    static var previews: some View {
        EditAreasView()
    }
}
