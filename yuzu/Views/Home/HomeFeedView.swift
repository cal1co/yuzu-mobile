//
//  HomeFeedView.swift
//  yuzu
//
//  Created by Alex King on R 5/08/08.
//

import SwiftUI

struct HomeFeedView: View {
    @State private var isRefreshing = false
    
    @Binding var isPostDetailViewPresented: Bool
    
    var post = Post(post_id: "1", post_content: "This is a test post.", user_id: 1, created_at: "01-01-2023", like_count: 10, comments_count: 2, username: "testuser", liked: false, display_name: "Test User", profile_image_data: "", profile_image: "", media: [])
    
    var items:[Post] { [post] } 
    
    var body: some View {
        
            ScrollView {
                VStack{
                    ForEach(items) { post in   
                        NavigationLink(destination: PostDetailView(post: post, isPostDetailViewPresented: $isPostDetailViewPresented)) {
                            Text("Post \(post.post_content)")
                                .padding()
                                .frame(height: 100)
                                .frame(maxWidth: .infinity)
                                .background(Color.purple)
                        }
                    }
                }
            }
        
    }
}


struct HomeFeedView_Preview: PreviewProvider {
    @State static var isPostDetailViewPresented = false

    static var previews: some View {
        HomeFeedView(isPostDetailViewPresented: $isPostDetailViewPresented)
    }
}
