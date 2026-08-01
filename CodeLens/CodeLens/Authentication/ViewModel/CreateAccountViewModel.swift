//
//  AuthenticationViewModel.swift
//  CodeLens
//
//  Created by Venkatesh Nimmalapudi on 19/07/26.
//
import Combine
import Foundation

class CreateAccountViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    @Published var isLoading: Bool = false
    
    @Published var shouldShowSuccess: Bool = false
    @Published var shouldShowError: Bool = false
    
    @Published var isNameTouched: Bool = false
    @Published var isEmailTouched: Bool = false
    @Published var isPasswordTouched: Bool = false
    @Published var isConfirmPasswordTouched: Bool = false
    
    func shouldEnableLoginBtn() -> Bool {
        email.validate(for: [.required, .email]).isEmpty && password.validate(for: [.required, .password]).isEmpty
    }
    
    func shouldEnableSignupBtn() -> Bool {
        name.validate(for: [.required]).isEmpty
        && email.validate(for: [.required, .email]).isEmpty
        && password.validate(for: [.required, .password]).isEmpty
        && confirmPassword.validate(for: [.required, .password, .match(password)]).isEmpty
    }
}

enum ValidationType {
    case required
    case email
    case password
    case match(String)
}

extension String {
    
    func validate(for types: [ValidationType]) -> String {
        for type in types {
            switch type {
            case .required:
                if self.trimmingCharacters(in: .whitespaces).isEmpty {
                    return "This field is required"
                }
            case .email:
                let emailRegex = #"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$"#
                if self.range(of: emailRegex, options: [.regularExpression, .caseInsensitive]) == nil {
                    return "Please enter a valid mail id"
                }
            case .password:
                if self.count < 8 {
                    return "Passowrd should be of minimum 8 characters"
                }
            case .match(let password):
                if self != password {
                    return "Passowrds did not match"
                }
            }
        }
        return ""
    }
}
