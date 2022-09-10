//
//  WorkoutDetailView.swift
//  Fitness App
//
//  Created by Ian Hill on 9/8/22.
//

import CoreData
import SwiftUI

struct WorkoutDetailView: View {
    let workout: Workout
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(workout.type ?? "Biceps")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)

                Text(workout.type?.uppercased() ?? "BICEPS")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            Text(workout.name ?? "Unknown workout")
                .font(.title)
                .foregroundColor(.secondary)

            VStack{
                Text("Weight: \(workout.weight)")
                    .padding()
                Text("Sets: \(workout.sets)")
                    .padding()
                Text("Reps: \(workout.reps)")
                    .padding()
            }
            

        }
        .navigationTitle(workout.type ?? "Unknown Workout Type")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete workout", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteWorkout)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this workout", systemImage: "trash")
            }
        }
    }
    
    func deleteWorkout() {
        moc.delete(workout)

        // uncomment this line if you want to make the deletion permanent
        try? moc.save()
        dismiss()
    }
}
