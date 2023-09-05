//
//  FileManager+Extension.swift
//  BookWorm
//
//  Created by 정경우 on 2023/09/05.
//

import UIKit

extension UIViewController {
    
    func removeImageFromDocument(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            print(error)
        }
        
    }

    func loadImageToDocument(fileName: String) -> UIImage {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return UIImage(systemName: "star.fill")! }
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)!
        } else {
            return UIImage(systemName: "star.fill")!
        }
        
    }
    
    func saveImageToDocument(fileName: String, image: UIImage) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        do {
            try data.write(to: fileURL)
            print("성공")
        } catch let error {
            print("저장 오류!!!", error)
        }


    }
    
    
    
}

