//
//  LoginView.swift
//  Group_Nature_Walk_Project
//
//  Created by Chuhan Shang on 2026-06-08.
//

import SwiftUI

/// Presents the login form and restores remembered credentials when enabled.
struct LoginView: View {
    @Environment(UserViewModel.self) private var userVM

    @State private var email = ""
    @State private var password = ""
    @State private var rememberMe = false
    @State private var errorMessage = ""
    @State private var loadedRememberedValues = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Nature Walk")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                VStack(spacing: 16) {
                    TextField("Email", text: $email)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .keyboardType(.emailAddress)
                        .padding()
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12))

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12))

                    Toggle("Remember Me", isOn: $rememberMe)

                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .font(.footnote)
                            .foregroundStyle(.red)
                    }

                    Button {
                        do {
                            try userVM.login(
                                email: email,
                                password: password,
                                rememberMe: rememberMe
                            )
                            errorMessage = ""
                        } catch let error as AuthError {
                            // login 目前只会抛 AuthError,直接拿它的本地化文案,
                            // 比原来的 (error as? LocalizedError) 类型擦除更直观。
                            errorMessage =
                                error.errorDescription ?? "Login failed."
                        } catch {
                            // 兜底:防止以后 login 抛出别的错误类型时漏掉。
                            errorMessage = "Login failed."
                        }
                    } label: {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color.green)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                .padding()
                .background(Color(.secondarySystemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 20))

                Spacer()
            }
            .padding()
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Login")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                guard !loadedRememberedValues else { return }
                loadedRememberedValues = true

                rememberMe = userVM.rememberMeEnabled
                if userVM.rememberMeEnabled {
                    email = userVM.rememberedEmail
                    password = userVM.rememberedPassword
                }
            }
        }  //NavigationStack end
    }
}
