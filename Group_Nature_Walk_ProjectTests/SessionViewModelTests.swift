//
//  SessionViewModelTests.swift
//  Group_Nature_Walk_ProjectTests
//
//  Shows how SessionViewModel's injected session list lets tests run against
//  fixed data instead of the bundled sampleSessions.
//

import Foundation
import Testing

@testable import Group_Nature_Walk_Project

struct SessionViewModelTests {

    private func makeSession(name: String, price: Double) -> Session {
        Session(
            name: name,
            description: "A test session.",
            starRating: 5,
            hostName: "Test Host",
            hostPhoneNumber: "000-000-0000",
            photos: [],
            pricePerPerson: price
        )
    }

    @Test func injectsCustomSessions() {
        let injected = [makeSession(name: "Only One", price: 10)]
        let vm = SessionViewModel(sessions: injected)

        #expect(vm.sessions.count == 1)
        #expect(vm.sessions.first?.name == "Only One")
    }

    @Test func defaultInitUsesSampleSessions() {
        let vm = SessionViewModel()

        #expect(vm.sessions.count == SessionViewModel.sampleSessions.count)
    }
}
