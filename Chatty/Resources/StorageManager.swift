//
//  StorageManager.swift
//  Chatty
//
//  Created by 박지영 on 2021/07/27.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    
    static let shared = StorageManager()
    
    private let storage = Storage.storage()
    
    public func uploadImage(img: UIImage, filePath: String) {
        var data = Data()
        data = img.jpegData(compressionQuality: 0.8)!
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storage.reference().child(filePath).putData(data, metadata: metaData) { metaData, error in
            if let e = error {
                print(e)
                return
            }
            print(filePath)
        }
    }
    
    public func downloadImage(uid: String, image: UIImageView) {
        let filePath = "gs://chatty-21318.appspot.com/userProfile/\(uid)"
        storage.reference(forURL: filePath).downloadURL { url, error in
            if let e = error {
                print(e)
                return
            }
            let data = NSData(contentsOf: url!)
            let img = UIImage(data: data! as Data)
            image.image = img
            print(filePath)
        }
    }
}
