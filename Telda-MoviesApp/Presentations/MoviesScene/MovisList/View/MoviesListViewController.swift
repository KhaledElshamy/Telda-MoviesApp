//
//  MoviesListViewController.swift
//  Telda-MoviesApp
//
//  Created by Khaled Elshamy on 26/06/2025.
//

import UIKit


class MoviesListViewController: UIViewController, StoryboardInstantiable, Alertable {
    
    @IBOutlet private var MoviesTableView: UITableView!
    @IBOutlet private var MoviesSearchBar: UISearchBar!
    @IBOutlet private var emptyDataLabel: UILabel!
    var nextPageLoadingSpinner: UIActivityIndicatorView?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind(to: viewModel)
    }
    
    private func setupViews(){
        title = viewModel.screenTitle
        setupSearchBar()
        setupTableView()
    }
    
    private func setupSearchBar() {
        MoviesSearchBar.delegate = self
    }
    
    private func setupTableView() {
        MoviesTableView.dataSource = self
        MoviesTableView.delegate = self
        MoviesTableView.register(MoviesListItemCell.self)
        MoviesTableView.estimatedRowHeight = MoviesListItemCell.height
        MoviesTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func bind(to viewModel: MoviesListViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in self?.updateItems() }
        viewModel.loading.observe(on: self) { [weak self] in self?.updateLoading($0) }
        viewModel.query.observe(on: self) { [weak self] in self?.updateSearchQuery($0) }
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
    }
    
    private func updateItems() {
        MoviesTableView.reloadData()
    }

    private func updateLoading(_ loading: MoviesListViewModelLoading?) {
        emptyDataLabel.isHidden = true
        LoadingView.hide()

        switch loading {
        case .fullScreen:
            LoadingView.show()
            MoviesTableView.tableFooterView = nil
        case .nextPage:
            nextPageLoadingSpinner?.removeFromSuperview()
            nextPageLoadingSpinner = makeActivityIndicator(size: CGSize(width: MoviesTableView.frame.width, height: 44))
            MoviesTableView.tableFooterView = nextPageLoadingSpinner
        case .none:
            emptyDataLabel.isHidden = !viewModel.isEmpty
            MoviesTableView.tableFooterView = nil
        }
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: viewModel.errorTitle, message: error)
    }
    
    private func updateSearchQuery(_ query: String) {
        MoviesSearchBar.resignFirstResponder()
        MoviesSearchBar.text = query
    }
}

extension MoviesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        viewModel.didSearch(query: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.didCancelSearch()
    }
}

extension MoviesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(for: indexPath) as? MoviesListItemCell else {
            return UITableViewCell()
        }
        
        cell.fill(with: viewModel.items.value[indexPath.row],
                  posterImagesRepository: posterImagesRepository)
        
        if indexPath.row == viewModel.items.value.count - 1 {
            viewModel.didLoadNextPage()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.isEmpty ? tableView.frame.height : MoviesListItemCell.height
    }
}

extension MoviesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath.row)
    }
}

