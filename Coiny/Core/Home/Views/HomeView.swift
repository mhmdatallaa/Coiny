//
//  HomeView.swift
//  Coiny
//
//  Created by Mohamed Atallah on 31/07/2025.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showProtfolio = false
    var body: some View {
        ZStack {
            // background layer
            Color.theme.background
                .ignoresSafeArea()
            
            // content layer
            VStack {
                homeHeader
                Spacer(minLength: 0)
            }
        }
    }
}

#Preview {
    NavigationView {
        HomeView()
    }
}

extension HomeView {
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showProtfolio ? "plus" : "info")
                .background(
                    CircleButtonAnimationView(animate: $showProtfolio)
                    )
            Spacer()
            Text(showProtfolio ? "Protfolio" : "Live prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showProtfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showProtfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
}
