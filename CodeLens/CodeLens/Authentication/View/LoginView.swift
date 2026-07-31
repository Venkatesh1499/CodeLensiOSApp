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
                    Spacer()
                    
                    Image("signupBackground")
                        .resizable()
                        .scaledToFit()
                    
                    VStack(spacing: 20) {
                        Text("Login")
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
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
                                    .foregroundStyle(Color(hex: "#A78BFA"))
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
