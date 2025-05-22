//
//  TripRepository.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 10/05/25.
//

import Combine

protocol TripRepository {
    func fetchTrips() -> AnyPublisher<BaseResponse<[TripWrap]>, Error>
    func fetchTripDetailsBy(id: Int64) -> AnyPublisher<BaseResponse<TripDetails>, Error>
}
