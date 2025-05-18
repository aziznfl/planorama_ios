//
//  User.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 11/05/25.
//

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case avatarUrl = "avatar_url"
    }
}
