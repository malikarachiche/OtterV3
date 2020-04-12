//
//  User.swift
//  OtterV3
//
//  Created by Malik Arachiche on 4/10/20.
//  Copyright © 2020 Malik Arachiche. All rights reserved.
//

import UIKit

class User {
    private var id: String?
    private var email: String?
    private var name: String?
    private var dateJoined: String?
    private var career: String?
    private var connections: [String:User]
    private var posts: [Post]
    
    private var data: [String:Any]
    
    init(data: [String:Any]) {
        self.id = data["id"] as? String
        self.name = data["name"] as? String
        self.email = data["email"] as? String
        self.dateJoined = data["dateJoined"] as? String
        self.career = data["career"] as? String
        self.posts = []
        self.connections = [:]
        
        self.data = ["id": self.id ?? "", "email": self.email ?? "", "name": self.name ?? "", "dateJoined": self.dateJoined ?? "", "career": self.career ?? "", "posts": self.posts, "connections": self.connections]
    }
    
    
    func getID() -> String {
        return self.id ?? ""
    }
    
    func setID(ID: String) {
        self.id = ID
    }
    
    func getEmail() -> String {
        return self.email ?? ""
    }
    
    func setEmail(email: String) {
        self.email = email
    }
    
    func getName() -> String {
        return self.name ?? ""
    }
    
    func setName(name: String) {
        self.name = name
    }
    
    func getDateJoined() -> String {
        return self.dateJoined ?? ""
    }
    
    func getCareer() -> String {
        return self.career ?? ""
    }
    
    func setCareer(career: String) {
        self.career = career
    }
    
    func getData() -> [String:Any] {
        return self.data
    }
    
    func getPosts() -> [Post] {
        return self.posts
    }
    
    func addPost(post: Post) {
        self.posts.append(post)
    }
    
    func getConnections() -> [String:User] {
        return self.connections
    }
    
    func addConnection(user: User) {
        let name = user.getName()
        if self.connections[name] != nil {
            print("User already in dictionary")
            return
        } else {
            print("Added \(name) to connections!")
            self.connections.updateValue(user, forKey: name)
        }
    }
    
    func removeConnection(user: User) {
        let name = user.getName()
        if self.connections[name] != nil {
            self.connections.removeValue(forKey: name)
            print("Removed \(name) from connections!")
        } else {
            print("Cannot find \(name)")
        }
    }
    
}
