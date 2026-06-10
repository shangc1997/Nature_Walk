//
//  UserViewModel.swift
//  Group_Nature_Walk_Project
//
//  Created by Chuhan Shang on 2026-06-09.
//

import Foundation
import Observation

/// Stores user data used for login and user-specific features.
@Observable
final class UserViewModel {
    var users: [User] = sampleUsers

    // TODO: Add current-user state, login validation, and favorites mutations.
    static let sampleUsers: [User] = [
        User(name: "Test User", email: "test@gmail.com", password: "test123"),
        User(
            name: "Admin User",
            email: "admin@gmail.com",
            password: "admin123"
        ),
    ]
}
