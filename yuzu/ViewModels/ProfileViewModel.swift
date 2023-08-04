//
//  ProfileViewModel.swift
//  yuzu
//
//  Created by Alex King on R 5/08/03.
//

import SwiftUI



class ProfileViewModel: ObservableObject {
    @Published var user: User?

    func fetchUserData() {
//        AuthenticationService().getUserData { success, user, message in
//            if success {
//                DispatchQueue.main.async {
//                    self.user = {id: 0; username: "test"; email: "test"}
//                }
//            } else {
//                print("Failed to fetch user data: \(message)")
//            }
//        }
    }
}
