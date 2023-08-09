//
//  HomeView.swift
//  yuzu
//
//  Created by Alex King on R 5/08/02.
//

import SwiftUI

enum ScrollDirection {
    case up
    case down
}


struct HomeView: View {
    
    
    @State private var isScrolling: Bool = false
    @State private var isRefreshing = false
    @State private var isHeaderHidden = false
    @State private var isWaitingToScrollAgain = false

    init() {
        UIScrollView.appearance().bounces = true
    }
    
    var body: some View {
        VStack {
            if !isHeaderHidden {
                withAnimation(.easeInOut(duration: 0.25)) {
                    HomeHeaderView()
                        .zIndex(1)
                }
            }
            CustomScrollViewRepresentable(
                isScrolling: $isScrolling,
                isRefreshing: $isRefreshing,
                onRefresh: performRefresh,
                onScrollDirectionChanged: { direction in
                    withAnimation(.easeInOut(duration: 0.25)) {
                        print(direction)
                        if isWaitingToScrollAgain {
                            isHeaderHidden = false
                            return
                        }
                        if isRefreshing {
                            print("refreshing rn")
                        }
                        if !isRefreshing {
                            isHeaderHidden = (direction == .down)
                        }
                        
                    }
                },
                content: {
                    HomeFeedView()
                }
            )
            .onChange(of: isScrolling) { newValue in
                if newValue {
                    isWaitingToScrollAgain = false
                }
                print("nevalue", newValue)
            }
        
        }
        
    }
    
    private func performRefresh() {
        UIScrollView.appearance().bounces = false
//        isRefreshing = true
        print("refreshing")
        isWaitingToScrollAgain = true
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {

            DispatchQueue.main.async {
                isRefreshing = false
                print("refreshed")
            }
        }
    }
    
}


struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

struct CustomScrollViewRepresentable<Content: View>: UIViewRepresentable {
    @Binding var isScrolling: Bool
    @Binding var isRefreshing: Bool

    let content: Content
    let onRefresh: () -> Void
    let onScrollDirectionChanged: (ScrollDirection) -> Void

    init(isScrolling: Binding<Bool>, isRefreshing: Binding<Bool>, onRefresh: @escaping () -> Void, onScrollDirectionChanged: @escaping (ScrollDirection) -> Void, @ViewBuilder content: () -> Content) {
        self._isScrolling = isScrolling
        self._isRefreshing = isRefreshing
        self.onScrollDirectionChanged = onScrollDirectionChanged
        self.onRefresh = onRefresh
        self.content = content()
    }


    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(context.coordinator, action: #selector(Coordinator.handleRefreshControl), for: .valueChanged)
        scrollView.refreshControl = refreshControl

        let containerView = UIView()
        scrollView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false

        let hostingController = UIHostingController(rootView: content)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(hostingController.view)

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            hostingController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])

        context.coordinator.onScrollStart = {
//            print(isScrolling)
            self.isScrolling = true
        }
        context.coordinator.onScrollEnd = {
//            print(isScrolling)
            self.isScrolling = false
        }

        return scrollView
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {
        if !isRefreshing {
            uiView.refreshControl?.endRefreshing()
        }
    }

    class Coordinator: NSObject, UIScrollViewDelegate {
        var lastContentOffset: CGFloat = 0
        var parent: CustomScrollViewRepresentable
        var didRefresh: Bool = false


        init(_ parent: CustomScrollViewRepresentable) {
            self.parent = parent
        }

        @objc func handleRefreshControl() {
            parent.isRefreshing = true
            parent.onRefresh()
            didRefresh = true
        }

        var onScrollStart: (() -> Void)?
        var onScrollEnd: (() -> Void)?

        func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            onScrollStart?()
        }
        
        func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        }
        
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            if !decelerate {
                onScrollEnd?()
            }
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            if didRefresh {
                didRefresh = false
                lastContentOffset = scrollView.contentOffset.y
                return
            }

            let direction: ScrollDirection = scrollView.contentOffset.y > lastContentOffset ? .down : .up
            lastContentOffset = scrollView.contentOffset.y
            parent.onScrollDirectionChanged(direction)
        }

        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            onScrollEnd?()
        }
        
    }
}

