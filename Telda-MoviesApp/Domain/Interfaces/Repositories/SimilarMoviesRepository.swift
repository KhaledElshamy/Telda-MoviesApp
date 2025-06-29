//
//  MoviesQueriesRepository.swift
//  Telda-MoviesApp
//
//  Created by Khaled Elshamy on 27/06/2025.
//

protocol SimilarMoviesRepository {
    func fetchSimilarMovies(movieId: Int,
                            page: Int,
                            completion: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable?
}
