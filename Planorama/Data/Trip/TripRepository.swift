//
//  TripRepository.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 10/05/25.
//

protocol TripRepository {
    func fetchTrips(completion: @escaping (Result<[Trip], Error>) -> Void)
}
