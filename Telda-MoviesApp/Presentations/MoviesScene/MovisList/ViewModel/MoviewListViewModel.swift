//
//  MoviewListViewModel.swift
//  Telda-MoviesApp
//
//  Created by Khaled Elshamy on 26/06/2025.
//

import Foundation


struct MoviesListViewModelActions {
    let showMovieDetails: (Movie) -> Void
}

protocol MoviesListViewModelInput {
//    func viewDidLoad()
//    func didLoadNextPage()
//    func didSearch(query: String)
//    func didCancelSearch()
//    func showQueriesSuggestions()
//    func closeQueriesSuggestions()
//    func didSelectItem(at index: Int)
}

protocol MoviesListViewModelOutput {
//    var items: Observable<[MoviesListItemViewModel]> { get } /// Also we can calculate view model items on demand:  https://github.com/kudoleh/iOS-Clean-Architecture-MVVM/pull/10/files
//    var loading: Observable<MoviesListViewModelLoading?> { get }
//    var query: Observable<String> { get }
//    var error: Observable<String> { get }
//    var isEmpty: Bool { get }
//    var screenTitle: String { get }
//    var emptyDataTitle: String { get }
//    var errorTitle: String { get }
//    var searchBarPlaceholder: String { get }
}

typealias MoviesListViewModel = MoviesListViewModelInput & MoviesListViewModelOutput

class DefaultMoviesListViewModel: MoviesListViewModel {
    
}
