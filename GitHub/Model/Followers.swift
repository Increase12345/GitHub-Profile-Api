//
//  Followers.swift
//  GitHub
//
//  Created by Nick Pavlov on 7/5/23.
//

import Foundation

// Model of followers
struct Followers: Codable, Identifiable {
    let id: Int
    let login: String
    let avatarUrl: String
    let nodeId: String
    let url: String
}

// Helping MOCk data
extension Followers {
    static let MOCK_Followers = Followers(id: 0, login: "sallen0400", avatarUrl: "", nodeId: "sjdknvlkanfs", url: "")
}
