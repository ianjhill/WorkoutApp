//
//  HomePageView.swift
//  Fitness App
//
//  Created by Ian Hill on 9/9/22.
//

import SwiftUI

struct HomePageView: View {
    @FetchRequest(sortDescriptors: []) var workouts: FetchedResults<Workout>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var food: FetchedResults<Food>
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Last 3 workouts done.")
                    .foregroundColor(.black)
                    .padding(.horizontal)
                List {
                    ForEach(workouts.suffix(3)) { workout in
                        VStack(alignment: .leading, spacing: 6) { // Line Spacing of 6 between Listed workout type & name
                            Text(workout.type ?? "Unknown Workout Type")
                                .font(.headline)
                            Text(workout.name ?? "Unknown Workout Name")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .listStyle(.plain)
                
                Text("Last 3 foods eaten")
                    .foregroundColor(.black)
                    .padding(.horizontal)
                List {
                    ForEach(food.suffix(3)) { food in
                        HStack {
                            VStack(alignment: .leading, spacing: 6) { // Line Spacing of 6 between Listed food name & calories
                                Text(food.name!)
                                    .bold()
                                
                                Text("\(Int(food.calories))") + Text(" calories")
                                    .foregroundColor(.red)
                            }
                            Spacer()
                            if let foodDate = food.date {
                                Text(foodDate.calcTimeSince())
                                    .foregroundColor(.gray)
                                    .italic()
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Ian's Fitness App")
            .padding()
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
