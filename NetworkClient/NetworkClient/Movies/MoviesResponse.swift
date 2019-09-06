//
//  MoviesResponse.swift
//  NetworkClient
//
//  Created by Abhiney Natarajan on 9/6/19.
//  Copyright © 2019 Abhiney Natarajan. All rights reserved.
//

import Foundation

public struct MoviesResponse: Codable {

    public let page: Int
    public let totalResults: Int
    public let totalPages: Int
    public let results: [Movie]
}
public struct Movie: Codable {

    public let id: Int
    public let title: String
    public let overview: String
    public let releaseDate: Date
    public let voteAverage: Double
    public let voteCount: Int
    public let adult: Bool
}
