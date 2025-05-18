//
//  Trip.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 10/05/25.
//

struct Trip: Decodable {
    let id: Int64
    let title: String
    let startDate: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "name"
        case startDate = "start_date"
    }
}
