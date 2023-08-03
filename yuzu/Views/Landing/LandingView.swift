//
//  LandingView.swift
//  yuzu
//
//  Created by Alex King on R 5/08/03.
//

import SwiftUI

struct LandingView: View {

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: LoginView()
                        .navigationBarBackButtonHidden(true)
                        .navigationBarTitle("")
                ) {
                    Text("Login")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                NavigationLink(
                    destination: SignupView()
                        .navigationBarBackButtonHidden(true)
                        .navigationBarTitle("")
                ) {
                    Text("Sign Up")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
            .navigationBarTitle("Welcome to the App")
        }
    }
}



struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
