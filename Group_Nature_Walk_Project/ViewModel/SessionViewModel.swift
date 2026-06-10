//
//  SessionViewModel.swift
//  Group_Nature_Walk_Project
//
//  Created by Chuhan Shang on 2026-06-08.
//

import Foundation

@Observable
final class SessionViewModel {
    var sessions: [Session] = sampleSessions

    static let sampleSessions: [Session] = [
        Session(
            name: "Toronto Food Walking Tour",
            description:
                "Explore local restaurants and hidden food spots with an experienced guide.",
            starRating: 4.8,
            hostName: "Toronto Local Guides",
            hostPhoneNumber: "416-555-1010",
            photos: [
                "https://images.openai.com/static-rsc-4/zTv-H0s8erLZvoE1j7sqXqYTckCqL-39_h22hjmeB_KLnDYe-8snUsHe5I6n8LUEVVWJ_a09govyshRT2j7l_W4GY70fOFwSvV3-zn81mvvkRZJnMK40D_mSisWz1MFHMJuRWrMv5HLme8_aRrlvTw_44sxtttmZGfbgj_GG5xM?purpose=inline",
                "foodTour2",
            ],
            pricePerPerson: 45.00
        ),
        Session(
            name: "Niagara Falls Day Trip",
            description:
                "A guided day trip to Niagara Falls including sightseeing and photo stops.",
            starRating: 4.6,
            hostName: "Ontario Travel Group",
            hostPhoneNumber: "905-555-2020",
            photos: ["niagara1", "niagara2"],
            pricePerPerson: 89.99
        ),
        Session(
            name: "Toronto Harbour Sunset Cruise",
            description:
                "Enjoy a relaxing evening cruise with stunning views of Toronto's skyline.",
            starRating: 4.7,
            hostName: "Harbour Tours Toronto",
            hostPhoneNumber: "647-555-3030",
            photos: ["cruise1", "cruise2"],
            pricePerPerson: 59.99
        ),
    ]
}
