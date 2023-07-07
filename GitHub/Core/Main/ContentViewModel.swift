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
    
    // sotre data of main view profile
    @Published var mainUser = User(id: 0, name: "", login: "", bio: "", avatarUrl: "", htmlUrl: "", followersUrl: "", followers: 0, following: 0, url: "")
    
    // store followers of main profile
    @Published var followers = [Followers]()
    
    // store data of sheet view users info
    @Published var followerProfile = User(id: 0, name: "", login: "", bio: "", avatarUrl: "", htmlUrl: "", followersUrl: "", followers: 0, following: 0, url: "")
    @Published var followersOfFollower = [Followers]()
    
    
    init() {
        Task {
            // fetching data of main view user profile
            mainUser = try await service.fetchData(with: "https://api.github.com/users/kentcdodds")
            followers = try await service.fetchData(with: mainUser.followersUrl)
        }
    }
    
    // fetching data of sheet view user profile info
    func fetchUser(with url: String) {
        Task {
            followerProfile = try await service.fetchData(with: url)
            fetchFollowers()
        }
    }
    
    // fetching data of sheet view user followers
    func fetchFollowers() {
        Task {
            followersOfFollower = try await service.fetchData(with: followerProfile.followersUrl)
        }
    }
}
