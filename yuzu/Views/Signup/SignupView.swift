//
//  SignupView.swift
//  yuzu
//
//  Created by Alex King on R 5/08/03.
//

import SwiftUI

struct SignupView: View {
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @ObservedObject var authenticationService = AuthenticationService()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
        
    var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
                Text("")
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .border(Color.gray, width: 0.5)
                TextField("Username", text: $username)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .border(Color.gray, width: 0.5)
                
                PasswordInputView(password: $password).padding().border(Color.gray, width: 0.5)
                
                Button(action: {
                    AuthenticationService().signUp(username: username, email: email, password: password) { success, signUpResponse, message in
                            if success {
                                print("Signed up successfully! User ID: \(signUpResponse?.user.id ?? 0), Token: \(signUpResponse?.token ?? "")")
                            if let token = signUpResponse?.token {
                                UserDefaults.standard.set(token, forKey: "authToken")
                                print("Token saved to UserDefaults.")
                            }
                            } else {
                                print("Failed to sign up: \(message)")
                            }
                        }
                }) {
                    Text("Sign Up")
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }

            }
            .padding()
            .navigationBarItems(leading:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .font(Font.system(size: 20, weight: .semibold))
                    }
                }
            )
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
