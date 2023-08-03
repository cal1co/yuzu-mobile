//
//  AuthenticationService.swift
//  yuzu
//
//  Created by Alex King on R 5/08/03.
//
import Foundation


struct User: Codable, Identifiable {
    let id: Int
    let username: String
    let email: String
}
struct SignUpResponse: Codable {
    let user: User
    let token: String
}


class AuthenticationService: ObservableObject {
    @Published var isAuthenticated = false
    let tokenKey = "userToken"

    init() {
        isAuthenticated = UserDefaults.standard.string(forKey: tokenKey) != nil
    }
    
    func checkAuthentication(completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let url = URL(string: "http://localhost:3000/api/auth/user/verify") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        guard let token = UserDefaults.standard.string(forKey: tokenKey) else {
            print("No token found")
            return
        }
        print(token)
            
//        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTMsInVzZXJuYW1lIjoidGVzdCIsImVtYWlsIjoidGVzdEB0ZXN0LmNvbSIsImlhdCI6MTY5MTA2NDcxMH0.nVKvMIgTn5pk7S2vPZxLG2a4DhJGEZWlWxNgZ9IHNwA", forHTTPHeaderField: "Authorization")
        
            
        let task = URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
                
            if let httpResponse = response as? HTTPURLResponse {
                DispatchQueue.main.async {
                    self.isAuthenticated = httpResponse.statusCode == 200
                    completion(.success(self.isAuthenticated))
                }
            }
        }
        task.resume()
    }
    
    func signUp(username: String, email: String, password: String, completion: @escaping (Bool, SignUpResponse?, String) -> Void) {
        let url = URL(string: "http://localhost:3000/api/auth/register")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let body: [String : Any] = [
            "username": username,
            "email": email,
            "password": password
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(false, nil, "Request Failed: \(error)")
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let signUpResponse = try decoder.decode(SignUpResponse.self, from: data)
                    completion(true, signUpResponse, "Signed up successfully!")
                } catch let decodingError {
                    print("Decoding failed with error: \(decodingError)")
                    let responseString = String(data: data, encoding: .utf8)
                    print("Response data string:\n \(responseString ?? "")")
                    completion(false, nil, "Failed to sign up.")
                }
            }
        }
        task.resume()
    }



    func signOut() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
        isAuthenticated = false
    }
}
