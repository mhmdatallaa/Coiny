//
//  XMarkButton.swift
//  Coiny
//
//  Created by Mohamed Atallah on 04/08/2025.
//

import SwiftUI

struct XMarkButton: View {
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button {
            Logger.shared.log("X MARK PRESSED")
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    XMarkButton()
        .padding()
}
