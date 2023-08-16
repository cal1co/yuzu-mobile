//
//  SideBarMenuView.swift
//  yuzu
//
//  Created by Alex King on R 5/08/16.
//

import SwiftUI

struct SidebarMenuView: View {
    @State private var isLoggedIn = true // You can adjust this based on user's login status
    @State private var username = "Calico"
    @State private var followCount = 1_234

    var body: some View {
        VStack(alignment: .leading) {
            if isLoggedIn {
                VStack(alignment: .leading, spacing: 16) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                        .padding(.top)

                    Text(username)
                        .font(.headline)
                    
                    Text("\(followCount) Followers")
                        .font(.subheadline)
                        .foregroundColor(.gray)
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
                            .font(.custom("Hiragino Kaku Gothic ProN", size: 14))
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
                            .font(.custom("Hiragino Kaku Gothic ProN", size: 14))
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                    .foregroundColor(.primary)
                }

                Spacer()

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
//        .shadow(radius: 5)
    }
}

struct SidebarMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarMenuView()
    }
}
