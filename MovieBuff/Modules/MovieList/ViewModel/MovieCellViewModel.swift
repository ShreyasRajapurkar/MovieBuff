//
//  MovieCellViewModel.swift
//  MovieBuff
//
//  Created by Shreyas Rajapurkar on 23/09/23.
//

import Foundation

/** This class will make the cell more testable. Since the data from the model is not directly usable on the UI, this view model can be an intermediary between the actual model and the view. For unit tests, these properties can be populated with the UI data and multiple UI combinations can be tested easily*/
class MovieCellViewModel {
    let id: Int
    let title: String
    let rating: String
    let thumbnailURL: String

    init(movie: Movie) {
        self.id = movie.id
        self.title = movie.title
        self.rating = String(describing: movie.rating)
        self.thumbnailURL = movie.imageURL
    }
}
