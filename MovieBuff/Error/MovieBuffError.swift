//
//  File.swift
//  MovieBuff
//
//  Created by Shreyas Rajapurkar on 23/09/23.
//

import Foundation

// Could not handle all errors in time, but this class can be used to add custom errors
enum FetchMoviesError: Error {
    case decodingFailed
}
