//
//  Untitled.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 10/05/25.
//

import Foundation

class TripService: TripRepository {
    private let apiClient: ApiClient
    
    init(apiClient: ApiClient = .shared) {
        self.apiClient = apiClient
    }
    
    let url = Constants.baseUrl + "/trips"
    
    func fetchTrips(completion: @escaping (Result<[Trip], Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(NSError(domain: "", code: -1)))
            return
        }
        
        apiClient.get(url, responseType: BaseResponse<[Trip]>.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
