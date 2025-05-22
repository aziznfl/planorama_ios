//
//  TripDetail.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 20/05/25.
//

import Foundation

struct TripDetails: Decodable {
    let id: Int64
    let name: String
    let startDate: Date?
    let location: Location?
    let schedules: [Schedules]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case startDate = "start_date"
        case location
        case schedules
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int64.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        location = try container.decodeIfPresent(Location.self, forKey: .location)
        schedules = try container.decode([Schedules].self, forKey: .schedules)
        
        let date = try container.decode(String.self, forKey: .startDate)
        if let parsedDate = date.toDate {
            self.startDate = parsedDate
        } else {
            self.startDate = nil
        }
    }
}

struct Schedules: Decodable {
    let date: String
    let activities: [TripPlace]
}
