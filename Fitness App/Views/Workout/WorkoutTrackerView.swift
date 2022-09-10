//
//  WorkoutTrackerView.swift
//  Fitness App
//
//  Created by Ian Hill on 8/31/22.
//

import SwiftUI

struct WorkoutTrackerView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var workouts: FetchedResults<Workout>
    
    @State private var showingAddScreen = false
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("\(Int(workouts.count)) workouts done.")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                List {
                    ForEach(workouts) { workout in
                        NavigationLink {
                            WorkoutDetailView(workout: workout)
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(workout.type ?? "Unknown Workout Type")
                                        .font(.headline)
                                    Text(workout.name ?? "Unknown Workout Name")
                                        .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteWorkouts)
            }
                .listStyle(.plain)
        }
        .navigationTitle("Workout Tracker")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
            
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
    
    func deleteWorkouts(at offsets: IndexSet) {
        for offset in offsets {
            let workout = workouts[offset]
            moc.delete(workout)
        }
        
        try? moc.save()
    }
}

struct WorkoutTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutTrackerView()
    }
}
