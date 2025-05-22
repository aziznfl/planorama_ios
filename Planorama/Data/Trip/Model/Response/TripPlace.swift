//
//  TripPlace.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 20/05/25.
//

import Foundation

struct TripPlace: Decodable {
    let id: Int64
    let name: String
    let startDate: Date?
    let endDate: Date?
    let duration: Int64
    let position: Int64
    let location: Location?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case startDate = "start_date"
        case endDate = "end_date"
        case duration
        case position
        case location
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int64.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        duration = try container.decode(Int64.self, forKey: .duration)
        position = try container.decode(Int64.self, forKey: .position)
        location = try container.decodeIfPresent(Location.self, forKey: .location)
        
        let startDate = try container.decodeIfPresent(String.self, forKey: .startDate)
        let endDate = try container.decodeIfPresent(String.self, forKey: .endDate)
        
        self.startDate = startDate?.toDate
        self.endDate = endDate?.toDate
    }
}
