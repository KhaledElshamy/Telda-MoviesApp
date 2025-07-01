//
//  MovieDetailsViewModelTests.swift
//  Telda-MoviesAppTests
//
//  Created by Khaled Elshamy on 29/06/2025.
//

import XCTest
@testable import Telda_MoviesApp

final class MovieDetailsViewModelTests: XCTestCase {
    
    private enum PosterImageDownloadError: Error {
        case fail
    }
    
    func test_updatePosterImageWithWidthEventReceived_thenImageWithThisWidthIsDownloaded() {
        // given
        let posterImagesRepository = PosterImagesRepositoryMock()
        
        class DefaultfetchSimilarUseCaseMock: FetchSimilarMoviesUseCase {
            func execute(movieId: Int, requestValue: Telda_MoviesApp.SimilarMoviesUseCaseRequestValue, completion: @escaping (Result<Telda_MoviesApp.MoviesPage, any Error>) -> Void) -> (any Telda_MoviesApp.Cancellable)? {
                return nil
            }
        }
        
        let expectedImage = "image data".data(using: .utf8)!
        posterImagesRepository.image = expectedImage

        let viewModel = DefaultMovieDetailsViewModel(
            movie: Movie.stub(posterPath: "posterPath"),
            posterImagesRepository: posterImagesRepository,
            fetchSimilarMoviesUseCase: DefaultfetchSimilarUseCaseMock(),
            mainQueue: DispatchQueueTypeMock()
        )
        
        posterImagesRepository.validateInput = { (imagePath: String, width: Int) in
            XCTAssertEqual(imagePath, "posterPath")
            XCTAssertEqual(width, 200)
        }
        
        // when
        viewModel.updatePosterImage(width: 200)
        
        // then
        XCTAssertEqual(viewModel.posterImage.value, expectedImage)
        XCTAssertEqual(posterImagesRepository.completionCalls, 1)
    }

}
