//
//  MovieListViewModel.swift
//  MovieBuff
//
//  Created by Shreyas Rajapurkar on 23/09/23.
//

import Foundation

protocol MovieListViewModelProtocol {
    func fetchMoviesList(completion: @escaping (Result<[MovieCellViewModel], FetchMoviesError>) -> Void)
    func fetchPlaylistsFromCache() -> [Playlist]
}

final class MovieListViewModel: MovieListViewModelProtocol {
    func fetchMoviesList(completion: @escaping (Result<[MovieCellViewModel], FetchMoviesError>) -> Void) {
        do {
            // TODO: Using local static var to fetch data, not to be done in production. Either fetch from backend or store in local DB.
            let decodedData = try JSONDecoder().decode(Movies.self, from: Data(MockData.mockData.utf8))
            let cellViewModels = decodedData.results.map { movie in
                return MovieCellViewModel(movie: movie)
            }

            // TODO: When the network layer is implemented, send the result type back from there to the viewmodel instead of creating it here like this
            let result: Result<[MovieCellViewModel], FetchMoviesError> = .success(cellViewModels)

            // Adding async after to simulate network call, ideally will not be this way in production code
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                completion(result)
            })
        } catch {
            let result: Result<[MovieCellViewModel], FetchMoviesError> = .failure(.decodingFailed)
            completion(result)
        }
    }

    func fetchPlaylistsFromCache() -> [Playlist] {
        if let data = UserDefaults.standard.data(forKey: "playlists") {
            do {
                let playlists = try JSONDecoder().decode([Playlist].self, from: data)
                return playlists
            } catch {
                // TODO: Handle error similar to fetch movies
            }
        }
        return []
    }
}
