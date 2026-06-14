//
//  SessionListItem.swift
//  Group_Nature_Walk_Project
//
//  Created by Chuhan Shang on 2026-06-08.
//

import SwiftUI

/// Renders a compact summary card for a session inside the list view.
struct SessionListItem: View {
    let session: Session

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: session.photos.first ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()

                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()

                case .failure:
                    placeholder

                // 与 .failure 共用占位图:以后 SwiftUI 新增 phase 时也不会出现空白格
                // (原来这里是 EmptyView)。
                @unknown default:
                    placeholder
                }
            }
            .frame(width: 100, height: 80)
            .background(Color.gray.opacity(0.15))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Spacer()

            VStack(alignment: .leading, spacing: 8) {
                Text(session.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)

                Text("\(session.pricePerPerson.currencyText)/person")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.green)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.green.opacity(0.12))
                    .clipShape(Capsule())
            }

            Spacer()
        }
        .padding()
        .cornerRadius(16)
    }

    /// Fallback thumbnail shown when the session photo fails to load.
    private var placeholder: some View {
        Image(systemName: "photo")
            .resizable()
            .scaledToFit()
            .padding()
            .foregroundStyle(.gray)
    }
}
