//
//  AccountDetailViewModel.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 11/05/25.
//

import Foundation

class AccountDetailViewModel {
    private let fetchUserDetail = FetchUserDetailUseCase()
    
    var user: User?
    var error: Error?
    
    func fetchData(completion: @escaping () -> Void) {
        fetchUserDetail.execute { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.user = user
                case .failure(let error):
                    self?.error = error
                }
                completion()
            }
        }
    }
}
