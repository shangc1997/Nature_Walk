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
        static let currentLoggedInEmail = "currentLoggedInEmail"
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
    /// The most recently authenticated user's email persisted across launches.
    private(set) var currentLoggedInEmail = ""

    private var usersByID: [User.ID: User] = [:]
    private var userIDByEmail: [String: User.ID] = [:]

    init() {
        defaults = UserDefaults.standard

        rememberMeEnabled = defaults.bool(forKey: DefaultsKey.rememberMeEnabled)
        rememberedEmail =
            defaults.string(forKey: DefaultsKey.rememberedEmail) ?? ""
        rememberedPassword =
            defaults.string(forKey: DefaultsKey.rememberedPassword) ?? ""
        currentLoggedInEmail =
            defaults.string(
                forKey: DefaultsKey.currentLoggedInEmail
            ) ?? ""

        for user in Self.sampleUsers {
            usersByID[user.id] = user
            userIDByEmail[user.email.lowercased()] = user.id
        }
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

        currentLoggedInEmail = user.email
        defaults.set(user.email, forKey: DefaultsKey.currentLoggedInEmail)

        rememberMeEnabled = rememberMe
        defaults.set(rememberMe, forKey: DefaultsKey.rememberMeEnabled)

        if rememberMe {
            rememberedEmail = email
            rememberedPassword = password

            defaults.set(email, forKey: DefaultsKey.rememberedEmail)
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
        currentLoggedInEmail = ""
        defaults.removeObject(forKey: DefaultsKey.currentLoggedInEmail)
    }

    /// Resolves the last logged-in user from persisted identity data without auto-logging in.
    var persistedLoggedInUser: User? {
        guard !currentLoggedInEmail.isEmpty else { return nil }
        guard let userID = userIDByEmail[currentLoggedInEmail.lowercased()]
        else {
            return nil
        }
        return usersByID[userID]
    }

    static let sampleUsers: [User] = [
        User(name: "Test User", email: "test@gmail.com", password: "test123"),
        User(
            name: "Admin User",
            email: "admin@gmail.com",
            password: "admin123"
        ),
    ]
}
