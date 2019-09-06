//
//  MovieModel.swift
//  NetworkClient
//
//  Created by Abhiney Natarajan on 9/6/19.
//  Copyright © 2019 Abhiney Natarajan. All rights reserved.
//

import Foundation

class MovieModel {

    func fetchMovies() {
        MovieService().fetchMovies(from: .nowPlaying) { [weak self] result in
            switch result {
            case .success(let response):
                print(response.results)
            case .failure(let error):
                print(error)
            }

        }
    }
}
