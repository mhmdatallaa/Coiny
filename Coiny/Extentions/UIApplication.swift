//
//  UIApplication.swift
//  Coiny
//
//  Created by Mohamed Atallah on 03/08/2025.
//

import Foundation
import SwiftUI

extension UIApplication {
    // dismiss the keyboard
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
