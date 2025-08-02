//
//  CoinyApp.swift
//  Coiny
//
//  Created by Mohamed Atallah on 31/07/2025.
//

import SwiftUI

@main
struct CoinyApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
            }
            .environmentObject(vm)
        }
    }
}
