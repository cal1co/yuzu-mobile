//
//  TabBarView.swift
//  yuzu
//
//  Created by Alex King on R 5/08/02.
//

import SwiftUI

extension Binding {
    func onUpdate(_ closure: @escaping () -> Void) -> Binding<Value> {
        Binding(get: {
            wrappedValue
        }, set: { newValue in
            wrappedValue = newValue
            closure()
        })
    }
}
enum PostStatus {
    case submitting(progress: Double)
    case success
    case failed
}


struct TabBarView: View {
    @State private var selectedTab = 0
    
    @Environment (\.colorScheme) var colorScheme
    
    @State private var isPostCreateSheetVisible = false
    @State private var previousSelectedTab: Int = 0
    @State private var latestSelectedTab: Int = 0
    @State private var highlightedTab: Int?
    @State private var isSidebarVisible: Bool = false
    @State private var xOffset: CGFloat = 0.0
    @ObservedObject var model = TabModel()
    @State private var isPostDetailViewPresented: Bool = false
    @State private var sideBarSize:CGFloat = 275
    @State private var isSubmittingPost: Bool = false
    @State private var postStatus: PostStatus? = nil


    
    var overlayOpacity: Double {
        Double(xOffset / self.sideBarSize) * 0.5
    }
    func sidebarGesture() -> some Gesture {
        DragGesture()
            .onChanged { value in
                if abs(value.translation.width) > abs(value.translation.height) {
                    if value.translation.width > 0 {
                        self.xOffset = min(self.sideBarSize, value.translation.width)
                    } else if self.isSidebarVisible {
                        self.xOffset = min(self.sideBarSize, max(0, self.sideBarSize + value.translation.width))
                    }
                }
            }
            .onEnded { value in
                if abs(value.translation.width) > abs(value.translation.height) {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        if self.xOffset < 200 && isSidebarVisible {
                            self.isSidebarVisible = false
                            self.xOffset = 0
                        } else if self.xOffset > 50{
                            self.isSidebarVisible = true
                            self.xOffset = self.sideBarSize
                        } else {
                            self.isSidebarVisible = false
                            self.xOffset = 0
                        }
                    }
                }
            }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                SidebarMenuView()
                    .frame(width: self.sideBarSize)
                
                
                TabView(selection: $selectedTab.onUpdate{ model.selectTab(item: selectedTab, lastSelectedTab: latestSelectedTab) }) {
                    HomeView(isPostDetailViewPresented: $isPostDetailViewPresented, model: model)
                    
                    
                        .tabItem {
                            Image(
                                selectedTab == 0 || highlightedTab == 0 ?
                                (colorScheme == .dark ? "House-Solid-Dark" : "House-Solid")
                                :
                                    (colorScheme == .dark ? "House-Unselected-Dark" : "House-Unselected")
                            )
                            .padding(.top, 100)
                            
                        }
                        .tag(0)
                    
                    SearchView()
                        .tabItem {
                            Image(
                                selectedTab == 1 ?
                                (colorScheme == .dark ? "Search-Selected-Dark" : "Search-Selected-Light")
                                :
                                    (colorScheme == .dark ? "Search-Unselected-Dark" : "Search-Unselected-Light")
                            )
                        }
                    
                        .tag(1)
                    
                    TempBlankView(isPostCreateSheetVisible: $isPostCreateSheetVisible,
                                  selectedTab: $selectedTab,
                                  previousSelectedTab: $previousSelectedTab)
                    .tabItem {
                        Image(
                            selectedTab == 2 ?
                            (colorScheme == .dark ? "Post-Create-Selected-Dark" : "Post-Create-Selected-Light")
                            :
                                (colorScheme == .dark ? "Post-Create-Unselected-Dark" : "Post-Create-Unselected-Light")
                        )
                    }
                    .tag(2)
                    
                    NotificationsView()
                        .tabItem {
                            Image(
                                selectedTab == 3 ?
                                (colorScheme == .dark ? "Notifications-Selected-Dark" : "Notifications-Selected-Light")
                                :
                                    (colorScheme == .dark ? "Notifications-Unselected-Dark" : "Notifications-Unselected-Light")
                            )
                        }
                        .tag(3)
                    
                    ProfileView()
                        .tabItem {
                            Image(
                                selectedTab == 4 ?
                                (colorScheme == .dark ? "Profile-Selected-Dark" : "Profile-Selected-Light")
                                :
                                    (colorScheme == .dark ? "Profile-Unselected-Dark" : "Profile-Unselected-Light")
                            )
                            
                        }
                        .tag(4)
                }
                .overlay(
                    Group {
                        if isSubmittingPost, let status = postStatus {
                            PostStatusOverlayView(postStatus: status)
                        }
                    }
                )
                .overlay(
                    Rectangle()
                        .fill(Color.black.opacity(overlayOpacity))
                        .ignoresSafeArea()
                )
                .overlay(
                    Group {
                        if xOffset > 0 {
                            Rectangle()
                                .fill(Color.black.opacity(overlayOpacity))
                                .ignoresSafeArea()
                                .onTapGesture {
                                    withAnimation {
                                        isSidebarVisible = false
                                        self.xOffset = 0

                                    }
                                }
                        }
                    }
                )
                .onChange(of: selectedTab) { newTab in
                    previousSelectedTab = latestSelectedTab
                    latestSelectedTab = newTab
                }
//                .sheet(isPresented: $isPostCreateSheetVisible) {
//                    PostCreateView()
//                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .offset(x: xOffset)
                .gesture(selectedTab == 0 && !self.isPostDetailViewPresented ? sidebarGesture() : nil)
            }
            
        }
    }
}


class TabModel: ObservableObject {
    var scrollViewCoordinator: CustomScrollViewRepresentable<HomeFeedView>.Coordinator?

    func selectTab(item: Int, lastSelectedTab: Int) {
        print("Double tap \(item == lastSelectedTab)")
//        if item == lastSelectedTab {
//            scrollToTopSubject.send(())
//        }
    }
}

struct PostStatusOverlayView: View {
    var postStatus: PostStatus

    var body: some View {
        VStack {
            Spacer()
            HStack {
                switch postStatus {
                case .submitting:
                    Text("Submitting post...")
                case .success:
                    Text("Successfully submitted!")
                case .failed:
                    Text("Submission failed!")
                }
                Spacer()
                CustomProgressView(postStatus: postStatus)
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(15)
        }
    }
}



struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}


struct TempBlankView: View {
    @Binding var isPostCreateSheetVisible: Bool
    @Binding var selectedTab: Int
    @Binding var previousSelectedTab: Int
    var body: some View {
        VStack {
            
        }
        .onAppear{
            selectedTab = previousSelectedTab
            isPostCreateSheetVisible = true
        }
        
    }
}
struct CustomProgressView: View {
    var postStatus: PostStatus
    var body: some View {
        switch postStatus {
        case .submitting(let progress):
            Circle()
                .trim(from: 0.0, to: CGFloat(progress))
                .stroke(Color.blue, lineWidth: 4)
                .rotationEffect(Angle(degrees: -90))
                .frame(width: 30, height: 30)
        case .success:
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
                .font(.system(size: 30))
        case .failed:
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(.red)
                .font(.system(size: 30))
        }
    }
}



