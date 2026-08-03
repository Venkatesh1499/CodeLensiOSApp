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
            CommonBackgroundView(animationRequired: true)
            .animation(.easeInOut(duration: 1.0))
            
            
            VStack(alignment: .leading, spacing: 25) {
                TitleAndSubtitleView(title: "Build better code with CodeLens",
                                     titleSize: 30,
                                     subtitle: "Create an account to get personalized code insights",
                                     subtitleSize: 18)
                .padding(5)
                
                TextFieldView(image: "person",
                              placeHolder: "Name",
                              value: $viewModel.name,
                              isTouched: $viewModel.isNameTouched,
                              error: viewModel.name.validate(for: [.required]))
                .onChange(of: viewModel.name) { 
                    viewModel.isNameTouched = true
                }
                
                TextFieldView(image: "envelope",
                              placeHolder: "Email",
                              value: $viewModel.email,
                              isTouched: $viewModel.isEmailTouched,
                              error: viewModel.email.validate(for: [.required, .email]))
                .onChange(of: viewModel.email) { 
                    viewModel.isEmailTouched = true
                }
                
                TextFieldView(image: "lock",
                              placeHolder: "Password",
                              isSecureTextField: true,
                              value: $viewModel.password,
                              isTouched: $viewModel.isPasswordTouched,
                              error: viewModel.password.validate(for: [.required, .password]))
                .onChange(of: viewModel.password) { 
                    viewModel.isPasswordTouched = true
                }
                
                TextFieldView(image: "lock",
                              placeHolder: "Confirm password",
                              isSecureTextField: true,
                              value: $viewModel.confirmPassword,
                              isTouched: $viewModel.isConfirmPasswordTouched,
                              error: viewModel.confirmPassword.validate(for: [.required, .match(viewModel.password)]))
                .onChange(of: viewModel.confirmPassword) { 
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
                            // delay is just to show case the animations that will happen and nothing else
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
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
