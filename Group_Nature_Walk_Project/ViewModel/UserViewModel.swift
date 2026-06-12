//
//  UserViewModel.swift
//  Group_Nature_Walk_Project
//
//  Created by Chuhan Shang on 2026-06-09.
//

import Foundation
import Observation

/// Describes validation and authentication failures shown on the login screen.
enum AuthError: LocalizedError {
    case emptyEmail
    case emptyPassword
    case invalidCredentials

    var errorDescription: String? {
        switch self {
        case .emptyEmail:
            return "Please enter your email."
        case .emptyPassword:
            return "Please enter your password."
        case .invalidCredentials:
            return "Invalid email or password."
        }
    }
}

/// Manages login state, remembered credentials, and the last logged-in user identity.
@Observable
final class UserViewModel {
    private enum DefaultsKey {
        static let rememberMeEnabled = "rememberMeEnabled"
        static let rememberedEmail = "rememberEmail"
        static let rememberedPassword = "rememberPassword"
        static let savedUsers = "savedUsers"
        static let persistedLoggedInEmail = "persistedLoggedInEmail"
    }

    private let defaults: UserDefaults

    /// The in-memory user session for the current app launch.
    private(set) var currentUserID: User.ID?
    /// Whether the login form should restore saved credentials on launch.
    private(set) var rememberMeEnabled = false
    /// The email restored into the login form when Remember Me is enabled.
    private(set) var rememberedEmail = ""
    /// The password restored into the login form when Remember Me is enabled.
    private(set) var rememberedPassword = ""
    /// The email address of the most recently authenticated user saved across launches.
    private(set) var persistedLoggedInEmail = ""

    private var usersByID: [User.ID: User] = [:]
    private var userIDByEmail: [String: User.ID] = [:]

    init() {
        defaults = UserDefaults.standard

        rememberMeEnabled = defaults.bool(forKey: DefaultsKey.rememberMeEnabled)
        rememberedEmail =
            defaults.string(forKey: DefaultsKey.rememberedEmail) ?? ""
        rememberedPassword =
            defaults.string(forKey: DefaultsKey.rememberedPassword) ?? ""
        persistedLoggedInEmail =
            defaults.string(forKey: DefaultsKey.persistedLoggedInEmail) ?? ""

        loadUser()
    }

    /// Returns the active user for the current in-memory session.
    var currentUser: User? {
        guard let currentUserID else { return nil }
        return usersByID[currentUserID]
    }

    /// Indicates whether the app should show the main interface or the login screen.
    var isLoggedIn: Bool {
        currentUser != nil
    }

    /// The user whose email was most recently persisted as logged in on this device.
    var persistedLoggedInUser: User? {
        guard !persistedLoggedInEmail.isEmpty else { return nil }
        guard let userID = userIDByEmail[persistedLoggedInEmail.lowercased()]
        else {
            return nil
        }
        return usersByID[userID]
    }

    /// Validates credentials, starts an in-memory session, and updates persisted login metadata.
    func login(email: String, password: String, rememberMe: Bool) throws {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let normalizedEmail = trimmedEmail.lowercased()

        guard !trimmedEmail.isEmpty else {
            throw AuthError.emptyEmail
        }

        guard !password.isEmpty else {
            throw AuthError.emptyPassword
        }

        guard let userID = userIDByEmail[normalizedEmail],
            let user = usersByID[userID],
            user.password == password
        else {
            throw AuthError.invalidCredentials
        }

        currentUserID = user.id

        persistedLoggedInEmail = user.email
        defaults.set(user.email, forKey: DefaultsKey.persistedLoggedInEmail)

        rememberMeEnabled = rememberMe
        defaults.set(rememberMe, forKey: DefaultsKey.rememberMeEnabled)

        if rememberMe {
            rememberedEmail = trimmedEmail
            rememberedPassword = password

            defaults.set(trimmedEmail, forKey: DefaultsKey.rememberedEmail)
            defaults.set(password, forKey: DefaultsKey.rememberedPassword)
        } else {
            rememberedEmail = ""
            rememberedPassword = ""

            defaults.removeObject(forKey: DefaultsKey.rememberedEmail)
            defaults.removeObject(forKey: DefaultsKey.rememberedPassword)
        }
    }

    /// Ends the current in-memory session and clears the persisted logged-in identity.
    func logout() {
        currentUserID = nil

        persistedLoggedInEmail = ""
        defaults.removeObject(forKey: DefaultsKey.persistedLoggedInEmail)
    }

    /// Returns whether the active user has already favorited the given session.
    func isFavorite(sessionID: Session.ID) -> Bool {
        guard let currentUser else { return false }
        return currentUser.favoriteSessionIDs.contains(sessionID)
    }

    /// Adds or removes a session from the active user's favorites, then persists the change.
    func toggleFavorite(sessionID: Session.ID) {
        guard let currentUserID, var user = usersByID[currentUserID] else {
            return
        }

        if user.favoriteSessionIDs.contains(sessionID) {
            user.favoriteSessionIDs.remove(sessionID)
        } else {
            user.favoriteSessionIDs.insert(sessionID)
        }

        usersByID[currentUserID] = user
        saveUser()
    }

    /// Removes one session from the active user's favorites and persists the change.
    func removeFavorite(sessionID: Session.ID) {
        guard let currentUserID, var user = usersByID[currentUserID] else {
            return
        }

        user.favoriteSessionIDs.remove(sessionID)
        usersByID[currentUserID] = user
        saveUser()
    }

    /// Clears every favorite for the active user and persists the updated user list.
    func clearFavorites() {
        guard let currentUserID, var user = usersByID[currentUserID] else {
            return
        }

        user.favoriteSessionIDs.removeAll()
        usersByID[currentUserID] = user
        saveUser()
    }

    /// Resolves the active user's favorite session IDs into full session models.
    func favoriteSessions(from sessions: [Session]) -> [Session] {
        guard let currentUser else { return [] }

        return sessions.filter { session in
            currentUser.favoriteSessionIDs.contains(session.id)
        }
    }

    /// Restores persisted users from UserDefaults or falls back to the bundled sample users.
    private func loadUser() {
        if let data = defaults.data(forKey: DefaultsKey.savedUsers),
            let savedUser = try? JSONDecoder().decode([User].self, from: data),
            !savedUser.isEmpty
        {
            configureUser(savedUser)
        } else {
            configureUser(Self.sampleUsers)
            saveUser()
        }
    }

    /// Rebuilds the in-memory lookup tables used by login and favorites operations.
    private func configureUser(_ users: [User]) {
        usersByID.removeAll()
        userIDByEmail.removeAll()

        for user in users {
            usersByID[user.id] = user
            userIDByEmail[user.email.lowercased()] = user.id
        }
    }

    /// Persists the current user collection, including each user's favorites list.
    private func saveUser() {
        let users = Array(usersByID.values).sorted { $0.email < $1.email }

        guard let data = try? JSONEncoder().encode(users) else {
            return
        }

        defaults.set(data, forKey: DefaultsKey.savedUsers)
    }

    static let sampleUsers: [User] = [
        User(
            name: "Test User",
            email: "test@gmail.com",
            password: "test123"
        ),
        User(
            name: "Admin User",
            email: "admin@gmail.com",
            password: "admin123"
        ),
    ]
}
