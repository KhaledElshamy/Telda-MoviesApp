//
//  AppDiContainer.swift
//  Telda-MoviesApp
//
//  Created by Khaled Elshamy on 26/06/2025.
//

import Foundation
import UIKit

final class AppDIContainer {
    
    lazy var appConfiguration = AppConfiguration()
    
    // MARK: - Network
    lazy var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(
            baseURL: URL(string: "https://" + "api.themoviedb.org")!,
            queryParameters: [
                "api_key": "e552d7e3015fad1250584f2616c1414c",
                "language": NSLocale.preferredLanguages.first ?? "en"
            ]
        )
        
        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()
    
    lazy var imageDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(
            baseURL: URL(string: "https://" + "image.tmdb.org/")!
        )
        let imagesDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: imagesDataNetwork)
    }()
    
    // MARK: - DIContainers of scenes
    func makeMoviesSceneDIContainer() -> MoviesSceneDIContainer {
        let dependencies = MoviesSceneDIContainer.Dependencies(
            apiDataTransferService: apiDataTransferService,
            imageDataTransferService: imageDataTransferService
        )
        return MoviesSceneDIContainer(dependencies: dependencies)
    }
}
