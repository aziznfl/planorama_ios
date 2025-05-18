//
//  BaseResponse.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 11/05/25.
//

struct BaseResponse<T: Decodable>: Decodable {
    let data: T
}
