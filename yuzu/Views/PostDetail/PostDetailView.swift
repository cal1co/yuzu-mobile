//
//  PostDetailView.swift
//  yuzu
//
//  Created by Alex King on R 5/08/14.
//

import SwiftUI

struct PostDetailView: View {
    var post: Post
    @Binding var isPostDetailViewPresented: Bool
    
    var body: some View {
        VStack {
            Text(post.post_content)
        }
        .zIndex(2)
        .navigationBarTitle(Text(post.username), displayMode: .inline)
        .onAppear {
            isPostDetailViewPresented = true
            print("hi")
            print(isPostDetailViewPresented)
        }
        .onDisappear {
            isPostDetailViewPresented = false
            print("bye")
            print(isPostDetailViewPresented)
        }
    }
}

//struct PostDetailView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        let post = Post(post_id: "1", post_content: "This is a test post.", user_id: 1, created_at: "01-01-2023", like_count: 10, comments_count: 2, username: "testuser", liked: false, display_name: "Test User", profile_image_data: "", profile_image: "", media: [])
//        var isPostDetailViewPresented = false
//        
//        PostDetailView(post: post, isPostDetailViewPresented: $isPostDetailViewPresented)
//    }
//}
