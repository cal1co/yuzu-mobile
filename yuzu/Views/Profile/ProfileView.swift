//
//  ProfileView.swift
//  yuzu
//
//  Created by Alex King on R 5/08/02.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var profileViewModel = ProfileViewModel()
    @State private var scrollOffset: CGFloat = 0
        
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    GeometryReader { geometry in
                        Color.clear.preference(key: ScrollOffsetPreferenceKey.self,
                        value: geometry.frame(in: .named("ScrollView")).minY)
                    }.frame(height: 0)
                    RoundedRectangle(cornerRadius: 0) // Adjust as needed
                       .fill(Color.white)
                       .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 2)
                       .frame(height:380)
                       .overlay(
                        
                        ProfileInfoView()
                    
                    )
//                       .padding(.top, 100)
//                        .padding(.top, 50)
                    ProfileFeedView()
                }
            }
            .coordinateSpace(name: "ScrollView")
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { offset in
                let headerHeight: CGFloat = 300
                if -offset > headerHeight {
                    scrollOffset = headerHeight
                } else {
                    scrollOffset = -offset
                }
            }
            
            VStack {
                ProfileHeaderView()
                    .frame(height: 80)
                    .background(Color.white)
                    .opacity(scrollOffset > 300 ? 1 : 0)
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
