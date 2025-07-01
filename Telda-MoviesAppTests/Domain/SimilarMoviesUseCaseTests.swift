//
//  SimilarMoviesUseCaseTests.swift
//  Telda-MoviesAppTests
//
//  Created by Khaled Elshamy on 01/07/2025.
//

import XCTest
@testable import Telda_MoviesApp

final class SimilarMoviesUseCaseTests: XCTestCase {
    static let moviesPages: [MoviesPage] = {
        let page1 = MoviesPage(page: 1, totalPages: 2, movies: [
            Movie.stub(id: 1, title: "title1", posterPath: "/1", overview: "overview1"),
            Movie.stub(id: 2, title: "title2", posterPath: "/2", overview: "overview2"),
            Movie.stub(id: 3, title: "title3", posterPath: "/3", overview: "overview3"),
            Movie.stub(id: 4, title: "title4", posterPath: "/4", overview: "overview4"),
            Movie.stub(id: 5, title: "title5", posterPath: "/5", overview: "overview5"),
            Movie.stub(id: 6, title: "title6", posterPath: "/6", overview: "overview6"),
            Movie.stub(id: 7, title: "title7", posterPath: "/7", overview: "overview7")])
        return [page1]
    }()
    
    func testSimilarMoviesUseCase_whenSuccessfullyFetchesMovies() {
        
        // Given
        var useCaseCompletionCallsCount = 0
        let moviesRepository = SimilarMoviesRepositoryMock(
            result: .success(SearchMoviesUseCaseTests.moviesPages[0])
        )
        
        let useCase = DefaultFetchSimilarMoviesUseCase(moviesRepository: moviesRepository)
        
        // when
        let requestValue = SimilarMoviesUseCaseRequestValue(
            page: 0
        )
        
        _ = useCase.execute(movieId: 1,
                            requestValue: requestValue,
                            completion: { result in
            useCaseCompletionCallsCount += 1
        })
        
        // then
        XCTAssertEqual(moviesRepository.fetchCompletionCallsCount, 1)
        XCTAssertEqual(useCaseCompletionCallsCount, 1)
    }
    
    
    func testSimilarMoviesUseCase_whenFailingFetchesMovies() {
        
        // Given
        var useCaseCompletionCallsCount = 0
        let moviesRepository = SimilarMoviesRepositoryMock(
            result: .failure(MoviesRepositoryTestError.fail)
        )
        
        let useCase = DefaultFetchSimilarMoviesUseCase(moviesRepository: moviesRepository)
        
        // when
        let requestValue = SimilarMoviesUseCaseRequestValue(
            page: 0
        )
        
        _ = useCase.execute(movieId: 1,
                            requestValue: requestValue,
                            completion: { result in
            useCaseCompletionCallsCount += 1
        })
        
        // then
        XCTAssertEqual(moviesRepository.fetchCompletionCallsCount, 0)
        XCTAssertEqual(useCaseCompletionCallsCount, 1)
    }
}
