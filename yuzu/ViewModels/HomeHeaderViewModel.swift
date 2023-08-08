//
//  HomeHeaderViewModel.swift
//  yuzu
//
//  Created by Alex King on R 5/08/08.
//

import SwiftUI

class HomeHeaderViewModel: ObservableObject {
    @Published var startMinY: CGFloat = 0
    @Published var offset: CGFloat = 0
    
    @Published var headerOffset: CGFloat = 0
    
    @Published var topScrollOffset: CGFloat = 0
    @Published var bottomScrollOffset: CGFloat = 0
}

