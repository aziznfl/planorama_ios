//
//  TripWrap.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 21/05/25.
//

struct TripWrap: Decodable {
    let type: String
    let typeId: Int64
    let list: [Trip]
    
    enum CodingKeys: String, CodingKey {
        case type
        case typeId = "type_id"
        case list
    }
}
