//
//  FetchTripDetailsUseCase.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 20/05/25.
//

import Combine

class FetchTripDetailsUseCase {
    private let repository: TripRepository
    
    init(repository: TripRepository = TripService()) {
        self.repository = repository
    }
    
    func execute(id: Int64) -> AnyPublisher<BaseResponse<TripDetails>, Error> {
        repository.fetchTripDetailsBy(id: id)
    }
}
