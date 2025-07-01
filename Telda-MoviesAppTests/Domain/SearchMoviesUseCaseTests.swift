//
//  SearchMoviesUseCaseTests1.swift
//  Telda-MoviesAppTests
//
//  Created by Khaled Elshamy on 29/06/2025.
//

import XCTest
@testable import Telda_MoviesApp

enum MoviesRepositoryTestError: Error {
    case fail
}

final class SearchMoviesUseCaseTests: XCTestCase {

    static let moviesPages: [MoviesPage] = {
        let page1 = MoviesPage(page: 1, totalPages: 2, movies: [
            Movie.stub(id: 1, title: "title1", posterPath: "/1", overview: "overview1"),
            Movie.stub(id: 2, title: "title2", posterPath: "/2", overview: "overview2")])
        let page2 = MoviesPage(page: 2, totalPages: 2, movies: [
            Movie.stub(id: 3, title: "title3", posterPath: "/3", overview: "overview3")])
        return [page1, page2]
    }()
    
    class MoviesRepositoryMock: MoviesRepository {
        var result: Result<MoviesPage, Error>
        var fetchCompletionCallsCount = 0

        init(result: Result<MoviesPage, Error>) {
            self.result = result
        }

        func fetchMoviesList(
            query: MovieQuery,
            page: Int,
            cached: @escaping (MoviesPage) -> Void,
            completion: @escaping (Result<MoviesPage, Error>
            ) -> Void
        ) -> Cancellable? {
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
    
    func testSearchMoviesUseCase_whenSuccessfullyFetchesMovies() {
        
        // Given
        var useCaseCompletionCallsCount = 0
        let moviesRepository = MoviesRepositoryMock(
            result: .success(SearchMoviesUseCaseTests.moviesPages[0])
        )
        
        let useCase = DefaultSearchMoviesUseCase(moviesRepository: moviesRepository)
        
        // when
        let requestValue = SearchMoviesUseCaseRequestValue(
            query: MovieQuery(query: "title1"),
            page: 0
        )
        
        _ = useCase.execute(
            requestValue: requestValue,
            cached: { _ in }
        ) { result in
            useCaseCompletionCallsCount += 1
        }
        
        // then
        XCTAssertEqual(moviesRepository.fetchCompletionCallsCount, 1)
        XCTAssertEqual(useCaseCompletionCallsCount, 1)
    }
    
    
    func testSearchMoviesUseCase_whenFailingFetchesMovies() {
        
        // Given
        var useCaseCompletionCallsCount = 0
        let moviesRepository = MoviesRepositoryMock(
            result: .failure(MoviesRepositoryTestError.fail)
        )
        
        let useCase = DefaultSearchMoviesUseCase(moviesRepository: moviesRepository)
        
        // when
        let requestValue = SearchMoviesUseCaseRequestValue(
            query: MovieQuery(query: "title1"),
            page: 0
        )
        
        _ = useCase.execute(
            requestValue: requestValue,
            cached: { _ in }
        ) { result in
            useCaseCompletionCallsCount += 1
        }
        
        // then
        XCTAssertEqual(moviesRepository.fetchCompletionCallsCount, 0)
        XCTAssertEqual(useCaseCompletionCallsCount, 1)
    }
}
