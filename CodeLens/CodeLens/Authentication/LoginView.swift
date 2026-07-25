//
//  LoginView.swift
//  CodeLens
//
//  Created by Venkatesh Nimmalapudi on 24/07/26.
//
import SwiftUI

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    
    @State var shouldNavigateToSignUp: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "#F8F8FA")
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    Image("signupBackground")
                        .resizable()
                        .scaledToFit()
                    
                    VStack(spacing: 20) {
                        Text("Login")
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .padding(.bottom)
                            .multilineTextAlignment(.center)
                        
                        TextFieldView(image: "envelope",
                                      placeHolder: "Email",
                                      value: $email)
                        
                        TextFieldView(image: "lock",
                                      placeHolder: "Password",
                                      isSecureTextField: true,
                                      value: $password)
                        
                        HStack {
                            Spacer()
                            
                            Button {
                                print("Forgot password ?")
                            } label: {
                                Text("Forgot password ?")
                                    .foregroundStyle(Color.blue.opacity(0.8))
                                    .font(.system(size: 16, weight: .regular, design: .default))
                            }
                        }
                        
                        GeneralButton(title: "Login") {
                            print("Login TAPPED")
                            AuthenticationManager.shared.login(email: email, password: password) { error, result in
                                print(error?.localizedDescription)
                            }
                        }
                        .padding(.bottom)
                    }
                    .padding()
                    
                    SignUpTextView {
                        shouldNavigateToSignUp.toggle()
                    }
                    Spacer()
                }
            }.navigationDestination(isPresented: $shouldNavigateToSignUp) {
                CreateAccountView()
            }
        }
    }
}

struct SignUpTextView: View {
    
    var onTapSignUp: (() -> Void)
    
    var body: some View {
        HStack {
            Text("Don't have an account?")
                .foregroundStyle(Color.gray)
                .font(.system(size: 16, weight: .light, design: .default))
            Button {
                print("Sign Up clicked")
                onTapSignUp()
            } label: {
                Text("Sign Up")
                    .foregroundStyle(Color.blue)
                    .font(.system(size: 16, weight: .regular, design: .default))
            }
        }
    }
}

#Preview {
    LoginView()
}
