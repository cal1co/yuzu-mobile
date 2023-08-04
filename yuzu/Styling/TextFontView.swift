//
//  TextFontView.swift
//  yuzu
//
//  Created by Alex King on R 5/08/05.
//

import SwiftUI

struct TextFontView: View {
    var text: String
    var fontSize: CGFloat

    var body: some View {
        Text(text)
            .font(.custom("Hiragino Kaku Gothic ProN", size: fontSize))
            .baselineOffset(2)
    }
}

struct TextFontView_Previews: PreviewProvider {
    static var previews: some View {
        TextFontView(text: "testing", fontSize:20)
    }
}
