//
//  UserViewModelTests.swift
//  Group_Nature_Walk_ProjectTests
//
//  Exercises UserViewModel through its injected UserDefaults dependency so the
//  tests never touch the real `.standard` store on disk.
//

import Foundation
import Testing

@testable import Group_Nature_Walk_Project

struct UserViewModelTests {

    /// A fresh, empty UserDefaults backed by a unique suite, so each test is
    /// isolated from the real store and from every other test.
    private func makeIsolatedDefaults() -> UserDefaults {
        let suiteName = "test.\(UUID().uuidString)"
        let defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
        return defaults
    }

    @Test func loginWithSampleUserSucceeds() throws {
        let vm = UserViewModel(defaults: makeIsolatedDefaults())

        try vm.login(email: "test@gmail.com", password: "test123", rememberMe: false)

        #expect(vm.isLoggedIn)
        #expect(vm.currentUser?.email == "test@gmail.com")
    }

    @Test func loginIsCaseAndWhitespaceInsensitiveOnEmail() throws {
        let vm = UserViewModel(defaults: makeIsolatedDefaults())

        try vm.login(email: "  TEST@Gmail.com  ", password: "test123", rememberMe: false)

        #expect(vm.isLoggedIn)
    }

    @Test func wrongPasswordThrowsInvalidCredentials() {
        let vm = UserViewModel(defaults: makeIsolatedDefaults())

        do {
            try vm.login(email: "test@gmail.com", password: "wrong", rememberMe: false)
            Issue.record("Expected login to throw")
        } catch AuthError.invalidCredentials {
            // expected
        } catch {
            Issue.record("Unexpected error: \(error)")
        }
        #expect(!vm.isLoggedIn)
    }

    @Test func emptyEmailThrowsEmptyEmail() {
        let vm = UserViewModel(defaults: makeIsolatedDefaults())

        do {
            try vm.login(email: "   ", password: "test123", rememberMe: false)
            Issue.record("Expected login to throw")
        } catch AuthError.emptyEmail {
            // expected
        } catch {
            Issue.record("Unexpected error: \(error)")
        }
    }

    @Test func rememberMePersistsIntoTheSharedDefaults() throws {
        // Injecting one shared defaults into two instances simulates an app relaunch:
        // the second instance must restore what the first one saved.
        let defaults = makeIsolatedDefaults()

        let first = UserViewModel(defaults: defaults)
        try first.login(email: "test@gmail.com", password: "test123", rememberMe: true)

        let second = UserViewModel(defaults: defaults)
        #expect(second.rememberMeEnabled)
        #expect(second.rememberedEmail == "test@gmail.com")
    }

    @Test func notRememberingClearsSavedCredentials() throws {
        let defaults = makeIsolatedDefaults()

        let first = UserViewModel(defaults: defaults)
        try first.login(email: "test@gmail.com", password: "test123", rememberMe: false)

        let second = UserViewModel(defaults: defaults)
        #expect(!second.rememberMeEnabled)
        #expect(second.rememberedEmail.isEmpty)
    }

    @Test func favoritesPersistAcrossInstances() throws {
        let defaults = makeIsolatedDefaults()
        let sessionID = SessionViewModel.sampleSessions[0].id

        // First instance: log in, favorite a session (which saves to defaults).
        let first = UserViewModel(defaults: defaults)
        try first.login(email: "test@gmail.com", password: "test123", rememberMe: false)
        first.toggleFavorite(sessionID: sessionID)
        #expect(first.isFavorite(sessionID: sessionID))

        // Second instance reading the same defaults must see the saved favorite
        // once the same user logs back in.
        let second = UserViewModel(defaults: defaults)
        try second.login(email: "test@gmail.com", password: "test123", rememberMe: false)
        #expect(second.isFavorite(sessionID: sessionID))
    }
}
