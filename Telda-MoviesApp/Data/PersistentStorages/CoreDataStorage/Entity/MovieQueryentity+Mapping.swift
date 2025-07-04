//
//  MovieQueryentity+Mapping.swift
//  Telda-MoviesApp
//
//  Created by Khaled Elshamy on 28/06/2025.
//

import Foundation
import CoreData

extension MovieQueryEntity {
    convenience init(movieQuery: MovieQuery, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        query = movieQuery.query
        createdAt = Date()
    }
}

extension MovieQueryEntity {
    func toDomain() -> MovieQuery {
        return .init(query: query ?? "")
    }
}
