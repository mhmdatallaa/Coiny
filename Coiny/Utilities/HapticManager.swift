//
//  HapticManager.swift
//  Coiny
//
//  Created by Mohamed Atallah on 04/08/2025.
//

import Foundation
import SwiftUI

final class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
