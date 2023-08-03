//
//  PasswordInputView.swift
//  yuzu
//
//  Created by Alex King on R 5/08/03.
//

import SwiftUI

struct PasswordInputView: View {
    @Binding var password: String
    @State private var showPassword: Bool = false

    var body: some View {
        HStack {
            if showPassword {
                TextField("Password", text: $password)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            } else {
                SecureField("Password", text: $password)
            }
            
            Button(action: {
                self.showPassword.toggle()
            }) {
                Image(systemName: self.showPassword ? "eye.slash.fill" : "eye.fill")
            }
        }
    }
}


