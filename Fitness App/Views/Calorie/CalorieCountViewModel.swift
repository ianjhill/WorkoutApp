//
//  CalorieCountViewModel.swift
//  Fitness App
//
//  Created by Ian Hill on 9/23/22.
//

import SwiftUI

struct CalorieCountViewModel: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var food: FetchedResults<Food>
    
    @State private var caloricGoal: Double = 500
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Daily Caloric Goal: \(Int(caloricGoal))")
                .padding()
            Slider(value: $caloricGoal, in: 500...4000, step: 10)
                .padding(.horizontal)
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
        }
    }
    func totalCaloriesToday() -> Double {
        var caloriesToday: Double = 0
        for item in food {
            if Calendar.current.isDateInToday(item.date!) {
                caloriesToday += item.calories
            }
        }
        return caloriesToday
    }
    
    func dailyCaloriesLeft() -> Double {
        let dailyCaloriesLeft = caloricGoal - totalCaloriesToday()
        return dailyCaloriesLeft
        
    }
}

struct CalorieCountViewModel_Previews: PreviewProvider {
    static var previews: some View {
        CalorieCountViewModel()
    }
}
