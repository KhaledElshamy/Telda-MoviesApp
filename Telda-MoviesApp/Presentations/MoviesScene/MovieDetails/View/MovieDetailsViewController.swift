//
//  MovieDetailsViewController.swift
//  Telda-MoviesApp
//
//  Created by Khaled Elshamy on 28/06/2025.
//

import UIKit

final class MovieDetailsViewController: UIViewController, StoryboardInstantiable {

    @IBOutlet private var posterImageView: UIImageView!
    @IBOutlet private var overviewTextView: UITextView!
    @IBOutlet private var similarMoviesContainer: UIView!
    @IBOutlet private var similarMoviesStackView: UIStackView!

    // MARK: - Lifecycle

    private var viewModel: MovieDetailsViewModel!
    
    static func create(with viewModel: MovieDetailsViewModel) -> MovieDetailsViewController {
        let view = MovieDetailsViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind(to: viewModel)
    }

    private func bind(to viewModel: MovieDetailsViewModel) {
        viewModel.posterImage.observe(on: self) { [weak self] in self?.posterImageView.image = $0.flatMap(UIImage.init) }
        viewModel.similarMovies.observe(on: self) { [weak self] movies in
            self?.updateSimilarMovies(movies)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewModel.updatePosterImage(width: Int(posterImageView.imageSizeAfterAspectFit.scaledSize.width))
        viewModel.fetchSimilarMovies(movieId: viewModel.movieId,
                                     loading: .fullScreen)
    }

    // MARK: - Private

    private func setupViews() {
        title = viewModel.title
        overviewTextView.text = viewModel.overview
        posterImageView.isHidden = viewModel.isPosterImageHidden
        similarMoviesContainer.isHidden = viewModel.similarMovies.value.isEmpty
        view.accessibilityIdentifier = AccessibilityIdentifier.movieDetailsView
    }

    private func updateSimilarMovies(_ movies: [MoviesListItemViewModel]) {
        similarMoviesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for movie in movies {
            let label = UILabel()
            label.text = movie.title
            similarMoviesStackView.addArrangedSubview(label)
        }
        similarMoviesContainer.isHidden = movies.isEmpty
    }
}
