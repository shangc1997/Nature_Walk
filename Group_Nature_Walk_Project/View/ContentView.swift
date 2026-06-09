//
//  ContentView.swift
//  Group_Nature_Walk_Project
//
//  Created by Chuhan Shang on 2026-06-09.
//

import SwiftUI

struct ContentView: View {
    @State private var sessionVM = SessionViewModel()

    var body: some View {
        TabView {
            SessionView(sessionVM: sessionVM)
                .tabItem {
                    Label("Sessions", systemImage: "map")
                }

            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }

            LogoutView()
                .tabItem {
                    Label("Logout", systemImage: "person.crop.circle.badge.xmark")
                }
        }

    }
}
