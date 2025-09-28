#  Coiny - Cryptocurrency Portfolio Tracker

<div align="center">
  <img src="https://img.shields.io/badge/Platform-iOS-blue.svg" alt="Platform">
  <img src="https://img.shields.io/badge/Language-Swift-orange.svg" alt="Language">
  <img src="https://img.shields.io/badge/Framework-SwiftUI-green.svg" alt="Framework">
  <img src="https://img.shields.io/badge/Architecture-MVVM-red.svg" alt="Architecture">
  <img src="https://img.shields.io/badge/API-CoinGecko-yellow.svg" alt="API">
</div>

## 📱 About

**Coiny** is a modern, feature-rich iOS application that allows users to track cryptocurrency prices in real-time and manage their personal crypto portfolio. Built with SwiftUI and following MVVM architecture patterns, this app demonstrates advanced iOS development skills including API integration, data persistence, and sophisticated UI animations.

<img src="https://github.com/user-attachments/assets/64d03d17-46d8-444e-9348-e731e60aa380" width="250"/>


<img src="https://github.com/user-attachments/assets/584a7d8c-bc30-4b11-8f6d-3f7e44905f0f" width="250"/>


<img src="https://github.com/user-attachments/assets/9597ac5f-dac3-4a20-ae9c-e29069bb4146" width="250"/>

## ✨ Key Features

### 🚀 Core Functionality
- **Real-time Price Tracking** - Live cryptocurrency data from CoinGecko API
- **Portfolio Management** - Add, edit, and track your crypto investments
- **Interactive Charts** - Beautiful price history visualization
- **Market Statistics** - Comprehensive market data and analytics
- **Smart Search** - Instant search across thousands of cryptocurrencies
- **Dark/Light Theme** - Adaptive UI design

### 🎨 User Experience
- **Smooth Animations** - Fluid transitions and micro-interactions
- **Haptic Feedback** - Enhanced tactile responses
- **Pull-to-Refresh** - Intuitive data refreshing
- **Sorting & Filtering** - Multiple ways to organize data
- **Responsive Design** - Optimized for all iPhone sizes

### 💾 Data Management
- **Core Data Integration** - Persistent portfolio storage
- **Image Caching** - Optimized coin logo loading
- **Network Layer** - Robust API communication
- **Error Handling** - Graceful failure management

## 🏗️ Architecture

This project follows **Clean Architecture** principles with **MVVM** pattern:

```
Coiny/
├── App/                    # App entry point
├── Core/                   # Main features
│   ├── Components/         # Reusable UI components
│   ├── Detail/             # Coin detail screens
│   ├── Home/              # Main dashboard
│   ├── LaunchScreen/      # Splash screen
│   └── Settings/          # App settings
├── Services/              # Data layer
│   ├── CoinDataService    # Cryptocurrency API
│   ├── CoinImageService   # Image downloading
│   ├── MarketDataService  # Market statistics
│   └── PortfolioDataService # Core Data operations
├── Models/                # Data models
├── Utilities/             # Helper classes
└── Resources/            # Assets and themes
```

## 🛠️ Technical Stack

### **Frontend**
- **SwiftUI** - Declarative UI framework
- **Combine** - Reactive programming
- **MVVM Pattern** - Separation of concerns
- **Navigation Stack** - Modern iOS navigation

### **Backend & Data**
- **CoinGecko API** - Real-time cryptocurrency data
- **Core Data** - Local data persistence
- **URLSession** - Network operations
- **JSON Decoding** - Codable protocol implementation

### **UI/UX**
- **Custom Animations** - Smooth transitions and effects
- **Color Themes** - Dynamic theming system
- **SF Symbols** - Native iconography
- **Haptic Feedback** - Enhanced user interactions

## 🚀 Getting Started

### Prerequisites
- iOS 15.0+
- Xcode 14.0+
- Swift 5.7+

### Installation
1. Clone the repository
```bash
git clone https://github.com/yourusername/coiny-ios.git
```

2. Open `Coiny.xcodeproj` in Xcode

3. Build and run the project

*Note: No additional setup required - the app uses public APIs without authentication.*

## 🎯 Key Learning Outcomes

This project demonstrates proficiency in:

- ✅ **Modern iOS Development** - SwiftUI, Combine, async/await
- ✅ **Architecture Patterns** - MVVM, Clean Architecture
- ✅ **API Integration** - RESTful services, JSON parsing
- ✅ **Data Persistence** - Core Data, UserDefaults
- ✅ **State Management** - ObservableObject, @StateObject
- ✅ **Performance Optimization** - Image caching, lazy loading
- ✅ **User Interface Design** - Custom components, animations
- ✅ **Error Handling** - Network errors, data validation
- ✅ **Testing** - Unit tests, UI tests

## 🔧 Advanced Features

### Custom Components
- **CircleButtonView** - Reusable animated buttons
- **CoinRowView** - Dynamic cryptocurrency list items
- **SearchBarView** - Real-time search functionality
- **StatisticView** - Market data display components

### Performance Optimizations
- **Lazy Loading** - Efficient list rendering
- **Image Caching** - Reduced network calls
- **Background Processing** - Non-blocking API calls
- **Memory Management** - Proper object lifecycle handling

### Error Handling
- **Network Connectivity** - Offline state management
- **API Rate Limiting** - Graceful degradation
- **Data Validation** - Input sanitization
- **User Feedback** - Clear error messages



## 🔮 Future Enhancements

- [ ] **Widgets** - iOS home screen widgets
- [ ] **Watch App** - Apple Watch companion
- [ ] **Push Notifications** - Price alerts
- [ ] **Advanced Analytics** - Portfolio performance metrics
- [ ] **Export Features** - CSV/PDF reports
- [ ] **Social Features** - Share portfolio insights

<div align="center">
  <sub>Built with ❤️ using SwiftUI</sub>
</div>
