//
//  FavoritesView.swift
//  Group_Nature_Walk_Project
//
//  Created by Chuhan Shang on 2026-06-08.
//

import SwiftUI

/// Displays the current user's saved favorites and supports removing them.
struct FavoritesView: View {
    let sessionVM: SessionViewModel
    let userVM: UserViewModel

    /// Resolves the current user's favorite session IDs into full session models.
    private var favoriteSessions: [Session] {
        userVM.favoriteSessions(from: sessionVM.sessions)
    }

    var body: some View {
        NavigationStack {
            Group {
                if favoriteSessions.isEmpty {
                    ContentUnavailableView(
                        "No Favorites Yet",
                        systemImage: "heart.slash",
                        description: Text(
                            "Add a favorite session from the details screen."
                        )
                    )
                } else {
                    List {
                        ForEach(favoriteSessions) { session in
                            NavigationLink {
                                DetailSessionView(
                                    session: session,
                                    userVM: userVM
                                )
                            } label: {
                                SessionListItem(session: session)
                            }
                            .swipeActions {
                                Button("Remove", role: .destructive) {
                                    userVM.removeFavorite(sessionID: session.id)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if !favoriteSessions.isEmpty {
                    Button("Remove All", role: .destructive) {
                        userVM.clearFavorites()
                    }
                }
            }
        }  //NavigationStack end
    }
}
