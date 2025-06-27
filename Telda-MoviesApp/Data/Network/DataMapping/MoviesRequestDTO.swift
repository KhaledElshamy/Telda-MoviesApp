//
//  DataMapping.swift
//  Telda-MoviesApp
//
//  Created by Khaled Elshamy on 27/06/2025.
//

import Foundation

struct MoviesRequestDTO: Encodable {
    let query: String
    let page: Int
}
