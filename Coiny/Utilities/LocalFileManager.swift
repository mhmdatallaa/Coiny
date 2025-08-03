//
//  LocalFileManager.swift
//  Coiny
//
//  Created by Mohamed Atallah on 03/08/2025.
//

import Foundation
import SwiftUI

final class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    private init() { }
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        // create folder
        createFolderIfNeeded(folderName: folderName)
        
        // get path for image
        guard let data = image.pngData(),
              let url = getURLForImage(imageName: imageName, folderName: folderName)
              else { return }
        
        // save image to path
        do {
            try data.write(to: url)
        } catch(let error) {
            Logger.shared.log("Error saving the image: \(imageName) error: \(error)", level: .error)
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard let url = getURLForImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
    
    // Create folder
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLForFolder(name: folderName) else { return }
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch let error {
                Logger.shared.log("Error creating directory: \(folderName) error: \(error)", level: .error)
            }
        }
    }
    
    // Folder URL
    private func getURLForFolder(name: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else {
            Logger.shared.log("Invalid URL to downloaded photo Folder", level: .error)
            return nil
        }
        return url.appendingPathComponent(name)
    }
    
    // Image URL inside Folder
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(name: folderName) else { return nil }
        return folderURL.appendingPathComponent(imageName + ".png")
    }
}
