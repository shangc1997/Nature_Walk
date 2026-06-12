//
//  ProfileView.swift
//  Group_Nature_Walk_Project
//
//  Created by Chuhan Shang on 2026-06-09.
//

import SwiftUI

/// Shows the currently logged-in user's basic info and provides a logout action.
struct ProfileView: View {
    let userVM: UserViewModel

    @State private var showLogoutAlert = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if let currentUser = userVM.currentUser {
                    Text(currentUser.name)
                        .font(.title2)
                        .fontWeight(.bold)

                    Text(currentUser.email)
                        .foregroundStyle(.secondary)
                }

                Button("Logout", role: .destructive) {
                    showLogoutAlert = true
                }
                .buttonStyle(.borderedProminent)

                Spacer()
            }
            .padding()
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Logout?", isPresented: $showLogoutAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Logout", role: .destructive) {
                    userVM.logout()
                }
            } message: {
                Text("Are you sure you want to log out?")
            }
        }
    }
}
