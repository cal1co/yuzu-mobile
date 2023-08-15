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
    
    var items:[Post] { [Post(post_id: "1", post_content: "This is a test post.", user_id: 1, created_at: "01-01-2023", like_count: 10, comments_count: 2, username: "testuser", liked: false, display_name: "Test User", profile_image_data: "", profile_image: "", media: []),
        Post(post_id: "2", post_content: "This is another test post.", user_id: 1, created_at: "02-01-2023", like_count: 15, comments_count: 5, username: "testuser", liked: true, display_name: "Test User", profile_image_data: "", profile_image: "", media: []),
        Post(post_id: "3", post_content: "This is another test post.", user_id: 1, created_at: "02-01-2023", like_count: 15, comments_count: 5, username: "testuser", liked: true, display_name: "Test User", profile_image_data: "", profile_image: "", media: []),
        Post(post_id: "4", post_content: "This is another test post.", user_id: 1, created_at: "02-01-2023", like_count: 15, comments_count: 5, username: "testuser", liked: true, display_name: "Test User", profile_image_data: "", profile_image: "", media: []),
        Post(post_id: "5", post_content: "This is another test post.", user_id: 1, created_at: "02-01-2023", like_count: 15, comments_count: 5, username: "testuser", liked: true, display_name: "Test User", profile_image_data: "", profile_image: "", media: []),
        Post(post_id: "6", post_content: "This is another test post.", user_id: 1, created_at: "02-01-2023", like_count: 15, comments_count: 5, username: "testuser", liked: true, display_name: "Test User", profile_image_data: "", profile_image: "", media: []),
        Post(post_id: "7", post_content: "This is a test post.", user_id: 1, created_at: "01-01-2023", like_count: 10, comments_count: 2, username: "testuser", liked: false, display_name: "Test User", profile_image_data: "", profile_image: "", media: []),
        Post(post_id: "8", post_content: "This is another test post.", user_id: 1, created_at: "02-01-2023", like_count: 15, comments_count: 5, username: "testuser", liked: true, display_name: "Test User", profile_image_data: "", profile_image: "", media: []),
        Post(post_id: "9", post_content: "This is another test post.", user_id: 1, created_at: "02-01-2023", like_count: 15, comments_count: 5, username: "testuser", liked: true, display_name: "Test User", profile_image_data: "", profile_image: "", media: []),
        Post(post_id: "10", post_content: "This is another test post.", user_id: 1, created_at: "02-01-2023", like_count: 15, comments_count: 5, username: "testuser", liked: true, display_name: "Test User", profile_image_data: "", profile_image: "", media: []),
        Post(post_id: "11", post_content: "This is another test post.", user_id: 1, created_at: "02-01-2023", like_count: 15, comments_count: 5, username: "testuser", liked: true, display_name: "Test User", profile_image_data: "", profile_image: "", media: []),
        Post(post_id: "12", post_content: "This is another test post.", user_id: 1, created_at: "02-01-2023", like_count: 15, comments_count: 5, username: "testuser", liked: true, display_name: "Test User", profile_image_data: "", profile_image: "", media: [])
    ] }
    
    var body: some View {
        
            ScrollView {
                VStack{
                    ForEach(items) { post in   
                        NavigationLink(destination: PostDetailView(post: post, isPostDetailViewPresented: $isPostDetailViewPresented)) {
                            PostRenderView(postId: post.post_id, postContent: post.post_content, userId: post.user_id, dateCreated: post.created_at, likeCount: post.like_count, commentsCount: post.comments_count, username: post.username, liked: post.liked, displayName: post.display_name, profileImage: post.profile_image, media: post.media)
//                            Text("Post \(post.post_content)")
//                                .padding()
//                                .frame(height: 100)
//                                .frame(maxWidth: .infinity)
//                                .background(Color.purple)
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
