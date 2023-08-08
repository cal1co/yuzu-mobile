//
//  HomeFeedView.swift
//  yuzu
//
//  Created by Alex King on R 5/08/08.
//

import SwiftUI

struct HomeFeedView: View {
    @State private var isRefreshing = false
    @State private var items = [Int](1...10)
    
    var body: some View {
        VStack{
            List {
                ForEach(items, id: \.self) { item in
                    Text("Post \(item)")
                        .padding()
                }
            }
            .frame(height:800)
            .refreshable {
                isRefreshing = true
                
                DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                    items.shuffle()
                    
                    DispatchQueue.main.async {
                        isRefreshing = false
                    }
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
