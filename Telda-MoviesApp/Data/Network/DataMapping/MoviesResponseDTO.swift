//
//  MviewResponseDTO.swift
//  Telda-MoviesApp
//
//  Created by Khaled Elshamy on 27/06/2025.
//

import Foundation

// MARK: - PopularMovie
struct MoviesResponseDTO: Codable {
    let page: Int
    let results: [MovieDTO]
    let totalPages:Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
    }
}

extension MoviesResponseDTO {
    // MARK: - Result
    struct MovieDTO: Codable {
        let id: Int
        let originalLanguage: String
        let overview: String
        let posterPath, releaseDate, title: String
//        let video: Bool
//        let voteAverage: Double
//        let voteCount: Int

        enum CodingKeys: String, CodingKey {
            case id
            case originalLanguage = "original_language"
//            case originalTitle = "original_title"
            case overview
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case title
//            case video
//            case voteAverage = "vote_average"
//            case voteCount = "vote_count"
        }
    }
}


// MARK: - Mappings to Domain

extension MoviesResponseDTO {
    func toDomain() -> MoviesPage {
        return .init(page: page,
                     totalPages: totalPages,
                     movies: results.map { $0.toDomain() })
    }
}

extension MoviesResponseDTO.MovieDTO {
    func toDomain() -> Movie {
        return .init(id: id,
                     title: title,
                     posterPath: posterPath,
                     overview: overview,
                     releaseDate: dateFormatter.date(from: releaseDate))
    }
}

// MARK: - Private

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
}()
