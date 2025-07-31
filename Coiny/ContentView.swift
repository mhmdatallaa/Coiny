//
//  ContentView.swift
//  Coiny
//
//  Created by Mohamed Atallah on 31/07/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack {
                Text("Some Text")
                    .foregroundStyle(Color.theme.accent)
            }
            .font(.headline)
        }
    }
}

#Preview {
    ContentView()
}
