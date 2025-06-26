//
//  MoviesListViewController.swift
//  Telda-MoviesApp
//
//  Created by Khaled Elshamy on 26/06/2025.
//

import UIKit


class MoviesListViewController: UIViewController, StoryboardInstantiable, Alertable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("7a7a")
        view.backgroundColor = .blue
    }
    
    private var viewModel: MoviesListViewModel!
    private var posterImagesRepository: PosterImagesRepository?
    
    static func create(
        with viewModel: MoviesListViewModel,
        posterImagesRepository: PosterImagesRepository?
    ) -> MoviesListViewController {
        let view = MoviesListViewController.instantiateViewController()
        view.viewModel = viewModel
        view.posterImagesRepository = posterImagesRepository
        return view
    }
}
