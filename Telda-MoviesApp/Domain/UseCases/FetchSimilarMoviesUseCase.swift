import Foundation

protocol FetchSimilarMoviesUseCase {
    func execute(movieId: Int,
                 requestValue:SimilarMoviesUseCaseRequestValue,
                 completion: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable?
}

final class DefaultFetchSimilarMoviesUseCase: FetchSimilarMoviesUseCase {
    private let moviesRepository: SimilarMoviesRepository
    
    init(moviesRepository: SimilarMoviesRepository) {
        self.moviesRepository = moviesRepository
    }
    
    func execute(movieId: Int,
                 requestValue:SimilarMoviesUseCaseRequestValue,
                 completion: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable? {
        moviesRepository.fetchSimilarMovies(movieId: movieId,
                                            page: requestValue.page,
                                            completion: completion)
    }
}

struct SimilarMoviesUseCaseRequestValue {
    let page: Int
}
