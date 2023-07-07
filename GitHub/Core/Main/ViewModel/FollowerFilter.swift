//
//  FollowerFilter.swift
//  GitHub
//
//  Created by Nick Pavlov on 7/7/23.
//

import Foundation

enum FollowerFilter: Int, CaseIterable {
case followers, following
    
    var title: String {
        switch self {
        case .followers:
            return "Followers"
        case .following:
            return "Following"
        }
    }
}
