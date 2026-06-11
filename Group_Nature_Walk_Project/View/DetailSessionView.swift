//
//  DetailSessionView.swift
//  Group_Nature_Walk_Project
//
//  Created by Chuhan Shang on 2026-06-08.
//

import SwiftUI

/// Shows the full details for the selected session.
struct DetailSessionView: View {
    @Environment(\.openURL) private var openURL
    let session: Session
    let userVM: UserViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(session.name)
                        .font(.title2)
                        .fontWeight(.bold)

                    HStack(spacing: 6) {
                        Image(systemName: "dollarsign.circle.fill")
                            .foregroundStyle(.yellow)

                        Text("\(session.pricePerPerson.currencyText) / person")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }

                    HStack(spacing: 6) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)

                        Text(session.starRatingText)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                    //.foregroundStyle(.green)
                }  //VStack end
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))

                VStack(alignment: .leading, spacing: 10) {
                    Text("Photos")
                        .font(.headline)

                    GeometryReader { proxy in
                        let spacing: CGFloat = 12
                        let photoWidth = (proxy.size.width - spacing) / 2

                        HStack(spacing: spacing) {
                            ForEach(session.photos.prefix(2), id: \.self) { photo in
                                SessionPhotoCard(photo: photo)
                                    .frame(width: photoWidth, height: 120)
                            }
                        }
                    }
                    .frame(height: 120)
                }  //VStack end
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))

                VStack(alignment: .leading, spacing: 10) {
                    Text("Description")
                        .font(.headline)

                    Text(session.description)
                        .foregroundStyle(.secondary)
                }  //VStack end
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))

                VStack(alignment: .leading, spacing: 10) {
                    Text("Guide / Organization")
                        .font(.headline)

                    Text(session.hostName)
                        .font(.subheadline)

                    Button {
                        if let phoneURL {
                            openURL(phoneURL)
                        }
                    } label: {
                        Label(
                            session.hostPhoneNumber,
                            systemImage: "phone.fill"
                        )
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(.blue)
                    }
                    .buttonStyle(.plain)
                }  //VStack end
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))

                HStack(spacing: 12) {
                    Button {
                        // TODO: Connect this action to the current user's favorites list.
                    } label: {
                        Label(
                            true
                                ? "Favorites!" : "Add to Favorites",
                            systemImage: true
                                ? "heart.fill" : "heart"
                        )
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(
                            true ? Color.red : Color.green
                        )
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }

                    ShareLink(item: shareText) {
                        Label("Share", systemImage: "square.and.arrow.up")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color.blue)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }

            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Session Details")
        .navigationBarTitleDisplayMode(.inline)
    }

    /// Builds a phone URL after stripping formatting characters from the number.
    private var phoneURL: URL? {
        let phoneDigits = session.hostPhoneNumber.filter { $0.isNumber }
        guard !phoneDigits.isEmpty else { return nil }
        return URL(string: "tel://\(phoneDigits)")
    }

    /// Text shared through the system share sheet.
    private var shareText: String {
        "\(session.name) - \(session.pricePerPerson.currencyText)/person"
    }

    /// Displays either a remote image URL or a local asset from the session photos array.
    private struct SessionPhotoCard: View {
        let photo: String

        var body: some View {
            Group {
                if let url = URL(string: photo), photo.hasPrefix("http") {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.gray.opacity(0.15))
                                ProgressView()
                            }

                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()

                        case .failure:
                            placeholder

                        @unknown default:
                            placeholder
                        }
                    }
                } else {
                    Image(photo)
                        .resizable()
                        .scaledToFill()
                }
            }
            .clipped()
            .background(Color.gray.opacity(0.15))
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }

        /// Fallback UI shown when an image cannot be loaded.
        private var placeholder: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.15))

                Image(systemName: "photo")
                    .font(.title2)
                    .foregroundStyle(.gray)
            }
        }
    }
}
