//
//  SessionView.swift
//  Group_Nature_Walk_Project
//
//  Created by Chuhan Shang on 2026-06-08.
//

import SwiftUI

/// Displays the list of available sessions and navigates to session details.
struct SessionView: View {
    @Environment(SessionViewModel.self) private var sessionVM

    private let appName = "Nature Walk"

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(sessionVM.sessions) { session in
                        NavigationLink {
                            DetailSessionView(session: session)
                        } label: {
                            SessionListItem(session: session)
                        }
                    }
                } header: {
                    Label("Sessions", systemImage: "mappin.circle")
                }
            }
            .navigationTitle(appName)
            .navigationBarTitleDisplayMode(.inline)
        }  //NavigationStack end
    }
}
