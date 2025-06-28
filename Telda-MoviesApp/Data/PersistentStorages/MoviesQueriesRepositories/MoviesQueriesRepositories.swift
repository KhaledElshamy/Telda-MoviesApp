//
//  MoviesQueriesRepositories.swift
//  Telda-MoviesApp
//
//  Created by Khaled Elshamy on 28/06/2025.
//

import Foundation

protocol MoviesQueriesStorage {
    func fetchRecentsQueries(
        maxCount: Int,
        completion: @escaping (Result<[MovieQuery], Error>) -> Void
    )
    func saveRecentQuery(
        query: MovieQuery,
        completion: @escaping (Result<MovieQuery, Error>) -> Void
    )
}
