//
//  MovieDetailsViewModel.swift
//  Telda-MoviesApp
//
//  Created by Khaled Elshamy on 28/06/2025.
//

import Foundation

protocol MovieDetailsViewModelInput {
    func updatePosterImage(width: Int)
    func fetchSimilarMovies(movieId: Int,
                      loading: MoviesListViewModelLoading)
}

protocol MovieDetailsViewModelOutput {
    var title: String { get }
    var posterImage: Observable<Data?> { get }
    var isPosterImageHidden: Bool { get }
    var overview: String { get }
    var movieId:Int {get}
    var similarMovies: Observable<[MoviesListItemViewModel]> { get } /// Also we can
}

protocol MovieDetailsViewModel: MovieDetailsViewModelInput, MovieDetailsViewModelOutput { }

final class DefaultMovieDetailsViewModel: MovieDetailsViewModel {
    
    private let posterImagePath: String?
    private let posterImagesRepository: PosterImagesRepository
    private let fetchSimilarMoviesUseCase:  FetchSimilarMoviesUseCase
    
    private var imageLoadTask: Cancellable? { willSet { imageLoadTask?.cancel() } }
    let similarMovies: Observable<[MoviesListItemViewModel]> = Observable([])
    let loading: Observable<MoviesListViewModelLoading?> = Observable(.none)
    
    private var pages: [MoviesPage] = []
    private var moviesLoadTask: Cancellable? { willSet { moviesLoadTask?.cancel() } }
    private let mainQueue: DispatchQueueType
    
    // MARK: - OUTPUT
    let title: String
    let posterImage: Observable<Data?> = Observable(nil)
    let isPosterImageHidden: Bool
    let overview: String
    let movieId:Int
    
    init(
        movie: Movie,
        posterImagesRepository: PosterImagesRepository,
        fetchSimilarMoviesUseCase: FetchSimilarMoviesUseCase,
        mainQueue: DispatchQueueType = DispatchQueue.main
    ) {
        self.title = movie.title ?? ""
        self.overview = movie.overview ?? ""
        self.posterImagePath = movie.posterPath
        self.movieId = movie.id
        self.isPosterImageHidden = movie.posterPath == nil
        self.posterImagesRepository = posterImagesRepository
        self.fetchSimilarMoviesUseCase = fetchSimilarMoviesUseCase
        self.mainQueue = mainQueue
    }
    
    private func appendPage(_ moviesPage: MoviesPage) {
        pages = pages
            .filter { $0.page != moviesPage.page }
            + [moviesPage]
        similarMovies.value = pages.movies.prefix(5).map(MoviesListItemViewModel.init)
    }
    private func handle(error: Error) {
    }
}

// MARK: - INPUT. View event methods
extension DefaultMovieDetailsViewModel {
    
    func updatePosterImage(width: Int) {
        guard let posterImagePath = posterImagePath else { return }

        imageLoadTask = posterImagesRepository.fetchImage(
            with: posterImagePath,
            width: width
        ) { [weak self] result in
            self?.mainQueue.async {
                guard self?.posterImagePath == posterImagePath else { return }
                switch result {
                case .success(let data):
                    self?.posterImage.value = data
                case .failure: break
                }
                self?.imageLoadTask = nil
            }
        }
    }
    
    func fetchSimilarMovies(movieId: Int,
                            loading: MoviesListViewModelLoading){
        self.loading.value = loading
        
        moviesLoadTask = fetchSimilarMoviesUseCase.execute(
            movieId: movieId,
            requestValue: .init(page: 1),
            completion: { [weak self] result in
                self?.mainQueue.async {
                    switch result {
                    case .success(let page):
                        self?.appendPage(page)
                    case .failure(let error):
                        self?.handle(error: error)
                    }
                    self?.loading.value = .none
                }
            })
    }
}
