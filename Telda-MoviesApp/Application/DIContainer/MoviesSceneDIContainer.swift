//
//  MoviesSearchDIContainer.swift
//  Telda-MoviesApp
//
//  Created by Khaled Elshamy on 26/06/2025.
//

import Foundation
import UIKit

final class MoviesSceneDIContainer: MoviesSearchFlowCoordinatorDependencies {
    struct Dependencies {
        let apiDataTransferService: DataTransferService
        let imageDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies
    
    // MARK: - Persistent Storage
    lazy var moviesQueriesStorage: MoviesQueriesStorage = CoreDataMoviesQueriesStorage(maxStorageLimit: 10)
    lazy var moviesResponseCache: MoviesResponseStorage = CoreDataMoviesResponseStorage()
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeMoviesListViewController(actions: MoviesListViewModelActions) -> MoviesListViewController {
        MoviesListViewController.create(with: DefaultMoviesListViewModel(searchMoviesUseCase: makeSearchMoviesUseCase(),actions: actions),
                                        posterImagesRepository: makePosterImagesRepository())
    }
    
    func makeMoviesDetailsViewController(movie: Movie) -> UIViewController {
        MovieDetailsViewController.create(
            with: makeMoviesDetailsViewModel(movie: movie)
        )
    }
    
    func makeMoviesDetailsViewModel(movie: Movie) -> MovieDetailsViewModel {
        DefaultMovieDetailsViewModel(
            movie: movie,
            posterImagesRepository: makePosterImagesRepository(),
            fetchSimilarMoviesUseCase: makeSimilarMoviesUseCase()
        )
    }
    
    // MARK: - Use Cases
    func makeSearchMoviesUseCase() -> SearchMoviesUseCase {
        DefaultSearchMoviesUseCase(
            moviesRepository: makeMoviesRepository()
        )
    }
    
    func makeSimilarMoviesUseCase() -> FetchSimilarMoviesUseCase {
        DefaultFetchSimilarMoviesUseCase(moviesRepository: makeSimilarMoviesRepositories())
    }
    
    // MARK: - Repositories
    func makeMoviesRepository() -> MoviesRepository {
        DefaultMoviesRepository(
            dataTransferService: dependencies.apiDataTransferService,
            cache: moviesResponseCache
        )
    }
    
    func makeSimilarMoviesRepositories() -> SimilarMoviesRepository {
        DefaultSimilarMoviesRepository(dataTransferService: dependencies.apiDataTransferService)
    }
    
//    func makeMoviesQueriesRepository() -> MoviesQueriesRepository {
//        DefaultMoviesQueriesRepository(
//            moviesQueriesPersistentStorage: moviesQueriesStorage
//        )
//    }
    
    func makePosterImagesRepository() -> PosterImagesRepository {
        DefaultPosterImagesRepository(
            dataTransferService: dependencies.imageDataTransferService
        )
    }
    
    // MARK: - Flow Coordinators
    func makeMoviesSearchFlowCoordinator(navigationController: UINavigationController) -> MoviesSearchFlowCoordinator {
        MoviesSearchFlowCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }
}
