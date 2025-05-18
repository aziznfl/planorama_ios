//
//  ResultState.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 11/05/25.
//

enum ResultState<T> {
    case idle
    case loading
    case success(T)
    case failure(Error)
}
