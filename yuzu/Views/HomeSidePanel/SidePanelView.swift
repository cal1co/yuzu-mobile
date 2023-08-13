//
//  SidePanelView.swift
//  yuzu
//
//  Created by Alex King on R 5/08/13.
//

import SwiftUI

struct SidePanelView: View {
    @Binding var isPanelVisible: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Place your side panel items here
            Toggle(isOn: .constant(true), label: {
                Text("Dark Mode")
            })
            Text("Settings")
            Text("Bookmarks")
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .edgesIgnoringSafeArea(.all)
    }
}


struct SidePanelView_Previews: PreviewProvider {
    
    static var previews: some View {
        @State var isPanelVisible: Bool = true
        SidePanelView(isPanelVisible: $isPanelVisible)
    }
}
