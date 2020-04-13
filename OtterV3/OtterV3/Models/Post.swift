//
//  Post.swift
//  OtterV3
//
//  Created by Malik Arachiche on 4/12/20.
//  Copyright © 2020 Malik Arachiche. All rights reserved.
//

import UIKit

class Post: Codable {
    
    private var title: String
    private var content: String
    private var category: String
    //private var image: UIImage?
    private let dateCreated: String
    private let author: User
    private var likes: [String: User]
    private var comments: [String: User]
    
    init(title: String, category: String, author: User, content: String, dateCreated: String) {
        self.title = title
        self.category = category
        self.author = author
        self.content = content
        //self.image = image
        self.dateCreated = dateCreated
        self.likes = [:]
        self.comments = [:]
    }
    
    func getTitle() -> String {
        return self.title
    }
    
    func setTitle(title: String) {
        self.title = title
    }
    
    func getContent() -> String {
        return self.content
    }
    
    func setContent(content: String) {
        self.content = content
    }
    
    func getCategory() -> String {
        return self.category
    }
    
    func setCategory(category: String) {
        self.category = category
    }
    
    func getAuthor() -> User {
        return self.author
    }
    
    func getDateCreated() -> String {
        return self.dateCreated
    }
    
    func getLikes() -> [String:User] {
        return self.likes
    }
    
    func addLike(user: User) {
        self.likes.updateValue(user, forKey: user.getName())
    }
    
    func getNumLikes() -> Int {
        return self.likes.count
    }
    
    func getComments() -> [String:User] {
        return self.comments
    }
    
    func addComment(comment: String, user: User) {
        self.comments.updateValue(user, forKey: comment)
    }
    
    func getNumComments() -> Int {
        return self.comments.count
    }
    
}
