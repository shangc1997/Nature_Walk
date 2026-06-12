//
//  FavoritesView.swift
//  Group_Nature_Walk_Project
//
//  Created by Chuhan Shang on 2026-06-08.
//

import SwiftUI

/// Displays the current user's saved favorites and supports removing them.
struct FavoritesView: View {
    @Environment(SessionViewModel.self) private var sessionVM
    @Environment(UserViewModel.self) private var userVM

    @State private var sessionToDelete: Session?
    @State private var showRemoveAllAlert = false

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
                                    session: session
                                )
                            } label: {
                                SessionListItem(session: session)
                            }
                            .swipeActions {
                                Button("Remove", role: .destructive) {
                                    sessionToDelete = session
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
                        showRemoveAllAlert = true
                    }
                }
            }
            .alert("Remove Favorite?", isPresented: showDeleteAlert) {
                Button("Cancel", role: .cancel) {
                    sessionToDelete = nil
                }

                Button("Remove", role: .destructive) {
                    if let sessionToDelete {
                        userVM.removeFavorite(sessionID: sessionToDelete.id)
                    }
                    sessionToDelete = nil
                }
            } message: {
                Text(
                    "Are you sure you want to remove this session from favorites?"
                )
            }
            .alert("Remove All Favorites?", isPresented: $showRemoveAllAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Remove All", role: .destructive) {
                    userVM.clearFavorites()
                }
            } message: {
                Text(
                    "Are you sure you want to remove ALL sessions from favorites?"
                )
            }
        }  //NavigationStack end
    }

    private var showDeleteAlert: Binding<Bool> {
        Binding(
            get: { sessionToDelete != nil },
            set: { newValue in
                if !newValue {
                    sessionToDelete = nil
                }
            }
        )
    }
}
