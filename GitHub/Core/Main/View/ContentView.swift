//
//  ContentView.swift
//  GitHub
//
//  Created by Nick Pavlov on 7/5/23.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @StateObject var vm = ContentViewModel()
    @State private var showDetail = false
    @State private var selectedFilter: FollowerFilter = .followers
    @Namespace var animation

    var body: some View {
        ScrollView {
            VStack {
                // Search section
                searchSection
                
                // Profile section
                ProfileView(user: vm.mainUser)
                    .padding(.top)
                
                // Filter Bar
                filterFollowersBar
                    .padding()
                
                // Followers section
                if selectedFilter == .followers {
                    followersList
                } else {
                    followingList
                }
            }
            .sheet(isPresented: $showDetail) {
                SheetFollowerProfileView()
                    .environmentObject(vm)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView()
        }
    }
}

extension ContentView {
    var filterFollowersBar: some View {
        HStack {
            ForEach(FollowerFilter.allCases, id: \.rawValue) { item in
                VStack {
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == item ? .semibold: .regular)
                        .foregroundColor(selectedFilter == item ? .black: .secondary)
                    
                    if selectedFilter == item {
                        Capsule()
                            .foregroundColor(.blue)
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    } else {
                        Capsule()
                            .foregroundColor(.clear)
                            .frame(height: 3)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        selectedFilter = item
                    }
                }
            }
        }
        .overlay(Divider().offset(x: 0, y: 16))
    }
    
    var followersList: some View {
        VStack {
            if vm.mainFollowers.isEmpty {
                Text("No Followers yet...")
                    .foregroundColor(.secondary)
            } else {
                ForEach(vm.mainFollowers, id: \.id) { follower in
                    Button {
                        vm.fetchUser(with: follower.url)
                        showDetail.toggle()
                    } label: {
                        FollowersView(follower: follower)
                    }
                }
            }
        }
    }
    
    var followingList: some View {
        VStack {
            if vm.mainFollowing.isEmpty {
                Text("No Following yet...")
                    .foregroundColor(.secondary)
            } else {
                ForEach(vm.mainFollowing, id: \.id) { following in
                    Button {
                        vm.fetchUser(with: following.url)
                        showDetail.toggle()
                    } label: {
                        FollowersView(follower: following)
                    }
                }
            }
        }
    }
    
    var searchSection: some View {
        ZStack(alignment: .trailing) {
            SearchFieldView(text: $vm.searchText)
                .onSubmit {
                    Task {
                        try await vm.searchUser(with: vm.searchText)
                    }
                }
            Button {
                Task {
                    try await vm.searchUser(with: vm.searchText)
                }
            } label: {
                Text("Search")
                    .fontWeight(.semibold)
            }
            .padding(.trailing, 35)
        }
    }
}
