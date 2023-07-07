//
//  User.swift
//  GitHub
//
//  Created by Nick Pavlov on 7/5/23.
//

import Foundation

// Model of User
struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let login: String
    let bio: String?
    let avatarUrl: String
    let htmlUrl: String
    let followersUrl: String
    let followers: Int
    let following: Int
    let url: String
}

// Helping MOCk data
extension User {
    static let MOCK_User = User(id: 0, name: "Nick", login: "increase12345", bio: "I love to code", avatarUrl: "image", htmlUrl: "", followersUrl: "", followers: 124, following: 87, url: "")
}
