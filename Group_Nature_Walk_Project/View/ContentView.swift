//
//  ContentView.swift
//  Group_Nature_Walk_Project
//
//  Created by Chuhan Shang on 2026-06-09.
//

import SwiftUI

struct ContentView: View {
    let sessionVM: SessionViewModel
    let userVM: UserViewModel

    var body: some View {
        TabView {
            SessionView(sessionVM: sessionVM, userVM: userVM)
                .tabItem {
                    Label("Sessions", systemImage: "map")
                }

            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle.fill")
                }
        }
    }
}
