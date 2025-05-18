//
//  ContentView.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 07/05/25.
//

import Firebase
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            HomeViewControllerWrapper()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            NavigationView {
                VStack {
                    GoogleSignInButton {
                        handleSignInWithGoogle()
                    }
                    
                    Button("Logout") {
                        logout()
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .cornerRadius(8)
                    .padding(.top, 12)

                }
                .padding()
                .navigationTitle("Account")
            }
            .tabItem {
                Label("Account", systemImage: "person")
            }
        }
    }
    
    func handleSignInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            return
        }

        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
            if let error = error {
                print("Google Sign-In error: \(error)")
                return
            }

            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else { return }

            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: user.accessToken.tokenString
            )

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase Auth error: \(error)")
                    return
                }
                
                authResult?.user.getIDToken() { token, error in
                    guard let token = token else {
                        print("Failed get id token \(error)")
                        return
                    }
                    
                    print(token)
                    // login to you backend api
                }
            }
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            print("Logged out")
        } catch let signOutError as NSError {
            print("error: \(signOutError)")
        }
    }
}

#Preview {
    ContentView()
}
