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
    
    @State private var caloricGoal: Double = 500
    
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Daily Caloric Goal: \(Int(caloricGoal))")
                    .padding()
                Slider(value: $caloricGoal, in: 500...4000, step: 10)
                    .padding(.horizontal)
                Spacer()
                Text("\(Int(totalCaloriesToday())) Kcal eaten today")
                    .foregroundColor(.gray)
                    .padding()
                
                if dailyCaloriesLeft() > 0 {
                    Text("\(Int(dailyCaloriesLeft())) calories needed to reach daily goal")
                        .foregroundColor(.red)
                        .padding(.horizontal)
                } else {
                    Text("Congratulations, you have reached your daily caloric intake")
                        .foregroundColor(.green)
                        .padding(.horizontal)
                }
                
                List {
                    ForEach(food) { food in
                        NavigationLink(destination: EditFood(food: food)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
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
                    .onDelete(perform: deleteFood)
                }
                .listStyle(.plain)
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
        }
        .navigationViewStyle(.stack)
    }
    private func deleteFood(offsets: IndexSet) {
        withAnimation {
            offsets.map { food[$0] }.forEach(managedObjContext.delete)
            
            DataController().save(context: managedObjContext)
        }
    }
    
    private func totalCaloriesToday() -> Double {
        var caloriesToday: Double = 0
        for item in food {
            if Calendar.current.isDateInToday(item.date!) {
                caloriesToday += item.calories
            }
        }
        return caloriesToday
    }
    
    private func dailyCaloriesLeft() -> Double {
        let dailyCaloriesLeft = caloricGoal - totalCaloriesToday()
        return dailyCaloriesLeft
        
    }
}

struct CalorieTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        CalorieTrackerView()
    }
}
