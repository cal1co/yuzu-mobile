//
//  HomeView.swift
//  yuzu
//
//  Created by Alex King on R 5/08/02.
//

import SwiftUI

struct Post: Codable, Identifiable {
    let post_id: String
    let post_content: String
    let user_id: Int
    let created_at: String
    let like_count: Int
    let comments_count: Int
    let username: String
    let liked: Bool
    let display_name: String
    let profile_image_data: String
    let profile_image: String
    let media: [String]?
    
    var id: String { post_id }
}

class HomeViewModel: ObservableObject {
    @Published var posts: [Post] = []
    
    func fetchPosts() {
        guard let url = URL(string: "http://localhost:8080/v1/feed/1") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([Post].self, from: data)
                    DispatchQueue.main.async {
                        print(decodedResponse)
                        self.posts = decodedResponse
                    }
                } catch let decodeError {
                    print("Decoding failed: \(decodeError)")
                }
            } else if let error = error {
                print("Fetch failed: \(error.localizedDescription)")
            }
        }
        task.resume()

    }
}

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        List(viewModel.posts) { post in
            Text(post.post_content)
        }
        .onAppear {
            viewModel.fetchPosts()
        }
    }
}
