//
//  MoviesResponseEntity+Mapping.swift
//  Telda-MoviesApp
//
//  Created by Khaled Elshamy on 28/06/2025.
//

import Foundation
import CoreData

extension MoviesResponseEntity {
    func toDTO() -> MoviesResponseDTO {
        return .init(
            page: Int(page),
            results: movies?.allObjects.map { ($0 as! MovieResponseEntity).toDTO() } ?? [], totalPages: Int(totalPages)
        )
    }
}

extension MovieResponseEntity {
    func toDTO() -> MoviesResponseDTO.MovieDTO {
        return .init(id: Int(id),
                     originalLanguage: "en",
                     overview: overview ?? "",
                     posterPath: posterPath ?? "" ,
                     releaseDate: releaseDate ?? "", title: title ?? "")
//        return .init(
//            id: Int(id),
//            originalLanguage: title ?? "",
//            originalTitle: posterPath ?? "",
//            overview: overview ?? "",
//            posterPath: releaseDate ?? ""
//        )
    }
}

extension MoviesRequestDTO {
    func toEntity(in context: NSManagedObjectContext) -> MoviesRequestEntity {
        let entity: MoviesRequestEntity = .init(context: context)
        entity.query = query
        entity.page = Int32(page)
        return entity
    }
}

extension MoviesResponseDTO {
    func toEntity(in context: NSManagedObjectContext) -> MoviesResponseEntity {
        let entity: MoviesResponseEntity = .init(context: context)
        entity.page = Int32(page)
        entity.totalPages = Int32(totalPages)
        results.forEach {
            entity.addToMovies($0.toEntity(in: context))
        }
        return entity
    }
}

extension MoviesResponseDTO.MovieDTO {
    func toEntity(in context: NSManagedObjectContext) -> MovieResponseEntity {
        let entity: MovieResponseEntity = .init(context: context)
        entity.id = Int64(id)
        entity.title = title
        entity.posterPath = posterPath
        entity.overview = overview
        entity.releaseDate = releaseDate
        return entity
    }
}
