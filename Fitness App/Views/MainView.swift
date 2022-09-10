//
//  FitnessHomePage.swift
//  Fitness App
//
//  Created by Ian Hill on 9/9/22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
                HomePageView()
                    .tabItem {
                        Image(systemName: "house.circle.fill")
                        Text("Home")
                }
                WorkoutTrackerView()
                    .tabItem {
                        Image(systemName: "figure.walk.circle.fill")
                        Text("Workouts")
                }
                CalorieTrackerView()
                    .tabItem {
                        Image(systemName: "heart.circle.fill")
                        Text("Calories")
                }
                ProfileView()
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Profile")
                }
            }
        }
    }
    

struct FitnessHomePage_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
