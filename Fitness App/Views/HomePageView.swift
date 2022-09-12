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
                    ForEach(workouts.indices) { index in
                        if index < 3 {
                            HStack {
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text(workouts[index].type ?? "Unknown Workout Type")
                                            .font(.headline)
                                        Text(workouts[index].name ?? "Unknown Workout Name")
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
            
                Text("Last 3 foods eaten")
                    .foregroundColor(.black)
                    .padding(.horizontal)
                List {
                    ForEach(food.indices) { index in
                        if index < 3 {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(food[index].name!)
                                        .bold()
                                    
                                    Text("\(Int(food[index].calories))") + Text(" calories")
                                        .foregroundColor(.red)
                                }
                                Spacer()
                                Text(food[index].date!.calcTimeSince())
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
