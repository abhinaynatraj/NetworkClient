//
//  MoviesResponse.swift
//  NetworkClient
//
//  Created by Abhiney Natarajan on 9/6/19.
//  Copyright © 2019 Abhiney Natarajan. All rights reserved.
//

import Foundation

public struct RedditListResponse: Codable {
    public let data: RedditData
}

public struct RedditData: Codable {
    public let children: [RedditChild]
}

public struct RedditChild: Codable {
    public let data: Reddit
}

public struct Reddit: Codable {
    public let title: String
    public let author: String
    public let selftext: String?
    public let thumbnail: String?
}
