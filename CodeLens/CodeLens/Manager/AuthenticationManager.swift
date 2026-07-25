//
//  AuthenticationViewModel.swift
//  CodeLens
//
//  Created by Venkatesh Nimmalapudi on 25/07/26.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore

class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    
    private init() {}
    
    var isUserLoggedIn: Bool {
        return currentUserID != nil
    }
    
    var currentUserID: FirebaseAuth.User? {
        Auth.auth().currentUser
    }
    
    func signUp(name: String, email: String, password: String, completion: @escaping ((Error?, String?)->Void)) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error during signIn - \(error)")
                completion(error, nil)
            }
            guard let userID = result?.user.uid else {
                print("Error during signIn")
                completion(nil, "Error during signIn")
                return
            }
            
            completion(nil, userID)
            
            let user = User(uid: userID,
                            name: name,
                            email: email,
                            password: password,
                            timeStamp: Date().timeIntervalSince1970)
            self.insertUserToDB(user: user)
        }
    }
    
    func insertUserToDB(user: User) {
        let db = Firestore.firestore()
        
        db.collection("Users")
            .document(user.uid)
            .setData(user.encode()) // we need to convert the user into a dict inorder to store it in Users table inside the firestore
    }
    
    
    func login(email: String, password: String, completion: @escaping ((Error?, String?) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error during login - \(error)")
            }
            guard let userID = result?.user.uid else {
                print("Error during Login")
                return
            }
            print("Login successful", userID)
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // TODO: - Need to test
    func deleteUser(completion: @escaping ((Error?, String?) -> Void)) {
        guard let currentUser = Auth.auth().currentUser else { return }
        
        currentUser.delete { error in
            guard let error = error else {
                completion(nil, "Successfull")
                print("Account deleted succesfully")
                return
            }
            
            completion(error, nil)
        }
    }
    
}
