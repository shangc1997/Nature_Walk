//
//  DetailSessionView.swift
//  Group_Nature_Walk_Project
//
//  Created by Chuhan Shang on 2026-06-08.
//

import SwiftUI

struct DetailSessionView: View {
    @Binding var session: Session
    @Environment(\.openURL) private var openURL

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(session.name)
                        .font(.title2)
                        .fontWeight(.bold)

                    HStack(spacing: 6) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)

                        Text(session.starRatingText)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }

                    Text("\(session.pricePerPerson.currencyText) / person")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.green)
                }  //VStack end
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))

                VStack(alignment: .leading, spacing: 10) {
                    Text("Photos")
                        .font(.headline)

                    //                    HStack(spacing: 12) {
                    //                        For
                    //                    }
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
                        session.isFavorites.toggle()
                    } label: {
                        Label(
                            session.isFavorites
                                ? "Favorites!" : "Add to Favorites",
                            systemImage: session.isFavorites
                                ? "heart.fill" : "heart"
                        )
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(
                            session.isFavorites ? Color.red : Color.green
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

    private var phoneURL: URL? {
        let phoneDigits = session.hostPhoneNumber.filter { $0.isNumber }
        guard !phoneDigits.isEmpty else { return nil }
        return URL(string: "tel://\(phoneDigits)")
    }

    private var shareText: String {
        "\(session.name) - \(session.pricePerPerson.currencyText)/person"
    }
}
