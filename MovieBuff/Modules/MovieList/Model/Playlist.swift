//
//  Playlist.swift
//  MovieBuff
//
//  Created by Shreyas Rajapurkar on 23/09/23.
//

import Foundation

struct Playlist: Codable {
    let name: String
    let movies: [Movie]
}
