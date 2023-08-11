//
//  SearchView.swift
//  yuzu
//
//  Created by Alex King on R 5/08/02.
//

import SwiftUI

enum Tab: Int, CaseIterable {
    case posts
    case users

    var title: String {
        switch self {
        case .posts:
            return "posts"
        case .users:
            return "users"
        }
    }
}

struct SearchView: View {
    @State private var searchText = ""
    @State private var isEditing = false
    @State private var isCancelVisible = false
    @State private var selectedTab = Tab.users
    @Namespace private var namespace
    
    let tabs = Tab.allCases

    @FocusState private var isSearchFieldFocused: Bool

    

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if !isEditing {
                Text("Search")
                    .font(.largeTitle)
                    .font(.custom("Hiragino Kaku Gothic ProN", size: 38))
                    
                    .padding(.leading)
                    .transition(.move(edge: .trailing))
            }

            HStack {
                TextField("Search", text: $searchText, onEditingChanged: { editing in
                    withAnimation {
                        self.isEditing = editing
                    }
                })
                .onChange(of: searchText) { newValue in
                    search(query: newValue)
                }
                .focused($isSearchFieldFocused)
                .submitLabel(.search)
                .padding(10)
                .padding(.leading, 30)
                .background(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.leading, 10)
                        Spacer()
                    }
                )
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .frame(maxWidth: isEditing ? .infinity : .infinity, alignment: .leading)
                .transition(.move(edge: .leading))

                if isEditing {
                    Button("Cancel") {
                        withAnimation {
                            self.isEditing = false
                            self.searchText = ""
                            self.isSearchFieldFocused = false
                        }
                    }
                    .foregroundColor(.primary)
                    .onAppear { withAnimation { self.isCancelVisible = true } }
                    .onDisappear { withAnimation { self.isCancelVisible = false } }
                }
                
            }
            .padding(.horizontal)
            
                ZStack(alignment: .bottom) {
                    HStack(spacing:20) {
                        Spacer()
                        
                        ForEach(tabs, id:\.rawValue) {tab in
                            Button {
                                selectedTab = tab
                            } label: {
                                Text(tab.title)
                                    .foregroundColor(tab == selectedTab ? .primary : .gray)
                                    .padding(.vertical, 8)
                                    .matchedGeometryEffect(id: tab, in: namespace, properties: .frame, isSource: true)
                            }
                        }
                        
                        Spacer()
                    }
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .frame(height:3)
                        .matchedGeometryEffect(id: selectedTab, in: namespace, properties: .frame, isSource: false)
                        .animation(.easeOut(duration:0.2), value:selectedTab)
                }

                TabView(selection: $selectedTab) {

                    Text("Search Posts")
                        .tag(Tab.posts)

                    Text("Search Users")
                        .tag(Tab.users)
                }
                
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                        
        }
    }
    func search(query: String) {
        print("Searching for \(query) in \(selectedTab)")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
