//
//  UserViewModel.swift
//  Group_Nature_Walk_Project
//
//  Created by Chuhan Shang on 2026-06-09.
//

import Foundation
import Observation

enum AuthError: LocalizedError {
    case emptyEmail
    case invalidEmail
    case emptyPassword
    case invalidCredentials

    var errorDescription: String? {
        switch self {
        case .emptyEmail:
            return "Please enter your email."
        case .invalidEmail:
            return "Please enter a valid email address."
        case .emptyPassword:
            return "Please enter your password."
        case .invalidCredentials:
            return "Invalid email or password."
        }
    }
}

/// Stores user data used for login and user-specific features.
@Observable
final class UserViewModel {
    // TODO: Add current-user state, login validation, and favorites mutations.
    private enum DefaultsKey {
        static let rememberMeEnabled = "rememberMeEnabled"
        static let rememberedEmail = "rememberEmail"
        static let rememberedPassword = "rememberPassword"
    }

    private let defaults: UserDefaults

    private(set) var currentUserID: User.ID?
    private(set) var rememberMeEnabled = false
    private(set) var rememberedEmail = ""
    private(set) var rememberedPassword = ""

    private var usersByID: [User.ID: User] = [:]
    private var userIDByEmail: [String: User.ID] = [:]

    init() {
        defaults = UserDefaults.standard

        rememberMeEnabled = defaults.bool(forKey: DefaultsKey.rememberMeEnabled)
        rememberedEmail =
            defaults.string(forKey: DefaultsKey.rememberedEmail) ?? ""
        rememberedPassword =
            defaults.string(forKey: DefaultsKey.rememberedPassword) ?? ""

        for user in Self.sampleUsers {
            usersByID[user.id] = user
            userIDByEmail[user.email.lowercased()] = user.id
        }
    }

    var currentUser: User? {
        guard let currentUserID else { return nil }
        return usersByID[currentUserID]
    }

    var isLoggedIn: Bool {
        currentUser != nil
    }

    func login(email: String, password: String, rememberMe: Bool) throws {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let normalizedEmail = trimmedEmail.lowercased()

        guard !trimmedEmail.isEmpty else {
            throw AuthError.emptyEmail
        }

        guard isValidEmail(trimmedEmail) else {
            throw AuthError.invalidEmail
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

    func logout() {
        currentUserID = nil
    }

    private func isValidEmail(_ email: String) -> Bool {
        let pattern = #"^\S+@\S+\.\S+$"#
        return email.range(of: pattern, options: .regularExpression) != nil
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
