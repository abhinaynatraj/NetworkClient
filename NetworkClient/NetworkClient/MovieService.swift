//
//  RedditService.swift
//  NetworkClient
//
//  Created by Abhiney Natarajan on 9/6/19.
//  Copyright © 2019 Abhiney Natarajan. All rights reserved.
//

import Foundation


public struct MovieService {

    private let baseURL = URL(string: "https://api.themoviedb.org/3")!

    public init() {}

    // Enum Endpoint
    public enum Endpoint: String, CaseIterable {
        case nowPlaying = "now_playing"
        case upcoming
        case popular
        case topRated = "top_rated"
    }

    func fetchMovies(from endpoint: Endpoint,
                            result: @escaping (Result<MoviesResponse, NetworkClient.APIServiceError>) -> Void) {
        let movieURL = baseURL
            .appendingPathComponent("movie")
            .appendingPathComponent(endpoint.rawValue)
        NetworkClient.shared.fetchResources(url: movieURL, completion: result)
    }
}
