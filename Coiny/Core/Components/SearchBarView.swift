//
//  SearchbarView.swift
//  Coiny
//
//  Created by Mohamed Atallah on 03/08/2025.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    searchText.isEmpty ?
                    Color.theme.secondaryText : Color.theme.accent
                )
            TextField("Search by name or symbol...", text: $searchText)
                .foregroundStyle(Color.theme.accent)
                .autocorrectionDisabled(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundStyle(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            // dismiss the keyboard
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.15), radius: 19, x: 0, y: 0)
        )
        .padding()
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    SearchBarView(searchText: .constant(""))
}
