//
//  CircleButtonView.swift
//  Coiny
//
//  Created by Mohamed Atallah on 31/07/2025.
//

import SwiftUI

struct CircleButtonView: View {
    
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .frame(width: 50, height: 50)
            .foregroundStyle(Color.theme.accent)
            .background(
                Circle()
                    .foregroundStyle(Color.theme.background)
            )
            .shadow(color: Color.theme.accent.opacity(0.25), radius: 10, x: 0, y: 0)
            .padding()
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Group {
        CircleButtonView(iconName: "info")
        
        CircleButtonView(iconName: "plus")
            .colorScheme(.dark)
    }
}
