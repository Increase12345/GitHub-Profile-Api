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
    @Published var mainFollowers = [Followers]()
    
    // store following of main prifile
    @Published var mainFollowing = [Followers]()
    
    // store data of sheet view users info
    @Published var followerProfile = User(id: 0, name: "", login: "", bio: "", avatarUrl: "", htmlUrl: "", followersUrl: "", followers: 0, following: 0, url: "")
    @Published var followersOfFollower = [Followers]()
    
    // stored property for search a user
    @Published var searchText = ""
    
    
    init() {
        Task {
            // fetching data of main view user profile
            mainUser = try await service.fetchData(with: "https://api.github.com/users/increase12345")
            mainFollowers = try await service.fetchData(with: mainUser.followersUrl)
            fetchFollowing()
        }
    }
    
    // function for searching users on gitHub
    func searchUser(with username: String) async throws {
        mainUser = try await service.fetchData(with: "https://api.github.com/users/\(searchText)")
        mainFollowers = try await service.fetchData(with: mainUser.followersUrl)
        fetchFollowing()
        searchText = ""
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
    
    // fetching data of following users
    func fetchFollowing() {
        Task {
            mainFollowing = try await service.fetchData(with: "https://api.github.com/users/\(mainUser.login)/following")
        }
    }
}
