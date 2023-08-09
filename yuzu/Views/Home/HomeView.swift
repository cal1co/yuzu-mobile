//
//  HomeView.swift
//  yuzu
//
//  Created by Alex King on R 5/08/02.
//

import SwiftUI


struct HomeView: View {
    
    @StateObject var headerData = HomeHeaderViewModel()
    @State private var isScrolling: Bool = false
    @State private var isRefreshing = false
    
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    
    
    var body: some View {
        VStack {
            HomeHeaderView()
                .zIndex(1)
                .offset(y: headerData.headerOffset)
            ZStack {
                CustomScrollViewRepresentable(isScrolling: $isScrolling) {
                    HomeFeedView(isRefreshing: $isRefreshing)
                        .overlay(
                            GeometryReader{proxy -> Color in
                                let minY = proxy.frame(in: .global).minY
                                
                                DispatchQueue.main.async {
                                    if headerData.startMinY == 0 {
                                        headerData.startMinY = minY
                                    }
                                    
                                    let offset = headerData.startMinY - minY

                                    if offset > headerData.offset {

                                        headerData.bottomScrollOffset = 0
                                        
                                        if headerData.topScrollOffset == 0 {
                                            headerData.topScrollOffset = offset
                                        }
                                        
                                        let progress = (headerData.topScrollOffset + getMaxOffset()) - offset
                                        
                                        let offsetCondition = (headerData.topScrollOffset + getMaxOffset()) >= getMaxOffset() && getMaxOffset() - progress <= getMaxOffset()
                                        
                                        let headerOffset = offsetCondition ? -(getMaxOffset() - progress) : -getMaxOffset()

                                        headerData.headerOffset = headerOffset
                                        
                                    }
                                    if offset < headerData.offset {
                                        
                                        headerData.topScrollOffset = 0
                                        if headerData.bottomScrollOffset == 0 {
                                            headerData.bottomScrollOffset = offset
                                        }
                                        
                                        withAnimation(.easeOut(duration: 0.25)) {
                                            let headerOffset = headerData.headerOffset
                                            if headerData.bottomScrollOffset > offset {
                                                headerData.headerOffset = 0
                                            } else {
                                                headerData.headerOffset = headerOffset
                                            }
                                            
                                            
    //                                        headerData.headerOffset = headerData.bottomScrollOffset > offset + 40 ? 0 : (headerOffset != -getMaxOffset() ? 0 : headerOffset)
                                            
                                        }
                                    }
                                    
                                    headerData.offset = offset
                                }
                                
                                
                                return Color.clear
                            }
                                .frame(height: 1)
                                ,alignment:.top
                        )
                        
                }
                .onChange(of: isScrolling) { newValue in
                    if !newValue && headerData.headerOffset < 0 {
                        withAnimation(.easeOut(duration: 0.25)) {
                            headerData.headerOffset = -177
                        }
                    }
                }
            }
            
            
        }
    }
    
    func getMaxOffset() -> CGFloat {
        return headerData.startMinY + (edges?.top ?? 0) + 10
    }
    
}


struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

var edges = UIApplication.shared.windows.first?.safeAreaInsets


struct CustomScrollViewRepresentable<Content: View>: UIViewRepresentable {
    @Binding var isScrolling: Bool
    let content: Content

    init(isScrolling: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._isScrolling = isScrolling
        self.content = content()
    }

    func makeCoordinator() -> CustomScrollViewDelegate {
        CustomScrollViewDelegate()
    }

    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        context.coordinator.onScrollStart = {
            self.isScrolling = true
        }
        context.coordinator.onScrollEnd = {
            self.isScrolling = false
        }
        let hostingController = UIHostingController(rootView: content)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(hostingController.view)
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            hostingController.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        return scrollView
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {
        context.coordinator.onScrollStart = {
            self.isScrolling = true
            
        }
        context.coordinator.onScrollEnd = {
            self.isScrolling = false
        
        }
    }
}

class CustomScrollViewDelegate: NSObject, UIScrollViewDelegate {
    var onScrollStart: (() -> Void)?
    var onScrollEnd: (() -> Void)?

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        onScrollStart?()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            onScrollEnd?()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        onScrollEnd?()
    }
}
