//
//  ConversationViewController.swift
//  Chatty
//
//  Created by 박지영 on 2021/07/24.
//

import UIKit
import FirebaseAuth

class ConversationViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //temp => sign out
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validateAuth()
    }
    
    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false, completion: nil)
        }
    }

}
