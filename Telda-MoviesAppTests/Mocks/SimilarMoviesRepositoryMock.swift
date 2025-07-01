//
//  SimilarMoviesRepositoryMock.swift
//  Telda-MoviesAppTests
//
//  Created by Khaled Elshamy on 01/07/2025.
//

import Foundation
@testable import Telda_MoviesApp


class SimilarMoviesRepositoryMock: SimilarMoviesRepository {
    
    var result: Result<MoviesPage, Error>
    var fetchCompletionCallsCount = 0

    init(result: Result<MoviesPage, Error>) {
        self.result = result
    }
    
    func fetchSimilarMovies(movieId: Int,
                            page: Int,
                            completion: @escaping (Result<MoviesPage, any Error>) -> Void) -> (any Cancellable)? {
        switch result {
        case .success(_):
            fetchCompletionCallsCount += 1
        case .failure(_):
            fetchCompletionCallsCount = 0
        }
        completion(result)
        return nil
    }
}
