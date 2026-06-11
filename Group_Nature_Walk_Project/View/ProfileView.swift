//
//  ProfileView.swift
//  Group_Nature_Walk_Project
//
//  Created by Chuhan Shang on 2026-06-09.
//

import SwiftUI

struct ProfileView: View {
    let userVM: UserViewModel

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
                    userVM.logout()
                }
                .buttonStyle(.borderedProminent)

                Spacer()
            }
            .padding()
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
