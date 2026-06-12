//
//  ContentView.swift
//  Group_Nature_Walk_Project
//
//  Created by Chuhan Shang on 2026-06-09.
//

import SwiftUI

/// Hosts the main tab navigation after the user enters the app.
struct ContentView: View {
    var body: some View {
        TabView {
            SessionView()
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
