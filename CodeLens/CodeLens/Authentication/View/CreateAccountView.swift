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
        ScrollView {
            VStack {
                Image("signupBackground")
                    .resizable()
                    .scaledToFit()
                
                VStack(spacing: 20) {
                    Text("Create Account")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .padding(.bottom)
                    
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
                    
                    
                    GeneralButton(title: "Sign Up") {
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
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}


#Preview {
    CreateAccountView()
}
