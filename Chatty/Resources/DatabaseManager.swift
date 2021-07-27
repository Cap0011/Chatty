//
//  DatabaseManager.swift
//  Chatty
//
//  Created by 박지영 on 2021/07/26.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    struct ChattyUser {
        let nickname: String
        let emailAddress: String
        let profilePictureUrl: String
        let uid: String
    }
}

extension DatabaseManager {
    
    ///check if there's a redundant nickname
    public func validateNewUser(with nickname: String, completion: @escaping ((Bool) -> Void)) {
        database.child("usernames/\(nickname)").observeSingleEvent(of: .value) { snapshot in
            if snapshot.exists() {
                completion(true)
                return
            }
            completion(false)
        }
    }
    
    /// get user data
    public func getUserData(with userID: String, for dataType: String, completion: @escaping ((String) -> Void)) {
        database.child("users/\(userID)").observeSingleEvent(of: .value) { snapshot in
            let value = snapshot.value as? NSDictionary
            let data = value?[dataType] as? String ?? ""
            completion(data)
        }
    }
    
    /// inserts new user to database
    public func insertUser(with user: ChattyUser) {
        database.child("users/\(user.uid)").setValue(["nickname": user.nickname, "email": user.emailAddress, "pictureURL": user.profilePictureUrl, "userID": user.uid])
        database.child("usernames/\(user.nickname)").setValue("")
    }
}
