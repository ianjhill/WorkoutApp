//
//  ProfileView.swift
//  Fitness App
//
//  Created by Ian Hill on 9/9/22.
//

import SwiftUI

struct ProfileView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
            }
            .navigationTitle("Profile")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
