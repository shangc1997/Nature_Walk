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
    var sessions: [Session]

    // 依赖注入点:默认仍用 sampleSessions(生产代码 SessionViewModel() 不受影响),
    // 单元测试 / SwiftUI 预览时可注入自定义会话数据,不依赖写死的静态常量。
    init(sessions: [Session] = sampleSessions) {
        self.sessions = sessions
    }

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
                "https://mediaim.expedia.com/localexpert/1344001/32202543-d7e2-4eea-84c9-eb5d07853cd2.jpg?impolicy=resizecrop&rw=1005&rh=565",
                "https://livinlifewithlori.com/wp-content/uploads/2020/09/One-Day-Trip-To-Niagara-Falls-New-York.jpeg",
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
