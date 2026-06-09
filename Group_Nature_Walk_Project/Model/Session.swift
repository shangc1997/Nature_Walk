//
//  Session.swift
//  Group_Nature_Walk_Project
//
//  Created by Chuhan Shang on 2026-06-08.
//

import Foundation

struct Session: Codable, Identifiable, Hashable {
    var id: UUID

    var name: String
    var description: String
    var starRating: Double
    var hostName: String
    var hostPhoneNumber: String
    var photos: [String]
    var pricePerPerson: Double
    var isFavorites: Bool
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
