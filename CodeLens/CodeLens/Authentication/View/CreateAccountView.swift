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
                    //                    if true {
                    //                        LanguageSelectionView()
                    //                    } else {
                    //                        // main code view will come here
                    //                    }
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
            Color(hex: "#F3F6FA")
            LinearGradient(
                colors: [
                    Color(hex: "#0F172A"),
                    Color(hex: "#1E293B")
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                
//                Spacer()
                
                ScrollView {
                    
                    VStack {
                        //                    Image("backdrop4")
                        //                        .resizable()
                        //                        .scaledToFit()
                        //                        .frame(height: 300)
                        
                        VStack(spacing: 20) {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Build better code with CodeLens")
                                    .font(.system(size: 30, weight: .bold, design: .rounded))
                                    .foregroundStyle(.white)
                                
                                Text("Create an account to get personalized code insights")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundStyle(Color(hex: "#94A3B8"))
                                    .padding(.bottom, 5)
                            }
                            
                            TextFieldView(image: "person",
                                          placeHolder: "Name",
                                          value: $viewModel.name)
                            
                            TextFieldView(image: "envelope",
                                          placeHolder: "Email",
                                          value: $viewModel.email)
                            
                            TextFieldView(image: "lock",
                                          placeHolder: "Password",
                                          isSecureTextField: true,
                                          value: $viewModel.password)
                            
                            TextFieldView(image: "lock",
                                          placeHolder: "Confirm password",
                                          isSecureTextField: true,
                                          value: $viewModel.confirmPassword)
                            
                            
                            GeneralButton(title: "Sign Up", isLoading: $viewModel.isLoading) {
                                viewModel.isLoading.toggle()
                                AuthenticationManager.shared.signUp(name: viewModel.name, email: viewModel.email, password: viewModel.password) { error, result in
                                    viewModel.isLoading.toggle()
                                    
                                    if let error = error {
                                        print("Error during signIn", error)
                                        return
                                    }
                                    
                                    if result != "Error during signIn" {
                                        print("Successfully signin")
                                    }
                                }
                            }
                            .padding(.vertical)
                        }
                        .padding()
                        .background()
                    }
                    //                Spacer()
                }
            }
        }
    }
}


#Preview {
    CreateAccountView()
}
