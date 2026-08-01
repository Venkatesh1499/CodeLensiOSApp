//
//  LoginView.swift
//  CodeLens
//
//  Created by Venkatesh Nimmalapudi on 24/07/26.
//
import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = CreateAccountViewModel()
        
    @State var shouldNavigateToSignUp: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
//                Color(hex: "#F3F6FA")
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
                    Spacer()
                    
                    Image("backdrop4")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                    
                    VStack(spacing: 20) {
                        Text("Hey, Welcome back")
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)

                        Text("Login to continue improving your code")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(Color(hex: "#94A3B8"))
                            .padding(.bottom, 5)
                        
                        TextFieldView(image: "envelope",
                                      placeHolder: "Email",
                                      value: $viewModel.email)
                        
                        TextFieldView(image: "lock",
                                      placeHolder: "Password",
                                      isSecureTextField: true,
                                      value: $viewModel.password)
                        
                        HStack {
                            Spacer()
                            
                            Button {
                                print("Forgot password ?")
                            } label: {
                                Text("Forgot password ?")
                                    .foregroundStyle(Color(hex: "#A78BFA"))
                                    .font(.system(size: 16, weight: .regular, design: .default))
                            }
                        }
                        
                        GeneralButton(title: "Login",
                                      isLoading: $viewModel.isLoading) {
                            print("Login TAPPED")
                            withAnimation {
                                viewModel.isLoading.toggle()
                            }
                            AuthenticationManager.shared.login(email: viewModel.email, password: viewModel.password) { error, result in
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                    if error != nil || result == "Error during Login" {
                                        viewModel.shouldShowError = true
                                    } else {
                                        viewModel.shouldShowSuccess = true
                                    }
                                    withAnimation {
                                        viewModel.isLoading.toggle()
                                    }
                                }
                            }
                        }
                        .frame(height: 50)
                        .padding(.bottom)
                    }
                    .padding()
                    
                    SignUpTextView {
                        shouldNavigateToSignUp.toggle()
                    }
                    Spacer()
                }
//                .toastModifier(message: "Login successfull", isSuccess: true, isShowing: $viewModel.shouldShowSuccess)
                .popup(isPresented: $viewModel.shouldShowSuccess, shouldEnhanceBackground: true) {
                    withAnimation {
                        VStack {
                            ToastView(message: "Login Successful", isSuccess: true)
                            
                            Text("Redirecting ....")
                                .font(.system(size: 24, weight: .semibold, design: .rounded))
                                .foregroundStyle(.white)
                        }
                    }
                }
                .popup(isPresented: $viewModel.shouldShowError, shouldEnhanceBackground: false) {
                    withAnimation {
                        ErrorView(title: "Login failed", subTitle: "Invalid email or password") {
                            viewModel.shouldShowError = false
                        }
                        .padding()
                    }
                }
            }
            .navigationDestination(isPresented: $shouldNavigateToSignUp) {
                CreateAccountView()
            }
        }
        .disabled(viewModel.isLoading)
    }
}

struct SignUpTextView: View {
    
    var onTapSignUp: (() -> Void)
    
    var body: some View {
        HStack {
            Text("Don't have an account?")
//                .foregroundStyle(Color.gray)
                .foregroundStyle(Color(hex: "#94A3B8"))
                .font(.system(size: 16, weight: .light, design: .default))
            Button {
                print("Sign Up clicked")
                onTapSignUp()
            } label: {
                Text("Sign Up")
                    .foregroundStyle(Color(hex: "#A78BFA"))
                    .font(.system(size: 16, weight: .regular, design: .default))
            }
        }
    }
}

#Preview {
    LoginView()
}
