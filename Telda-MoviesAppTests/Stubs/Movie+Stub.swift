//
//  Movie+Stub.swift
//  Telda-MoviesAppTests
//
//  Created by Khaled Elshamy on 29/06/2025.
//

import Foundation
@testable import Telda_MoviesApp

extension Movie {
    static func stub(id: Movie.Identifier = "id1",
                title: String = "title1" ,
                posterPath: String? = "/1",
                overview: String = "overview1",
                releaseDate: Date? = nil) -> Self {
        Movie(id: id,
              title: title,
              posterPath: posterPath,
              overview: overview,
              releaseDate: releaseDate)
    }
}
