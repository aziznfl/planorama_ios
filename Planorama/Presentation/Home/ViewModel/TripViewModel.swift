//
//  HomeViewModel.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 10/05/25.
//

import Combine
import Foundation

class TripViewModel {
    private let fetchTripUseCase = FetchTripsUseCase()
    
    @Published var trips: ResultState<[TripWrap]> = .idle
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchTrips() {
        trips = .loading
        fetchTripUseCase.execute()
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.trips = .failure(error)
                }
            } receiveValue: { [weak self] trips in
                self?.trips = .success(trips.data)
            }
            .store(in: &cancellables)
    }
}
