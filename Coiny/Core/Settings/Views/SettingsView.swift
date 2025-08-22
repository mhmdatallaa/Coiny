//
//  SettingsView.swift
//  Coiny
//
//  Created by Mohamed Atallah on 21/08/2025.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    @Environment(\.openURL) private var openURL
    @Environment(\.requestReview) private var requestReview
    
    var body: some View {
        NavigationView {
            List {
                // MARK: - App Info
                Section(header: Text("App Information")) {
                    HStack {
                        Image("logo")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        VStack(alignment: .leading) {
                            Text("Coiny")
                                .font(.headline)
//                            Text(Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "MyApp")
//                                .foregroundColor(.secondary)
                        }
                    }
                    
                    HStack {
                        Image(systemName: "number")
                            .foregroundColor(.green)
                        VStack(alignment: .leading) {
                            Text("Version")
                                .font(.headline)
                            Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0")
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Button {
                        requestReview()
                    } label: {
                        Label("Rate This App", systemImage: "star.fill")
                    }
                }
                
                // MARK: - Developer Info
                Section(header: Text("Developer")) {
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .foregroundColor(.purple)
                        VStack(alignment: .leading) {
                            Text("Developer")
                                .font(.headline)
                            Text("Mohamed Atallah")
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Button {
                        openURL(URL(string: "https://github.com/mhmdatallaa")!)
                    } label: {
                        Label("GitHub", systemImage: "link")
                    }
                    
                    Button {
                        openURL(URL(string: "mailto:mohamed_attallah@icloud.com")!)
                    } label: {
                        Label("Contact Developer", systemImage: "envelope.fill")
                    }
                }
                
                // MARK: - Credits
                Section(footer: Text("Made with ❤️ using SwiftUI")) {
                    EmptyView()
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
















//import SwiftUI
//
//struct SettingsView: View {
//    
//    let defaultURL = URL(string: "https://www.google.com")!
//        let youtubeURL = URL(string: "https://www.youtube.com/c/swiftfulthinking")!
//        let coffeeURL = URL(string: "https://www.buymeacoffee.com/nicksarno")!
//        let coingeckoURL = URL(string: "https://www.coingecko.com")!
//        let personalURL = URL(string: "https://www.nicksarno.com")!
//        
//        var body: some View {
//            NavigationView {
//                ZStack {
//                    // background
//                    Color.theme.background
//                        .ignoresSafeArea()
//                    
//                    // content
//                    List {
//                        swiftfulThinkingSection
//                            .listRowBackground(Color.theme.background.opacity(0.5))
//                        coinGeckoSection
//                            .listRowBackground(Color.theme.background.opacity(0.5))
//                        developerSection
//                            .listRowBackground(Color.theme.background.opacity(0.5))
//                        applicationSection
//                            .listRowBackground(Color.theme.background.opacity(0.5))
//                    }
//                }
//                .font(.headline)
//                .accentColor(.blue)
//                .listStyle(GroupedListStyle())
//                .navigationTitle("Settings")
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        XMarkButton()
//                    }
//                }
//            }
//        }
//}
//
//#Preview {
//    SettingsView()
//}
//
//extension SettingsView {
//    
//    private var swiftfulThinkingSection: some View {
//        Section(header: Text("Swiftful Thinking")) {
//            VStack(alignment: .leading) {
//                Image("logo")
//                    .resizable()
//                    .frame(width: 100, height: 100)
//                    .clipShape(RoundedRectangle(cornerRadius: 20))
//                Text("This app was made by following a @SwiftfulThinking course on YouTube. It uses MVVM Architecture, Combine, and CoreData!")
//                    .font(.callout)
//                    .fontWeight(.medium)
//                    .foregroundColor(Color.theme.accent)
//            }
//            .padding(.vertical)
//            Link("Subscribe on YouTube 🥳", destination: youtubeURL)
//            Link("Support his coffee addiction ☕️", destination: coffeeURL)
//        }
//    }
//    
//    private var coinGeckoSection: some View {
//        Section(header: Text("CoinGecko")) {
//            VStack(alignment: .leading) {
//                Image("coingecko")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height: 100)
//                    .clipShape(RoundedRectangle(cornerRadius: 20))
//                Text("The cryptocurrency data that is used in this app comes from a free API from CoinGecko! Prices may be slightly delayed.")
//                    .font(.callout)
//                    .fontWeight(.medium)
//                    .foregroundColor(Color.theme.accent)
//            }
//            .padding(.vertical)
//            Link("Visit CoinGecko 🦎", destination: coingeckoURL)
//        }
//    }
//    
//    private var developerSection: some View {
//        Section(header: Text("Developer")) {
//            VStack(alignment: .leading) {
//                Image("logo")
//                    .resizable()
//                    .frame(width: 100, height: 100)
//                    .clipShape(RoundedRectangle(cornerRadius: 20))
//                Text("This app was developed by Nick Sarno. It uses SwiftUI and is written 100% in Swift. The project benefits from multi-threading, publishers/subscribers, and data persistance.")
//                    .font(.callout)
//                    .fontWeight(.medium)
//                    .foregroundColor(Color.theme.accent)
//            }
//            .padding(.vertical)
//            Link("Visit Website 🤙", destination: personalURL)
//        }
//    }
//    
//    private var applicationSection: some View {
//        Section(header: Text("Application")) {
//            Link("Terms of Service", destination: defaultURL)
//            Link("Privacy Policy", destination: defaultURL)
//            Link("Company Website", destination: defaultURL)
//            Link("Learn More", destination: defaultURL)
//        }
//    }
//    
//    
//}

