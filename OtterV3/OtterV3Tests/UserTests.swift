//
//  UserTests.swift
//  OtterV3Tests
//
//  Created by Malik Arachiche on 4/12/20.
//  Copyright © 2020 Malik Arachiche. All rights reserved.
//

import XCTest
@testable import OtterV3

class UserTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
    }
    
    func testGetters() throws {
        let user = User(id: "123", email: "mlkarachiche@gmail.com", name: "Malik Arachiche", dateJoined: "April 12, 2020", career: "Software Engineer")
        
        XCTAssertEqual("123", user.getID())
        XCTAssertEqual("mlkarachiche@gmail.com", user.getEmail())
        XCTAssertEqual("Malik Arachiche", user.getName())
        XCTAssertEqual("April 12, 2020", user.getDateJoined())
        XCTAssertEqual("Software Engineer", user.getCareer())
    }
    
    func testAddPost() throws {
        let user = User(id: "123", email: "mlkarachiche@gmail.com", name: "Malik Arachiche", dateJoined: "April 12, 2020", career: "Software Engineer")
        let post = Post(title: "First post!", category: "Software", author: user, content: "It's lit", dateCreated: "April 12, 2020")
        
        XCTAssertEqual(0, user.getPosts().count)
        user.addPost(post: post)

        XCTAssertEqual(1, user.getPosts().count)
        XCTAssertEqual(user.getPosts().first?.getTitle(), "First post!")
        
        guard let firstPost = user.getPosts().first else {
            print("Nothing there chief")
            return
        }
        print(firstPost.getTitle())
    }
    
    func testConnections() throws {
        let malik = User(id: "123", email: "mlkarachiche@gmail.com", name: "Malik Arachiche", dateJoined: "April 12, 2020", career: "Software Engineer")
        let michael = User(id: "231", email: "michael@gmail.com", name: "Michael", dateJoined: "April 12, 2020", career: "Welder")
        let sara = User(id: "222", email: "sara@yahoo.com", name: "Sara", dateJoined: "April 12, 2020", career: "Lawyer")
        
        XCTAssertEqual(0, malik.getConnections().count)
        XCTAssertEqual(0, michael.getConnections().count)
        XCTAssertEqual(0, sara.getConnections().count)
        
        malik.addConnection(user: michael)
        XCTAssertEqual(1, malik.getConnections().count)
        
        malik.addConnection(user: sara)
        XCTAssertEqual(2, malik.getConnections().count)
        
        malik.removeConnection(user: sara)
        XCTAssertEqual(1, malik.getConnections().count)
        XCTAssertEqual("Michael", malik.getConnections()["Michael"]?.getName())
        
        malik.removeConnection(user: sara)
        XCTAssertEqual(1, malik.getConnections().count)
        
        malik.removeConnection(user: michael)
        XCTAssertEqual(0, malik.getConnections().count)
    }
}
