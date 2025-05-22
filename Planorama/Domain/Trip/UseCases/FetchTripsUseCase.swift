//
//  Trip.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 10/05/25.
//

import Combine

class FetchTripsUseCase {
    private let repository: TripRepository
    
    init(repository: TripRepository = TripService()) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<BaseResponse<[TripWrap]>, Error> {
        repository.fetchTrips()
    }
}
