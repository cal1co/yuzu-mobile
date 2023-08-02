//
//  TabBarView.swift
//  yuzu
//
//  Created by Alex King on R 5/08/02.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 0
    @Environment (\.colorScheme) var colorScheme
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(
                        selectedTab == 0 ?
                        (colorScheme == .dark ? "House-Solid-Dark" : "House-Solid")
                        :
                        (colorScheme == .dark ? "House-Unselected-Dark" : "House-Unselected")
                    )
                }
                .tag(0)

            SearchView()
                .tabItem {
                    Image(
                        selectedTab == 1 ?
                        (colorScheme == .dark ? "Search-Selected-Dark" : "Search-Selected-Light")
                        :
                        (colorScheme == .dark ? "Search-Unselected-Dark" : "Search-Unselected-Light")
                    )
                }
                .tag(1)

            PostCreateView()
                .tabItem {
                    Image(
                        selectedTab == 2 ?
                        (colorScheme == .dark ? "Post-Create-Selected-Dark" : "Post-Create-Selected-Light")
                        :
                        (colorScheme == .dark ? "Post-Create-Unselected-Dark" : "Post-Create-Unselected-Light")
                        )
                }
                .tag(2)

            NotificationsView()
                .tabItem {
                    Image(
                        selectedTab == 3 ?
                        (colorScheme == .dark ? "Notifications-Selected-Dark" : "Notifications-Selected-Light")
                        :
                        (colorScheme == .dark ? "Notifications-Unselected-Dark" : "Notifications-Unselected-Light")
                        )
                }
                .tag(3)
            
            ProfileView()
                .tabItem {
                    Image(
                        selectedTab == 4 ?
                        (colorScheme == .dark ? "Profile-Selected-Dark" : "Profile-Selected-Light")
                        :
                        (colorScheme == .dark ? "Profile-Unselected-Dark" : "Profile-Unselected-Light")
                    )
                }
                .tag(4)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
