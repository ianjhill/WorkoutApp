//
//  BookWorm_ConceptsApp.swift
//  BookWorm Concepts
//
//  Created by Ian Hill on 9/6/22.
//

import SwiftUI

@main
struct Fitness_AppApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            WorkoutTrackerView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
