//
//  User.swift
//  OtterV3
//
//  Created by Malik Arachiche on 4/10/20.
//  Copyright © 2020 Malik Arachiche. All rights reserved.
//

import UIKit

class User {
    private var id: String
    private var email: String
    private var name: String
    private var photoURL: String
    private var career: String
    private var data: [String:Any]
    //var posts: [Post]
    
    init(id: String, email: String, name: String, photoURL: String, career: String) {
        self.id = id
        self.email = email
        self.name = name
        self.photoURL = photoURL
        self.career = career
        
        self.data = ["id": id, "email": email, "name": name, "photoURL": photoURL, "career": career]
    }
    
    func getID() -> String {
        return self.id
    }
    
    func setID(ID: String) {
        self.id = ID
    }
    
    func getEmail() -> String {
        return self.email
    }
    
    func setEmail(email: String) {
        self.email = email
    }
    
    func getName() -> String {
        return self.name
    }
    
    func setName(name: String) {
        self.name = name
    }
    
    func getPhotoURL() -> String {
        return self.photoURL
    }
    
    func setPhotoURL(photoURL: String) {
        self.photoURL = photoURL
    }
    
    func getCareer() -> String {
        return self.career
    }
    
    func setCareer(career: String) {
        self.career = career
    }
    
    
}
