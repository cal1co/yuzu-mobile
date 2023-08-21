//
//  yuzuApp.swift
//  yuzu
//
//  Created by Alex King on R 5/08/01.
//

import SwiftUI

@main
struct yuzuApp: App {
    @StateObject var authService = AuthenticationService()
    @State private var isPostCreateSheetVisible = false
    @State private var isSubmittingPost = false
    @State private var postStatus: PostStatus? = nil

        var body: some Scene {
            WindowGroup {
//                if authService.isAuthenticated {
                    TabBarView(isPostCreateSheetVisible: $isPostCreateSheetVisible, isSubmittingPost: $isSubmittingPost, postStatus: $postStatus).environmentObject(authService)
                    .sheet(isPresented: $isPostCreateSheetVisible) {
                                PostCreateView(isSubmittingPost: $isSubmittingPost, postStatus: $postStatus)
                            }
                    .overlay(
                        Group {
                            if isSubmittingPost {
                                PostStatusOverlayView(postStatus: $postStatus, isSubmittingPost: $isSubmittingPost)
                            }
                        }
                    )
                
//                } else {
//                    LandingView().environmentObject(authService)
//                }
            }
        }
}

struct PostStatusOverlayView: View {
    @Binding var postStatus: PostStatus?
    @Binding var isSubmittingPost: Bool
    @Environment (\.colorScheme) var colorScheme
    
    var body: some View {
        
        VStack {
            
            Spacer()
            HStack {
                contentView
            }
            .padding(12)
            .lineSpacing(1.15)
            .kerning(0.05)
            .fontWeight(.bold)
            .background(colorScheme == .dark ? Color.black : Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(colorScheme == .dark ? Color(red: 190/255, green: 186/255, blue: 186/255) : Color.black, lineWidth: 2)
            )
            .zIndex(3)
        }
//        .onDisappear {
//            print("PostStatusOverlayView disappeared.") // Debug
//        }
    }
    
    @ViewBuilder
    var contentView: some View {
        switch postStatus {
        case .submitting(let progress):
            Text("Submitting post...")
            CustomProgressView(progress: progress, postStatus: postStatus)
        case .success:
            Text("Successfully submitted!")
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
                .font(.system(size: 30))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.postStatus = nil
                        self.isSubmittingPost = false
                    }
                }
        case .failed:
            Text("Submission failed!")
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(.red)
                .font(.system(size: 30))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.postStatus = nil
                        self.isSubmittingPost = false
                    }
                }
        case .none:
            EmptyView()
            
        }
    }
}

struct CustomProgressView: View {
    var progress: Double
    var postStatus: PostStatus?

    var body: some View {
        switch postStatus {
        case .some(.submitting(let progress)):
            Circle()
                .trim(from: 0.0, to: CGFloat(progress))
                .stroke(Color.blue, lineWidth: 4)
                .rotationEffect(Angle(degrees: -90))
                .frame(width: 30, height: 30)
                .animation(.easeInOut(duration: 0.2))
        case .some(.success):
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
                .font(.system(size: 30))
        case .some(.failed):
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(.red)
                .font(.system(size: 30))
        case .none:
            EmptyView()
        }
        }
    }





struct yuzuAppPreview: View {
    @StateObject var authService = AuthenticationService()
    @State private var isPostCreateSheetVisible = false
    @State private var isSubmittingPost = false
    @State private var postStatus: PostStatus? = nil

        var body: some View {
            TabBarView(isPostCreateSheetVisible: $isPostCreateSheetVisible, isSubmittingPost: $isSubmittingPost, postStatus: $postStatus).environmentObject(authService)
            .sheet(isPresented: $isPostCreateSheetVisible) {
                        PostCreateView(isSubmittingPost: $isSubmittingPost, postStatus: $postStatus)
            }
            .overlay(
                Group {
                    if isSubmittingPost {
                        PostStatusOverlayView(postStatus: $postStatus, isSubmittingPost: $isSubmittingPost)
                            .offset(y: -70)
                    }
                }
            )
        }
}
struct yuzuAppView_Previews: PreviewProvider {
    static var previews: some View {
        yuzuAppPreview()
    }
}
