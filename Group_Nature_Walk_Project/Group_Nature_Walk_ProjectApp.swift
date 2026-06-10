//
//  Group_Nature_Walk_ProjectApp.swift
//  Group_Nature_Walk_Project
//
//  Created by Chuhan Shang on 2026-06-08.
//

import SwiftUI

@main
/// Root app entry point that decides which top-level screen to show.
struct Group_Nature_Walk_ProjectApp: App {
    @State private var sessionVM = SessionViewModel()
    @State private var userVM = UserViewModel()

    var body: some Scene {
        WindowGroup {
            // TODO: Route between LoginView and ContentView using real login state.
            if true {
                ContentView(sessionVM: sessionVM, userVM: userVM)
            } else {
                LoginView()
            }
        }
    }
}
