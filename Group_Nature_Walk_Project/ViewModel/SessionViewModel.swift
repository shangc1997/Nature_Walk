//
//  SessionViewModel.swift
//  Group_Nature_Walk_Project
//
//  Created by Chuhan Shang on 2026-06-08.
//

import Foundation

/// Provides the session collection displayed by the sessions tab.
@Observable
final class SessionViewModel {
    /// The session list currently rendered by the app.
    var sessions: [Session] = sampleSessions

    /// Hard-coded session data with stable IDs so favorite mappings persist across launches.
    static let sampleSessions: [Session] = [
        Session(
            id: UUID(uuidString: "11111111-1111-1111-1111-111111111111")!,
            name: "Toronto Food Walking Tour",
            description:
                "Explore local restaurants and hidden food spots with an experienced guide.",
            starRating: 4.8,
            hostName: "Toronto Local Guides",
            hostPhoneNumber: "416-555-1010",
            photos: [
                "https://images.unsplash.com/photo-1414235077428-338989a2e8c0",
                "https://images.unsplash.com/photo-1555396273-367ea4eb4db5",
            ],
            pricePerPerson: 45.00
        ),
        Session(
            id: UUID(uuidString: "22222222-2222-2222-2222-222222222222")!,
            name: "Niagara Falls Day Trip",
            description:
                "A guided day trip to Niagara Falls including sightseeing and photo stops.",
            starRating: 4.6,
            hostName: "Ontario Travel Group",
            hostPhoneNumber: "905-555-2020",
            photos: [
                "https://upload.wikimedia.org/wikipedia/commons/0/06/Niagara_Falls_from_USA.jpg",
                "https://images.unsplash.com/photo-1511497584788-876760111969",
            ],
            pricePerPerson: 89.99
        ),
        Session(
            id: UUID(uuidString: "33333333-3333-3333-3333-333333333333")!,
            name: "Toronto Harbour Sunset Cruise",
            description:
                "Enjoy a relaxing evening cruise with stunning views of Toronto's skyline.",
            starRating: 4.7,
            hostName: "Harbour Tours Toronto",
            hostPhoneNumber: "647-555-3030",
            photos: [
                "https://images.unsplash.com/photo-1517935706615-2717063c2225",
                "https://images.unsplash.com/photo-1514924013411-cbf25faa35bb",
            ],
            pricePerPerson: 59.99
        ),
    ]
}
