//
//  ContentView.swift
//  Fitness App
//
//  Created by Ian Hill on 8/31/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var workouts: FetchedResults<Workout>
    
    @State private var showingAddScreen = false
    // Anything
    var body: some View {
        NavigationView {
            List {
                ForEach(workouts) { workout in
                    NavigationLink {
                        Text(workout.type ?? "Unknown Workout")
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(workout.type ?? "Unknown Workout Type")
                                    .font(.headline)
                                Text(workout.name ?? "Unknown Workout Name")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Workout Tracker")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingAddScreen.toggle()
                } label: {
                    Label("Add Workout", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddScreen) {
            AddWorkoutView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}