//
//  APIEndpoints.swift
//  Telda-MoviesApp
//
//  Created by Khaled Elshamy on 27/06/2025.
//

import Foundation

struct APIEndpoints {
    
    static func getMovies(with moviesRequestDTO: MoviesRequestDTO) -> Endpoint<MoviesResponseDTO> {

        return Endpoint(
            path: moviesRequestDTO.query.isEmpty ? "3/movie/popular" : "3/search/movie",
            method: .get,
            queryParametersEncodable: moviesRequestDTO
        )
    }

    static func getMoviePoster(path: String, width: Int) -> Endpoint<Data> {

        let sizes = [92, 154, 185, 342, 500, 780]
        let closestWidth = sizes
            .enumerated()
            .min { abs($0.1 - width) < abs($1.1 - width) }?
            .element ?? sizes.first!
        
        return Endpoint(
            path: "t/p/w\(closestWidth)\(path)",
            method: .get,
            responseDecoder: RawDataResponseDecoder()
        )
    }
}
