//
//  PostCreateView.swift
//  yuzu
//
//  Created by Alex King on R 5/08/02.
//

import SwiftUI
import Combine

struct PostCreateView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var postText: String = ""
    @State private var image: Image? = nil
    @State private var isImagePickerShown: Bool = false
    @Binding var isPostCreateSheetVisible: Bool
    var isPostButtonDisabled: Bool {
        postText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        VStack {
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
            
            HStack(alignment:.top) {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 40, height: 40)
//                    .padding(.horizontal, 10)
                VStack(alignment: .leading) {  // Wrap TextField and paperclip inside VStack
                    TextField("Enter text...", text: $postText, axis: .vertical)
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
                                isPostCreateSheetVisible.toggle()
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
            


            Spacer()

            image?
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 300)
                .padding()

        }
        .padding(.top, 20)
        .sheet(isPresented: $isImagePickerShown, onDismiss: loadImage) {
//            ImagePicker(image: $image)
        }
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
