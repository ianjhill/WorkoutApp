//
//  CalorieTrackerView.swift
//  Fitness App
//
//  Created by Ian Hill on 8/31/22.
//

import SwiftUI

struct CalorieTrackerView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var food: FetchedResults<Food>
    
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView {
            VStack {
                CalorieCountViewModel()
                
                CalorieListViewModel()
            }
            .navigationTitle("Calorie Tracker")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("Add Food", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddFood()
            }
            .navigationViewStyle(.stack)
        }
        .navigationViewStyle(.stack)
    }
}

struct CalorieTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        CalorieTrackerView()
    }
}
