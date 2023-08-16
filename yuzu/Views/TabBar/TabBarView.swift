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
    
    @State private var isPostCreateSheetVisible = false
    @State private var previousSelectedTab: Int = 0
    @State private var latestSelectedTab: Int = 0
    @State private var highlightedTab: Int?
    @State private var isSidebarVisible: Bool = false
    @State private var xOffset: CGFloat = 0.0
    
    
    @State private var isPostDetailViewPresented: Bool = false
    
    @State private var sideBarSize:CGFloat = 275
    
    var overlayOpacity: Double {
        Double(xOffset / self.sideBarSize) * 0.5
    }
    
    
    var body: some View {
        ZStack(alignment: .leading) {
            SideBarMenuView()
                .frame(width: self.sideBarSize)
                .background(Color.blue)
            
            TabView(selection: $selectedTab) {
                HomeView(isPostDetailViewPresented: $isPostDetailViewPresented)
                   
                    
                    .tabItem {
                        Image(
                            selectedTab == 0 || highlightedTab == 0 ?
                            (colorScheme == .dark ? "House-Solid-Dark" : "House-Solid")
                            :
                                (colorScheme == .dark ? "House-Unselected-Dark" : "House-Unselected")
                        )
                        .padding(.top, 100)
                        
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
                
                TempBlankView(isPostCreateSheetVisible: $isPostCreateSheetVisible,
                              selectedTab: $selectedTab,
                              previousSelectedTab: $previousSelectedTab)
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
            .overlay(
                Rectangle()
                    .fill(Color.black.opacity(overlayOpacity))
                    .ignoresSafeArea()
            )
            .overlay(
                Group {
                    if xOffset > 0 {
                        Rectangle()
                            .fill(Color.black.opacity(overlayOpacity))
                            .ignoresSafeArea()
                            .onTapGesture {
                                withAnimation {
                                    isSidebarVisible = false
                                    self.xOffset = 0
                                    
                                }
                            }
                    }
                }
            )
            .onChange(of: selectedTab) { newTab in
                
                previousSelectedTab = latestSelectedTab
                latestSelectedTab = newTab
            }
            .sheet(isPresented: $isPostCreateSheetVisible) {
                PostCreateView(isPostCreateSheetVisible: $isPostCreateSheetVisible)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .offset(x: xOffset)
            
            .gesture(
                selectedTab == 0 && !self.isPostDetailViewPresented ? DragGesture()
                    .onChanged { value in
                        // Check if the gesture is more horizontal than vertical
                        if abs(value.translation.width) > abs(value.translation.height) {
                            if value.translation.width > 0 {
                                self.xOffset = min(self.sideBarSize, value.translation.width)
                            } else if self.isSidebarVisible {
                                self.xOffset = min(self.sideBarSize, max(0, self.sideBarSize + value.translation.width))
                            }
                        }
                    }
                    .onEnded { value in
                        if abs(value.translation.width) > abs(value.translation.height) {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                if self.xOffset < 200 && isSidebarVisible {
                                    self.isSidebarVisible = false
                                    self.xOffset = 0
                                } else if self.xOffset > 50{
                                    self.isSidebarVisible = true
                                    self.xOffset = self.sideBarSize
                                } else {
                                    self.isSidebarVisible = false
                                    self.xOffset = 0
                                }
                            }
                        }
                    } :
                    nil

            )
            
            
        }
    }
    
}


struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}


struct TempBlankView: View {
    @Binding var isPostCreateSheetVisible: Bool
    @Binding var selectedTab: Int
    @Binding var previousSelectedTab: Int
    var body: some View {
        VStack {
            
        }
        .onAppear{
            selectedTab = previousSelectedTab
            isPostCreateSheetVisible = true
        }
        
    }
}
