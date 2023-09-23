//
//  File.swift
//  MovieBuff
//
//  Created by Shreyas Rajapurkar on 23/09/23.
//

import Foundation

struct Movies: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let title: String
    let rating: CGFloat
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case rating = "vote_average"
        case imageURL = "poster_path"
    }
}
