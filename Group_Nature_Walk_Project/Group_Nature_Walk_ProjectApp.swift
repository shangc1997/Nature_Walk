//
//  Group_Nature_Walk_ProjectApp.swift
//  Group_Nature_Walk_Project
//
//  Created by Chuhan Shang on 2026-06-08.
//

import SwiftUI

/// Root app entry point that switches between the login flow and the main tab interface.
@main
struct Group_Nature_Walk_ProjectApp: App {
    @State private var sessionVM = SessionViewModel()
    @State private var userVM = UserViewModel()

    var body: some Scene {
        WindowGroup {
            if userVM.isLoggedIn {
                ContentView(sessionVM: sessionVM, userVM: userVM)
            } else {
                LoginView(userVM: userVM)
            }
        }
    }
}
