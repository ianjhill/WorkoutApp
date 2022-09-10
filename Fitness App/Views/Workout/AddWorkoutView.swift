//
//  AddWorkoutView.swift
//  Fitness App
//
//  Created by Ian Hill on 9/7/22.
//

import SwiftUI

struct AddWorkoutView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var reps = 9
    @State private var sets = 2
    @State private var type = ""
    @State private var weight = 10
    
    let types = ["Biceps", "Triceps", "Shoulders", "Back", "Chest", "Legs", "Core"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Type", selection: $type) {
                        ForEach(types, id: \.self) {
                            Text($0)
                        }
                    }
                    TextField("Name of Workout", text: $name)
                }

                Section(header: Text("Details")) {
                    Picker("Weight", selection: $weight) {
                        ForEach(0..<51) {
                            Text(String($0 * 5))
                        }
                    }
                    Picker("Sets", selection: $sets) {
                        ForEach(1..<6) {
                            Text(String($0))
                        }
                    }
                    Picker("Reps", selection: $reps) {
                        ForEach(1..<21) {
                            Text(String($0))
                        }
                    }
                }
                Section {
                    Button("Save") {
                        let newWorkout = Workout(context: moc)
                        newWorkout.id = UUID()
                        newWorkout.type = type
                        newWorkout.name = name
                        newWorkout.reps = Int16(reps)
                        newWorkout.sets = Int16(sets)

                        try? moc.save()
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Workout")
        }
    }
}

struct AddWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkoutView()
    }
}
