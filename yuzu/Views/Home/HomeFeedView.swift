//
//  HomeFeedView.swift
//  yuzu
//
//  Created by Alex King on R 5/08/08.
//

import SwiftUI

struct HomeFeedView: View {
    @State private var isRefreshing = false
    @State private var items = [Int](1...100)
    
    var body: some View {
        ScrollView {
            VStack{
                ForEach(items, id: \.self) { item in
                    Text("Post \(item)")
                        .padding()
                        .frame(height: 100)
                        .frame(maxWidth: .infinity)
                        .background(Color.purple)
                }
            }
        }
        
    }
}

struct HomeFeedView_Previews: PreviewProvider {
    static var previews: some View {
        HomeFeedView()
    }
}
