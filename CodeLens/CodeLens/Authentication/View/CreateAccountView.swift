//
//  ContentView.swift
//  CodeLens
//
//  Created by Venkatesh Nimmalapudi on 19/07/26.
//

import SwiftUI

struct AuthView: View {
    
    @State var shouldShowSplashScreen: Bool = false
    
    @StateObject private var authManager = AuthenticationManager.shared
    
    var body: some View {
        VStack {
            if shouldShowSplashScreen {
                SplashScreenAnimation()
            } else {
                if authManager.isUserLoggedIn {
                    LanguageSelectionView()
                } else {
                    LoginView()
                }
            }
        }
        .onAppear {
            shouldShowSplashScreen.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                shouldShowSplashScreen.toggle()
            }
        }
    }
}

struct CreateAccountView: View {
    
    @StateObject var viewModel = CreateAccountViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(hex: "#0F172A"),
                    Color(hex: "#1E293B")
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            .overlay(alignment: .topLeading) {
                withAnimation {
                    ForEach([220, 300, 380], id: \.self) { size in
                        Circle()
                            .fill(.white.opacity(0.01))
                            .stroke(Color.white.opacity(0.08), lineWidth: 1)
                            .frame(width: CGFloat(size), height: CGFloat(size))
                    }
                    .offset(x: 180, y: -180)
                }
            }.animation(.easeInOut(duration: 1.0))
            
            
            VStack(alignment: .leading, spacing: 25) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Build better code with CodeLens")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(.white)
                    
                    Text("Create an account to get personalized code insights")
                        .font(.system(size: 18, weight: .regular))
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(Color(hex: "#94A3B8"))
                }
                .padding(5)
                
                TextFieldView(image: "person",
                              placeHolder: "Name",
                              value: $viewModel.name,
                              isTouched: $viewModel.isNameTouched,
                              error: viewModel.name.validate(for: [.required]))
                .onChange(of: viewModel.name) { _, _ in
                    viewModel.isNameTouched = true
                }
                
                TextFieldView(image: "envelope",
                              placeHolder: "Email",
                              value: $viewModel.email,
                              isTouched: $viewModel.isEmailTouched,
                              error: viewModel.email.validate(for: [.required, .email]))
                .onChange(of: viewModel.email) { _, _ in
                    viewModel.isEmailTouched = true
                }
                
                TextFieldView(image: "lock",
                              placeHolder: "Password",
                              isSecureTextField: true,
                              value: $viewModel.password,
                              isTouched: $viewModel.isPasswordTouched,
                              error: viewModel.password.validate(for: [.required, .password]))
                .onChange(of: viewModel.isPasswordTouched) { _, _ in
                    viewModel.isPasswordTouched = true
                }
                
                TextFieldView(image: "lock",
                              placeHolder: "Confirm password",
                              isSecureTextField: true,
                              value: $viewModel.confirmPassword,
                              isTouched: $viewModel.isConfirmPasswordTouched,
                              error: viewModel.confirmPassword.validate(for: [.required, .match(viewModel.password)]))
                .onChange(of: viewModel.confirmPassword) { _, _ in
                    viewModel.isConfirmPasswordTouched = true
                }
                
                HStack(spacing: 10) {
                    GeneralButton(title: "Sign Up",
                                  shouldEnable: viewModel.shouldEnableSignupBtn(),
                                  isLoading: $viewModel.isLoading) {
                        withAnimation {
                            viewModel.isLoading = true
                        }
                        AuthenticationManager.shared.signUp(name: viewModel.name, email: viewModel.email, password: viewModel.password) { error, result in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                if error != nil || result == "Error during signIn" {
                                    viewModel.shouldShowError = true
                                } else {
                                    viewModel.shouldShowSuccess = true
                                }
                                withAnimation {
                                    viewModel.isLoading = false
                                }
                            }
                        }
                    }
                    .frame(height: 50)
                    .padding(.vertical)
                    
                    if viewModel.isLoading {
                        withAnimation {
                            Text("Creating account ...")
                                .font(.system(size: 24, weight: .semibold, design: .rounded))
                                .foregroundStyle(.white.opacity(0.75))
                        }
                    }
                }
            }
            .padding(.horizontal)
            .popup(isPresented: $viewModel.shouldShowSuccess, shouldEnhanceBackground: true) {
                withAnimation {
                    CreationSuccessView() {
                        AuthenticationManager.shared.isUserLoggedIn = true
                        viewModel.shouldShowSuccess = false
                    }
                }
            }
            .popup(isPresented: $viewModel.shouldShowError, shouldEnhanceBackground: false) {
                withAnimation {
                    ErrorView(title: "Account creation failed", subTitle: "Something went wrong. Please try again.") {
                        viewModel.shouldShowError = false
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    CreateAccountView()
}
