//
//  SideBarMenuView.swift
//  yuzu
//
//  Created by Alex King on R 5/08/16.
//

import SwiftUI

struct SideBarMenuView: View {
    var body: some View {
        List {
            Text("Item 1")
            Text("Item 2")
            Text("Item 3")
        }
    }
}

struct SideBarMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideBarMenuView()
    }
}
