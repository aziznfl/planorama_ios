//
//  Trip.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 10/05/25.
//

import Foundation

struct Trip: Decodable {
    let id: Int64
    let title: String
    let startDate: Date?
    let image: String?
    let childCount: Int64
    let location: Location?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "name"
        case startDate = "start_date"
        case image = "image"
        case childCount = "trip_places_count"
        case location = "location"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int64.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.childCount = try container.decode(Int64.self, forKey: .childCount)
        self.location = try container.decodeIfPresent(Location.self, forKey: .location)
        
        let date = try container.decode(String.self, forKey: .startDate)
        if let parsedDate = date.toDate {
            self.startDate = parsedDate
        } else {
            self.startDate = nil
        }
    }
}

struct Location: Decodable {
    let name: String
    let coordinate: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case coordinate = "coordinate"
    }
}
