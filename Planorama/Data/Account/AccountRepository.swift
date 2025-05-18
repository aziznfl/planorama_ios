//
//  AccountRepository.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 11/05/25.
//

protocol AccountRepository {
    func fetchAccounts(completion: @escaping (Result<User, Error>) -> Void)
}
