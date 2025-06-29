//
//  MoviesListItemViewModel.swift
//  Telda-MoviesApp
//
//  Created by Khaled Elshamy on 27/06/2025.
//

import Foundation

struct MoviesListItemViewModel: Equatable {
    let title: String
    let overview: String
    let releaseDate: String
    let posterImagePath: String?
    
    var year: Int? {
        let releaseDate = releaseDate
        guard let date = dateFormatter.date(from: releaseDate) else {
            return nil
        }
        return Calendar.current.component(.year, from: date)
    }
}

extension MoviesListItemViewModel {

    init(movie: Movie) {
        self.title = movie.title ?? ""
        self.posterImagePath = movie.posterPath
        self.overview = movie.overview ?? ""
        if let releaseDate = movie.releaseDate {
            self.releaseDate = "\(NSLocalizedString("Release Date", comment: "")): \(dateFormatter.string(from: releaseDate))"
        } else {
            self.releaseDate = NSLocalizedString("To be announced", comment: "")
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()
