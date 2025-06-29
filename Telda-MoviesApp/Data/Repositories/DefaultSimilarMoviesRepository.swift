import Foundation

final class DefaultSimilarMoviesRepository: SimilarMoviesRepository {
    private let dataTransferService: DataTransferService
    private let backgroundQueue: DataTransferDispatchQueue
    
    init(dataTransferService: DataTransferService,
         backgroundQueue: DataTransferDispatchQueue = DispatchQueue.global(qos: .userInitiated)) {
        self.dataTransferService = dataTransferService
        self.backgroundQueue = backgroundQueue
    }
    
    func fetchSimilarMovies(movieId: Int,
                            page: Int,
                            completion: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable? {
        
        let requestDTO = SimilarMoviesRequestDTO(page: page)
        let task = RepositoryTask()
        
        let endpoint = APIEndpoints.getSimilarMovies(with: requestDTO, movieId: movieId)
        task.networkTask = dataTransferService.request(
            with: endpoint,
            on: backgroundQueue
        ) { result in
            switch result {
            case .success(let responseDTO):
                completion(.success(responseDTO.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return task
    }
}
