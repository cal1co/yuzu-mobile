//
//  yuzuApp.swift
//  yuzu
//
//  Created by Alex King on R 5/08/01.
//

import SwiftUI

@main
struct yuzuApp: App {
    @StateObject var authService = AuthenticationService()

        var body: some Scene {
            WindowGroup {
//                if authService.isAuthenticated {
                    TabBarView().environmentObject(authService)
//                } else {
//                    LandingView().environmentObject(authService)
//                }
            }
        }
}
