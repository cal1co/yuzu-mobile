//
//  PostRenderView.swift
//  yuzu
//
//  Created by Alex King on R 5/08/07.
//

import SwiftUI


struct PostRenderView: View {
    
    @Environment (\.colorScheme) var colorScheme
    @State private var isMenuOpen = false
    
    let postId: String
    let postContent: String
    let userId: Int
    let dateCreated: String
    let likeCount: Int
    let commentsCount: Int
    let username: String
    let liked: Bool
    let displayName: String
    let profileImage: String
    let media: [String]?

    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading) {
                HStack(alignment: .top, spacing: 10) {
                    if profileImage.isEmpty {
                        Color.gray
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    } else {
                        Image(profileImage)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                        
                    
                    VStack(alignment: .leading, spacing: 5) {
                        
                        HStack {
                            Text(displayName)
                                .font(.custom("Hiragino Kaku Gothic ProN", size: 14))
                                .fontWeight(.bold)
                            Text("@" + username)
                                .font(.custom("Hiragino Kaku Gothic ProN", size: 12))
                                .foregroundColor(.gray)
                            Spacer()
                            Text(dateCreated)
                                .font(.caption)
                                .foregroundColor(.gray)
                            Menu {
                                Button("Block User", action: {
                                    print("Block User action")
                                })
                                Button("Follow User", action: {
                                    print("Follow User action")
                                })
                                Button("Mute User", action: {
                                    print("Mute User action")
                                })
                                Button("Report Post", action: {
                                    print("Report Post action")
                                })
                            } label: {
                                ZStack {
//                                    if isMenuOpen {
//                                        Circle()
//                                            .fill(Color(red: 0/255,  green: 186/255, blue: 124 / 255))
//                                            .frame(width: 30, height: 30)
//                                    }
                                    Image(
                                          colorScheme == .dark ?
                                          "Ellipsis-Dark"
                                          :
                                            "Ellipsis-Light")
                                        .font(.title)
                                        .frame(width: 25, height: 25)
                                }
                            }
                            .onTapGesture {
                                withAnimation(.easeIn(duration: 0.3)) {
                                    isMenuOpen.toggle()
                                }
                            }
                        }
                        
                        ZStack {
                            
                            Text(postContent)
                                .font(.custom("Hiragino Kaku Gothic ProN", size: 12))
                                .lineSpacing(1.15)
                                .kerning(0.05)
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 217/255, green: 217/255, blue: 217/255))
                                .padding(9)
                                .background(colorScheme == .dark ? Color(red: 36/255, green: 36/255, blue: 36/255) : Color(red: 217/255, green: 217/255, blue: 217/255))
                                .cornerRadius(5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(colorScheme == .dark ? Color(red: 190/255, green: 186/255, blue: 186/255) : Color.black, lineWidth: 2)
                                )
                                .offset(x:8, y: 8)
                            

                            Text(postContent)
                                .font(.custom("Hiragino Kaku Gothic ProN", size: 12))
                                .lineSpacing(1.15)
                                .kerning(0.05)
                                .fontWeight(.bold)
                                .padding(9)
                                .background(colorScheme == .dark ? Color.black : Color.white)
                                .cornerRadius(5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(colorScheme == .dark ? Color(red: 190/255, green: 186/255, blue: 186/255) : Color.black, lineWidth: 2)
                                )
                            
                            
                        }
                        .padding(.top, 5)
                        .padding(.trailing, 15)



                        HStack {
                            HStack {
                                Button(action: {
                                    print("liked")
                                }) {
                                    Image (liked ? "Liked"
                                           : colorScheme == .dark ?
                                           "Unliked-Dark"
                                           :
                                            "Unliked-Light")
                                    .font(.system(size:20))
                                Text("\(likeCount)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                }
                            }
                            HStack {
                                Button(action: {
                                    print("comment")
                                }) {
                                Image(colorScheme == .dark ?
                                      "Comment-Dark"
                                      :
                                        "Comment-Light"
                                )
                                    .font(.system(size:20))
                                Text("\(commentsCount)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                }
                            }
                            .padding(.leading, 18)
                            Spacer()
                                Button(action: {
                                    print("Save Button Pressed")
                                }) {
                                    Image(colorScheme == .dark ?
                                    "Unsaved-Dark"
                                          :
                                    "Unsaved-Light")
//                                    Image("Saved")
                                }
                            
                        }
                        .padding(.top, 15)
                        
                    }
                }
                

                
            }
            .padding(.horizontal, 10)
            .padding(.top, 10)
//            .padding(.all, 10)
//            .overlay(
//                RoundedRectangle(cornerRadius: 15)
//                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
//            )
//            Spacer()
        }
    }
}


struct PostRenderView_Previews: PreviewProvider {
    static var previews: some View {
        PostRenderView(postId: "1", postContent: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ullamcorper dignissim metus, id auctor ex maximus a. Nullam ultricies consectetur augue tempus iaculis. Vestibulum commodo id tortor vel feugiat. Sed rutrum libero nec nulla dictum interdum nam.", userId: 1, dateCreated: "01-01-2023", likeCount: 10, commentsCount: 2, username: "testuser", liked: false, displayName: "Test User", profileImage: "", media: [])
    }
}
