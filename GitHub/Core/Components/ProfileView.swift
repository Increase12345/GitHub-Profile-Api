//
//  ProfileView.swift
//  GitHub
//
//  Created by Nick Pavlov on 7/5/23.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    let user: User
    
    var body: some View {
        VStack {
            KFImage(URL(string: user.avatarUrl))
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .clipShape(Circle())
            
            VStack {
                Text(user.name)
                    .font(.largeTitle.bold())
                Text(user.bio ?? "no bio")
                    .font(.footnote)
                
                Link("Visit on GitHub", destination: URL(string: user.htmlUrl) ?? URL(string: "https://www.apple.com")!)
                
                HStack(spacing: 50) {
                    VStack {
                        Text("Followers")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        Text("\(user.followers)")
                            .bold()
                    }
                    VStack {
                        Text("Following")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        Text("\(user.following)")
                            .bold()
                    }
                }
                .padding()
            }
            .padding(.top, 10)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User.MOCK_User)
    }
}
