//
//  CalorieListViewModel.swift
//  Fitness App
//
//  Created by Ian Hill on 9/23/22.
//

import SwiftUI

struct CalorieListViewModel: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var food: FetchedResults<Food>
    
    var body: some View {
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
    private func deleteFood(offsets: IndexSet) {
        withAnimation {
            offsets.map { food[$0] }.forEach(managedObjContext.delete)
            
            DataController().save(context: managedObjContext)
        }
    }
}

struct CalorieListViewModel_Previews: PreviewProvider {
    static var previews: some View {
        CalorieListViewModel()
    }
}
