//
//  HomeFeedView.swift
//  yuzu
//
//  Created by Alex King on R 5/08/08.
//

import SwiftUI

struct HomeFeedView: View {
    @State private var items = [Int](1...10)
    @Binding var isRefreshing: Bool
    @State private var pullOffset: CGFloat = 0
    
    var body: some View {
        VStack {
            if isRefreshing {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            }
            
            ScrollView {
                VStack {
                    ForEach(items, id: \.self) { item in
                        Text("Post \(item)")
                            .padding()
                            .frame(height:200)
                    }
                    
                }
                .offset(y: pullOffset)
                .gesture(DragGesture(coordinateSpace: .local)
                            .onChanged { value in
                                if value.translation.height > 0 {
                                    pullOffset = value.translation.height
                                }
                            }
                            .onEnded { value in
                                if pullOffset > 50 {
                                    refresh()
                                }
                                withAnimation {
                                    pullOffset = 0
                                }
                            }
                )
            }
        }
    }
    
    private func refresh() {
        isRefreshing = true
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            items.shuffle()
            
            DispatchQueue.main.async {
                isRefreshing = false
            }
        }
    }
}

//
//struct HomeFeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeFeedView(isRefreshing:false)
//    }
//}
