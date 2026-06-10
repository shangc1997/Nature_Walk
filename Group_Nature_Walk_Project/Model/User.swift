//
//  User.swift
//  Group_Nature_Walk_Project
//
//  Created by Chuhan Shang on 2026-06-09.
//

import Foundation

/// Represents a user who can log in and manage a personal favorites list.
struct User: Codable, Identifiable, Hashable {
    let id: UUID

    var name: String
    var email: String
    var password: String
    var favoriteSessionIDs: Set<Session.ID>

    init(
        id: ID = UUID(),
        name: String,
        email: String,
        password: String,
        favoriteSessionIDs: Set<Session.ID> = []
    ) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.favoriteSessionIDs = favoriteSessionIDs
    }
}
