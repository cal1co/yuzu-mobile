//
//  LoginView.swift
//  yuzu
//
//  Created by Alex King on R 5/08/03.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
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
            VStack(spacing: 0){
                TextField("Username or Email", text: $email)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .font(.system(size: 20)) // Increase font size
                    .padding(10)
//                    .background(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                    .clipShape(RoundedCorner(radius: 5, corners: [.topLeft, .topRight]))

                
                PasswordInputView(password: $password)
                    .padding([.leading, .trailing], 10)
                    .font(.system(size: 20)) // Increase font size
                    .padding(10)
//                    .background(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                    .clipShape(RoundedCorner(radius: 5, corners: [.bottomLeft, .bottomRight]))
                
                Button(action: {
                    print("Password: \(password)")
                }) {
                    Text("Sign In")
                }
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                
                
            }
            .padding()
            .navigationBarItems(leading:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .font(Font.system(size: 20, weight: .semibold))
//                        Text("Back")
                            .font(Font.system(size: 20, weight: .semibold))
                    }
                }
            )
        }
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

