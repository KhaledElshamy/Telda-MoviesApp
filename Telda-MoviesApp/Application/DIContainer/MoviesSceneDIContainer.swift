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
//    lazy var moviesQueriesStorage: MoviesQueriesStorage = CoreDataMoviesQueriesStorage(maxStorageLimit: 10)
//    lazy var moviesResponseCache: MoviesResponseStorage = CoreDataMoviesResponseStorage()
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeMoviesListViewController(actions: MoviesListViewModelActions) -> MoviesListViewController {
        MoviesListViewController.create(with: DefaultMoviesListViewModel(),
                                        posterImagesRepository: nil)
    }
    
    func makeMoviesDetailsViewController(movie: Movie) -> UIViewController {
        return UIViewController()
    }
    
    // MARK: - Flow Coordinators
    func makeMoviesSearchFlowCoordinator(navigationController: UINavigationController) -> MoviesSearchFlowCoordinator {
        MoviesSearchFlowCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }
}
