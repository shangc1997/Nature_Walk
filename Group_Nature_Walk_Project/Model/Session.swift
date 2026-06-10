//
//  Session.swift
//  Group_Nature_Walk_Project
//
//  Created by Chuhan Shang on 2026-06-08.
//

import Foundation

struct Session: Codable, Identifiable, Hashable {
    let id: UUID

    var name: String
    var description: String
    var starRating: Double
    var hostName: String
    var hostPhoneNumber: String
    var photos: [String]
    var pricePerPerson: Double

    init(
        id: ID = UUID(),
        name: String,
        description: String,
        starRating: Double,
        hostName: String,
        hostPhoneNumber: String,
        photos: [String],
        pricePerPerson: Double
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.starRating = starRating
        self.hostName = hostName
        self.hostPhoneNumber = hostPhoneNumber
        self.photos = photos
        self.pricePerPerson = pricePerPerson
    }
}

extension Double {
    var currencyText: String {
        formatted(.currency(code: "CAD"))
    }
}

extension Session {
    var starRatingText: String {
        String(format: "%.1f / 5", starRating)
    }
}
