//
//  Logger.swift
//  Coiny
//
//  Created by Mohamed Atallah on 02/08/2025.
//

import Foundation

final class Logger {
    static let shared = Logger()
    private let logfileName = "app_log.txt"
    
    private init() {}
    
    enum LogLevel: String {
        case info = "ℹ️ INFO"
        case warning = "⚠️ WARNING"
        case error = "❌ ERROR"
        case debug = "🐞 DEBUG"
    }
    
    func log(_ message: String, level: LogLevel = .info, toFile: Bool = false) {
        let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .medium)
        let logMessage = "[\(timestamp)] [\(level.rawValue)] \(message)"
        
        #if DEBUG
        print(logMessage)
        #endif
        
        if toFile {
            writeToFile(logMessage)
        }
    }
    
    private func writeToFile(_ message: String) {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentDirectory.appendingPathComponent(logfileName)
        
        if !fileManager.fileExists(atPath: fileURL.path) {
            try? "".write(to: fileURL, atomically: true, encoding: .utf8)
        }
        
        if let fileHandle = try? FileHandle(forWritingTo: fileURL) {
            fileHandle.seekToEndOfFile()
            if let data = (message + "\n").data(using: .utf8) {
                fileHandle.write(data)
            }
            fileHandle.closeFile()
        }
    }
}
