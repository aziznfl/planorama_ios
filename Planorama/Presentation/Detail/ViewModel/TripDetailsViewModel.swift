//
//  TripDetailsViewModel.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 20/05/25.
//

import Combine
import Foundation

class TripDetailsViewModel {
    private let fetchTripDetailsUseCase = FetchTripDetailsUseCase()
    
    @Published var tripDetails: ResultState<TripDetails> = .idle
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchTripDetailsBy(id: Int64) {
        tripDetails = .loading
        fetchTripDetailsUseCase.execute(id: id)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Response error \(error)")
                }
            } receiveValue: { [weak self] trips in
                self?.tripDetails = .success(trips.data)
            }
            .store(in: &cancellables)
    }
}
