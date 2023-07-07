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

    var body: some View {
        ScrollView {
            VStack {
                ZStack(alignment: .trailing) {
                    SearchFieldView(text: $vm.searchText)
                    Button {
                        Task {
                            try await vm.searchUser(with: vm.searchText)
                        }
                    } label: {
                        Text("Search")
                            .fontWeight(.semibold)
                    }
                    .padding(.trailing, 30)
                }
                
                ProfileView(user: vm.mainUser)
                
                Divider()
                Text("All Followers")
                    .foregroundColor(.secondary)
                    .font(.footnote)
                
                ForEach(vm.followers, id: \.id) { follower in
                    Button {
                        vm.fetchUser(with: follower.url)
                        showDetail.toggle()
                    } label: {
                        FollowersView(follower: follower)
                    }
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
