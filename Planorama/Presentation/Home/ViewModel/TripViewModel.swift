//
//  HomeViewModel.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 10/05/25.
//

import Foundation

class TripViewModel {
    private let fetchTripUseCase = FetchTripsUseCase()
    
    var tripsResponse: ResultState<[Trip]> = .idle
    
    func fetchTrips(completion: @escaping () -> Void) {
        tripsResponse = .loading
        fetchTripUseCase.execute { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let trips):
                    self?.tripsResponse = .success(trips)
                case .failure(let error):
                    self?.tripsResponse = .failure(error)
                }
                completion()
            }
        }
    }
}
