//
//  String.swift
//  Coiny
//
//  Created by Mohamed Atallah on 21/08/2025.
//

import Foundation


extension String {
    
    // Remove URL from string
    var removingHTMLOccurances: String {
        self.replacingOccurrences(of: "<[^>]+>", with: "")
    }
}
