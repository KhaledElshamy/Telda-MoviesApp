//
//  SearchMoviesUseCase.swift
//  Telda-MoviesApp
//
//  Created by Khaled Elshamy on 27/06/2025.
//

import Foundation

protocol SearchMoviesUseCase {
    func execute(
        requestValue: SearchMoviesUseCaseRequestValue,
        cached: @escaping (MoviesPage) -> Void,
        completion: @escaping (Result<MoviesPage, Error>) -> Void
    ) -> Cancellable?
}

class DefaultSearchMoviesUseCase: SearchMoviesUseCase {
    
    private let moviesRepository: MoviesRepository
//    private let moviesQueriesRepository: MoviesQueriesRepository
    
    init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }
    
    func execute(
        requestValue: SearchMoviesUseCaseRequestValue,
        cached: @escaping (MoviesPage) -> Void,
        completion: @escaping (Result<MoviesPage, any Error>) -> Void
    )->  Cancellable? {
        return moviesRepository.fetchMoviesList(
            query: requestValue.query,
            page: requestValue.page,
            cached: cached
        ) { result in
            completion(result)
        }
    }
}


struct SearchMoviesUseCaseRequestValue {
    let query: MovieQuery
    let page: Int
}
