//
//  ContentViewModel.swift
//  GitHub
//
//  Created by Nick Pavlov on 7/5/23.
//

import Foundation

@MainActor
class ContentViewModel: ObservableObject {
    let service = Service()
    @Published var user = User(id: 0, name: "", login: "", bio: "", avatarUrl: "", htmlUrl: "", followersUrl: "", followers: 0, following: 0, url: "")
    @Published var followers = [Followers]()
    
    @Published var followerProfile = User(id: 0, name: "", login: "", bio: "", avatarUrl: "", htmlUrl: "", followersUrl: "", followers: 0, following: 0, url: "")
    @Published var followersOfFollower = [Followers]()
    
    
    init() {
        Task {
            user = try await service.fetchData(with: "https://api.github.com/users/sallen0400")
            followers = try await service.fetchData(with: user.followersUrl)
        }
    }
    
    func fetchUser(with url: String) {
        Task {
            followerProfile = try await service.fetchData(with: url)
            fetchFollowers()
        }
    }
    
    func fetchFollowers() {
        Task {
            followersOfFollower = try await service.fetchData(with: followerProfile.followersUrl)
        }
    }
}
