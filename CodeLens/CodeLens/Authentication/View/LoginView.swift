import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = CreateAccountViewModel()
        
    @State var shouldNavigateToSignUp: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                CommonBackgroundView(animationRequired: true)
                
                VStack {
                    Spacer()
                    
                    Image("backdrop4")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                    
                    VStack(spacing: 20) {
                        TitleAndSubtitleView(title: "Hey, Welcome back",
                                             titleSize: 30,
                                             subtitle: "Login to continue improving your code",
                                             subtitleSize: 18,
                                             alignment: .center)
                        .padding(.bottom, 5)
                        
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
                        
                        HStack(spacing: 15) {
                            GeneralButton(title: "Login",
                                          shouldEnable: viewModel.shouldEnableLoginBtn(),
                                          isLoading: $viewModel.isLoading) {
                                withAnimation {
                                    viewModel.isLoading.toggle()
                                }
                                // delay is just to show case the animations that will happen and nothing else
                                AuthenticationManager.shared.login(email: viewModel.email, password: viewModel.password) { error, result in
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
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
                            
                            if viewModel.isLoading {
                                withAnimation {
                                    Text("Logging in ...")
                                        .font(.system(size: 24, weight: .semibold, design: .rounded))
                                        .foregroundStyle(.white.opacity(0.75))
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                    
                    SignUpTextView {
                        shouldNavigateToSignUp.toggle()
                    }
                    Spacer()
                }
                .popup(isPresented: $viewModel.shouldShowSuccess, shouldEnhanceBackground: true) {
                    withAnimation {
                        VStack {
                            ToastView(message: "Login Successful", isSuccess: true)
                            
                            Text("Redirecting ....")
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                                .foregroundStyle(.white)
                        }
                        .onDisappear {
                            AuthenticationManager.shared.isUserLoggedIn = true
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
                .font(.system(size: 16, weight: .light, design: .default))
                .foregroundStyle(Color(hex: "#94A3B8"))
            Button {
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
