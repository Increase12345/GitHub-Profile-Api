//
//  FollowersView.swift
//  GitHub
//
//  Created by Nick Pavlov on 7/5/23.
//

import SwiftUI
import Kingfisher

struct FollowersView: View {
    let follower: Followers
    
    var body: some View {
        HStack {
            KFImage(URL(string: follower.avatarUrl))
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(follower.login)
                    .foregroundColor(.black)
                Text(follower.nodeId)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
    }
}

struct FollowersView_Previews: PreviewProvider {
    static var previews: some View {
        FollowersView(follower: Followers.MOCK_Followers)
    }
}
