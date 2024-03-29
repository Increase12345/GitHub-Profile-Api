//
//  FollowerProfileView.swift
//  GitHub
//
//  Created by Nick Pavlov on 7/6/23.
//

import SwiftUI
import Kingfisher

struct SheetFollowerProfileView: View {
    @EnvironmentObject var vm: ContentViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                ProfileView(user: vm.followerProfile)
                
                Divider()
                Text("All Followers")
                    .foregroundColor(.secondary)
                    .font(.footnote)
                
                ForEach(vm.followersOfFollower) { follower in
                    Button {
                        vm.fetchUser(with: follower.url)
                    } label: {
                        FollowersView(follower: follower)
                    }
                }
            }
            .padding()
        }
    }
}

struct SheetFollowerProfileView_Previews: PreviewProvider {
    static var previews: some View {
        SheetFollowerProfileView()
            .environmentObject(ContentViewModel())
    }
}
