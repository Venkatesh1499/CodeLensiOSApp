//
//  AuthenticationViewModel.swift
//  CodeLens
//
//  Created by Venkatesh Nimmalapudi on 19/07/26.
//
import Combine

class CreateAccountViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    @Published var isLoading: Bool = false
}
