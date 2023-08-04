//
//  ProfileInfoView.swift
//  yuzu
//
//  Created by Alex King on R 5/08/04.
//

import SwiftUI

struct ProfileInfoView: View {
    @State var displayName = "Test User"
    @State var username = "testuser"
    @State var bio = "This is a test bio."
    @State var followingCount = 5
    @State var followerCount = 3
    @State var postCount = 2
    
    var body: some View {
        VStack{
            Image("placeholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 75, height: 75)
                .background(Color.gray)
                .clipShape(Circle())
            
            TextFontView(text: "\(displayName)",  fontSize: 20)
                .fontWeight(.bold)
                .padding(.top, 10)
            
            TextFontView(text: "@\(username)", fontSize:14)
                .padding(.top, 5)

            TextFontView(text: "\(bio)", fontSize:14)
                .fontWeight(.bold)
                .padding(.top, 10)

            HStack {
                VStack {
                    TextFontView(text:"\(postCount)", fontSize:14)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    TextFontView(text:"Posts", fontSize:14)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }
                .frame(width:75)
                VStack {
                    TextFontView(text:"\(followingCount)", fontSize:14)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    TextFontView(text:"Following", fontSize:14)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .lineSpacing(10)
                }
                .frame(width:75, height:40)
                .fixedSize(horizontal: true, vertical: false)
                VStack {
                    TextFontView(text:"\(followerCount)", fontSize:14)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    TextFontView(text:"Followers", fontSize:14)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }
                .frame(width:75)
                .fixedSize(horizontal: true, vertical: false)
                
            }.padding(.top, 20)
            
            Button(action: {
                print("Button tapped!")
            }) {
                TextFontView(text: "Follow", fontSize:16)
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity)
                    .fontWeight(.bold)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    
//                    .border(Color.black, width: 2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 7)
                        .stroke(Color.black, lineWidth: 2)
                    )
            }.padding()
                
                
        }
//        .frame(height: 300)
        .offset(y: 0)
    }
}

struct ProfileInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileInfoView()
    }
}
