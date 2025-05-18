//
//  Trip.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 10/05/25.
//

class FetchTripsUseCase {
    private let repository: TripRepository
    
    init(repository: TripRepository = TripService()) {
        self.repository = repository
    }
    
    func execute(completion: @escaping (Result<[Trip], Error>) -> Void) {
        repository.fetchTrips(completion: completion)
    }
}
