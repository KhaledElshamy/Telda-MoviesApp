//
//  PopularMovies.swift
//  Telda-MoviesApp
//
//  Created by Khaled Elshamy on 26/06/2025.
//

import Foundation

struct Movie: Equatable, Identifiable {
    typealias Identifier = String
    let id: Identifier
    let title: String?
    let posterPath: String?
    let overview: String?
    let releaseDate: Date?
}

struct MoviesPage: Equatable {
    let page: Int
    let totalPages: Int
    let movies: [Movie]
}

extension Array where Element == Movie {
    func groupedByYear() -> [Int: [Movie]] {
        var groupedMovies = [Int: [Movie]]()
        for movie in self {
            if let releaseDate = movie.releaseDate {
                let calendar = Calendar.current
                let year = calendar.component(.year, from: releaseDate)
                if groupedMovies[year] != nil {
                    groupedMovies[year]?.append(movie)
                } else {
                    groupedMovies[year] = [movie]
                }
            }
        }
        return groupedMovies
    }
}
