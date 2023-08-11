//
//  ProfileInfoView.swift
//  yuzu
//
//  Created by Alex King on R 5/08/04.
//

import SwiftUI

struct ProfileInfoView: View {
    @Environment (\.colorScheme) var colorScheme
    @State var displayName = "display name"
    @State var username = "name"
    @State var bio = "Hello, welcome to my page, my name is [name]"
    @State var followingCount = 5
    @State var followerCount = 3
    @State var postCount = 2
    
    var body: some View {
        
            ZStack {
                VStack{
                    Image("placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 75, height: 75)
                        .background(Color.gray)
                        .clipShape(Circle())
                        
                        
                    
                    TextFontView(text: "\(displayName)",  fontSize: 16)
                        .fontWeight(.bold)
                        .padding(.top, 3)
                    
                    TextFontView(text: "@\(username)", fontSize:12)
                        .padding(.top, 1)
                        .fontWeight(.bold)

                    TextFontView(text: "\(bio)", fontSize:10)
                        .fontWeight(.bold)
                        .padding(.top, 7)

                    HStack {
                        VStack {
                            TextFontView(text:"\(postCount)", fontSize:10)
                                .fontWeight(.bold)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                            TextFontView(text:"Posts", fontSize:10)
                                .fontWeight(.bold)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                        }
                        .frame(width:75)
                        VStack {
                            TextFontView(text:"\(followingCount)", fontSize:10)
                                .fontWeight(.bold)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                            TextFontView(text:"Following", fontSize:10)
                                .fontWeight(.bold)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                                .lineSpacing(10)
                        }
                        .frame(width:75, height:40)
                        .fixedSize(horizontal: true, vertical: false)
                        VStack {
                            TextFontView(text:"\(followerCount)", fontSize:10)
                                .fontWeight(.bold)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                            TextFontView(text:"Followers", fontSize:10)
                                .fontWeight(.bold)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                        }
                        .frame(width:75)
                        .fixedSize(horizontal: true, vertical: false)
                        
                    }.padding(.top, 7)
                    
                    Button(action: {
                        print("Button tapped!")
                    }) {
                        TextFontView(text: "Follow", fontSize:12)
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                            .frame(maxWidth: .infinity)
                            .fontWeight(.bold)
                            .padding(10)
                            .background(colorScheme == .dark ? Color.black : Color.white)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: 2)
                            )
                    }.padding(EdgeInsets(top:6, leading:40, bottom: 0, trailing: 40))
                    
                        
                        Spacer()
                }
                .offset(y: 0)
                .frame(height:285)
                
                .frame(alignment: .top)
                
                
            }
//            .border(Color.black)
            
        
    }
        
}

struct ProfileInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileInfoView()
    }
}
