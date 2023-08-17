//
//  SideBarMenuView.swift
//  yuzu
//
//  Created by Alex King on R 5/08/16.
//

import SwiftUI

struct SidebarMenuView: View {
    @State private var isLoggedIn = true // You can adjust this based on user's login status
    @State private var displayname = "Calico"
    @State private var username = "Calico2"
    @State private var followingCount = 123
    @State private var followCount = 1_234
    @State private var isSettingsViewActive = false

    var body: some View {
        NavigationView {
            
       
        VStack(alignment: .leading) {
            if isLoggedIn {
                VStack(alignment: .leading, spacing: 16) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                        .padding(.top)

                    Text(displayname)
                        .font(.headline)
                    Text(username)
                        .font(.subheadline)
                    
                    HStack {
                        Text("\(followingCount) Following")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("\(followCount) Followers")
                            .font(.subheadline)
                        .foregroundColor(.gray)
                        
                    }
                }
                .padding(.horizontal)

                Divider()
                    .padding(.vertical)

                Button(action: {
                    // Handle Bookmarks action
                }) {
                    HStack {
                        Image("Bookmarks-Unselected-Light")
                        Text("Bookmarks")
                            .font(.custom("Hiragino Kaku Gothic ProN", size: 16))
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                    .foregroundColor(.primary)
                }

                Button(action: {
                    // Handle other buttons action
                }) {
                    HStack {
                        Image("Messages-Unselected-Light")
                        Text("Notifications")
                            .font(.custom("Hiragino Kaku Gothic ProN", size: 16))
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                    .foregroundColor(.primary)
                }

                Spacer()
                Button(action: {
                   isSettingsViewActive = true
               }) {
                   HStack {
                       Image(systemName: "gearshape.fill")
                       Text("Settings")
                   }
                   .padding(.vertical, 8)
                   .padding(.horizontal)
                   .foregroundColor(.primary)
               }
//               .background(NavigationLink("", destination: SettingsView(), isActive: $isSettingsViewActive).hidden())
                
                Button(action: {
                    // Handle logout action
                    isLoggedIn = false
                }) {
                    HStack {
                        Image(systemName: "arrow.right.circle.fill")
                        Text("Log Out")
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                    .foregroundColor(.red)
                }
                .padding(.bottom)
            } else {
                VStack {
                    
                    Spacer()
                    Button(action: {
                        // Handle login action
                        isLoggedIn = true
                    }) {
                        HStack {
                            Image(systemName: "arrow.left.circle.fill")
                            Text("Log In")
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal)
//                        .foregroundColor(.blue)
                    }
                    Spacer()
                }
            }
        }
        .frame(width: 250)
        .background(Color.white)
        .sheet(isPresented: $isSettingsViewActive) {  
            SettingsView()
        }
        }
    }
}

struct SidebarMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarMenuView()
    }
}
