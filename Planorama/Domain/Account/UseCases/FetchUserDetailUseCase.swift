//
//  FetchUserDetailUseCase.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 11/05/25.
//

class FetchUserDetailUseCase {
    private let repository: AccountRepository
    
    init(repository: AccountRepository = AccountService()) {
        self.repository = repository
    }
    
    func execute(completion: @escaping (Result<User, Error>) -> Void) {
        repository.fetchAccounts(completion: completion)
    }
}
