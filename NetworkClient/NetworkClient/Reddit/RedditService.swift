//
//  RedditService.swift
//  NetworkClient
//
//  Created by Abhiney Natarajan on 9/6/19.
//  Copyright © 2019 Abhiney Natarajan. All rights reserved.
//

import Foundation


public struct RedditService {

    private let baseURL = URL(string: "https://www.reddit.com/r/swift/.json")!

    public init() {}

    func fetchData(result: @escaping (Result<RedditListResponse, NetworkClient.APIServiceError>) -> Void) {
        NetworkClient.shared.fetchResources(url: baseURL, completion: result)
    }
}
