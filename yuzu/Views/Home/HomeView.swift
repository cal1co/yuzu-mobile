//
//  HomeView.swift
//  yuzu
//
//  Created by Alex King on R 5/08/02.
//

import SwiftUI


struct HomeView: View {
    
    @StateObject var headerData = HomeHeaderViewModel()
    
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    
    
    var body: some View {
        VStack {
            HomeHeaderView()
                .zIndex(1)
                .offset(y: headerData.headerOffset)
            ScrollView(.vertical, showsIndicators: false, content: {
                HomeFeedView()
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
//                                        let headerOffset = headerData.headerOffset
                                        if headerData.bottomScrollOffset > offset + 40 {
                                            headerData.headerOffset = 0
                                            
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
            })
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
