//
//  User.swift
//  ToDoFirebase
//
//  Created by Diana on 24/05/2023.
//

import Foundation
import Firebase

struct User {
    let uid: String
    let email: String
    
    init(user: Firebase.User) {
        self.uid = user.uid
        self.email = user.email!
    }
}
