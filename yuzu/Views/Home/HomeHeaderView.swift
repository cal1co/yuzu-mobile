//
//  HomeHeaderView.swift
//  yuzu
//
//  Created by Alex King on R 5/08/08.
//

import SwiftUI

struct HomeHeaderView: View {
    @Environment (\.colorScheme) var colorScheme
    var body: some View {
        RoundedRectangle(cornerRadius: 0)
            .fill(colorScheme == .dark ? Color.black : Color.white)
           .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 2)
           .frame(height:60)
           .overlay(
            
//            HStack {
                Text("Header")
//            }
//            .frame(height:80)
//            .frame(maxWidth:.infinity)
            
        
        )
        
//        .background(Color.gray)
    }
}

struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView()
    }
}
