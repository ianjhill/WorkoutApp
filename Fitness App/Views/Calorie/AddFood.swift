//
//  AddFood.swift
//  Fitness App
//
//  Created by Ian Hill on 9/9/22.
//

import SwiftUI

struct AddFood: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var calories: Double = 0
    
    var body: some View {
        Form {
            Section {
                TextField("Food name", text: $name)
                
                VStack {
                    Text("Calories: \(Int(calories))")
                    Slider(value: $calories, in: 0...1000, step: 10)
                }
                .padding()
                
                HStack {
                    Spacer()
                    Button("Submit") {
                        DataController().addFood(name: name, calories: calories, context: managedObjContext)
                        dismiss()
                    }
                    Spacer()
                    
                }
            }
        }
    }
}

struct AddFood_Previews: PreviewProvider {
    static var previews: some View {
        AddFood()
    }
}
