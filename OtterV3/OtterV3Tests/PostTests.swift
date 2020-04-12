//
//  PostTests.swift
//  OtterV3Tests
//
//  Created by Malik Arachiche on 4/12/20.
//  Copyright © 2020 Malik Arachiche. All rights reserved.
//

import XCTest
@testable import OtterV3

class PostTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetters() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let user = User(id: "123", email: "mlkarachiche@gmail.com", name: "Malik Arachiche", dateJoined: "April 11, 2020", career: "SWE")
        let content = "This is my first Otter post, I'm so excited"
        let post = Post(title: "First post!", category: "Software", author: user, content: content, dateCreated: "April 12, 2020")
        
        XCTAssertEqual("First post!", post.getTitle())
        XCTAssertEqual("Software", post.getCategory())
        XCTAssertEqual(content, post.getContent())
        XCTAssertEqual("April 12, 2020", post.getDateCreated())
        XCTAssertEqual(0, post.getNumLikes())
        XCTAssertEqual(0, post.getNumComments())
        
    }
    
    func testLikesAndComments() throws {
        let user = User(id: "123", email: "mlkarachiche@gmail.com", name: "Malik Arachiche", dateJoined: "April 11, 2020", career: "SWE")
        let content = "This is my first Otter post, I'm so excited"
        let post = Post(title: "First post!", category: "Software", author: user, content: content, dateCreated: "April 12, 2020")
        let comment = "Nice job!"
        
        XCTAssertEqual(0, post.getNumLikes())
        XCTAssertEqual(0, post.getNumComments())
        
        post.addLike(user: user)
        print(post.getLikes())
        XCTAssertEqual(1, post.getNumLikes())
        
        post.addComment(comment: comment, user: user)
        XCTAssertEqual(1, post.getNumComments())
        XCTAssertEqual("Malik Arachiche", post.getComments()[comment]?.getName())
        
        let index = post.getComments().firstIndex(where: {$0.key == "Nice job!"})!
        XCTAssertEqual("Nice job!", post.getComments()[index].key)
    }
}
