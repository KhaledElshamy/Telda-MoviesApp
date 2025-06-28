//
//  MoviesResponsePersistentStorage.swift
//  Telda-MoviesApp
//
//  Created by Khaled Elshamy on 27/06/2025.
//

import Foundation

protocol MoviesResponseStorage {
    func getResponse(
        for request: MoviesRequestDTO,
        completion: @escaping (Result<MoviesResponseDTO?, Error>) -> Void
    )
    func save(response: MoviesResponseDTO, for requestDto: MoviesRequestDTO)
}
