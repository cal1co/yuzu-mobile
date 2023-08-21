//
//  PostCreateView.swift
//  yuzu
//
//  Created by Alex King on R 5/08/02.
//

import SwiftUI

struct TopBarView: View {
    
    @Binding var isSubmittingPost: Bool
    @Environment(\.presentationMode) var presentationMode
    @Binding var postText: String
    @Binding var postStatus: PostStatus?
    
    var isPostButtonDisabled: Bool {
        postText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Cancel")
            }
            .padding(.leading)
            .foregroundColor(.primary)

            Spacer()
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
                self.postStatus = .submitting(progress: 0.0)
                self.isSubmittingPost = true
                Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
                    DispatchQueue.main.async {
                        if case .submitting(let progress) = self.postStatus, progress < 1.0 {
//                            print(progress)
                            self.postStatus = .submitting(progress: progress + 0.2)
                        } else {
                            timer.invalidate()
                            
                            if self.postText.contains("error") {
                                self.postStatus = .failed
                            } else {
                                self.postStatus = .success
                            }
                        }
                    }
                    
                }

            }) {
                Text("Post")
            }
            .padding(.trailing)
            .foregroundColor(isPostButtonDisabled ? .gray : .primary)
            .disabled(isPostButtonDisabled)
        }
        .overlay(
            Text("New Post")
                .font(.headline)
        )
    }
}

struct PostInputView: View {
    
    
    @Binding var isImagePickerShown: Bool
//    @Binding var isPostCreateSheetVisible: Bool
    @Binding var postText: String
    
    var body: some View {
        HStack(alignment:.top) {
            Circle()
                .fill(Color.gray)
                .frame(width: 40, height: 40)
            VStack(alignment: .leading) {
                TextField("What's on your mind?", text: $postText, axis: .vertical)
                    .lineLimit(nil)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .keyboardType(.default)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .textContentType(.none)
                        .submitLabel(.return)
                        .onSubmit {
                            
                            print("Post button pressed!")
//                            isPostCreateSheetVisible.toggle()
                        }
                    
                    Button(action: {
                        isImagePickerShown.toggle()
                    }) {
                        Image(systemName: "paperclip")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                    .padding(.top, 5)
                }
                
                Spacer()

        }
        .padding(.vertical)
        .padding(.horizontal)
    }
}

struct PostCreateView: View {
    

    @Environment(\.presentationMode) var presentationMode
    
    @State private var postText: String = ""
    @State private var image: Image? = nil
    @State private var isImagePickerShown: Bool = false
//    @Binding var isPostCreateSheetVisible: Bool
    @Binding var isSubmittingPost: Bool
    @Binding var postStatus: PostStatus?
    
    

    var body: some View {
        VStack {
            TopBarView(isSubmittingPost: $isSubmittingPost, postText: $postText, postStatus: $postStatus)
            PostInputView(isImagePickerShown: $isImagePickerShown, postText: $postText)

            Spacer()

            image?
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 300)
                .padding()

        }
        .padding(.top, 20)
//        .sheet(isPresented: $isImagePickerShown, onDismiss: loadImage) {
////            ImagePicker(image: $image)
//        }
    }

    func loadImage() {
        
    }
}

struct ViewHeightKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}


//struct PostCreateView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostCreateView()
//    }
//}
