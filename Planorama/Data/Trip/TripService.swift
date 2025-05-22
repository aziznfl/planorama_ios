//
//  Untitled.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 10/05/25.
//

import Combine
import Foundation

class TripService: TripRepository {
    private let apiClient: ApiClientPublisher
    
    init(apiClient: ApiClientPublisher = .shared) {
        self.apiClient = apiClient
    }
    
    let url = Constants.baseUrl + "/trips"
    
    func fetchTrips() -> AnyPublisher<BaseResponse<[TripWrap]>, Error> {
        apiClient.get(url, responseType: BaseResponse<[TripWrap]>.self)
    }
    
    func fetchTripDetailsBy(id: Int64) -> AnyPublisher<BaseResponse<TripDetails>, any Error> {
        apiClient.get("\(url)/\(id)", responseType: BaseResponse<TripDetails>.self)
    }
}
