//
//  AccountService.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 11/05/25.
//

import FirebaseAuth

class AccountService: AccountRepository {
    func fetchAccounts(completion: @escaping (Result<User, Error>) -> Void) {
        guard let userData = Auth.auth().currentUser else {
            return completion(.failure(NSError(domain: "", code: 404, userInfo: nil)))
        }
        
        let user: User = User(id: userData.uid,
                              name: userData.displayName ?? "",
                              email: userData.email ?? "",
                              avatarUrl: userData.photoURL?.absoluteString ?? "")
        return completion(.success(user))
    }
}
