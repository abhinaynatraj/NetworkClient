//
//  MoviesViewModel.swift
//  NetworkClient
//
//  Created by Abhiney Natarajan on 9/6/19.
//  Copyright © 2019 Abhiney Natarajan. All rights reserved.
//

import Foundation

protocol MoviesViewModelType {
    var inputs: MoviesViewModelTypeInput { get }
    var outputs: MoviesViewModelTypeOutput { get }
}

protocol MoviesViewModelTypeInput {
    func viewReady()
    func didSelectItem(at indexPath: IndexPath)
}

protocol MoviesViewModelTypeOutput {
    var reloadTable: Observable<TableReload> { get }
    var sections: [SectionModel] { get }
}

class MoviesViewModel: MoviesViewModelType, MoviesViewModelTypeOutput {
    var inputs: MoviesViewModelTypeInput { return self }
    var outputs: MoviesViewModelTypeOutput { return self }

    var reloadTable: Observable<TableReload> = Observable(.all)
    var sections: [SectionModel] = []
    private let dataModel: MovieModel

    init(dataModel: MovieModel = MovieModel()) {
        self.dataModel = dataModel
    }
}

// MARK: Quote Services
fileprivate extension MoviesViewModel {

    func loadMovies() {
        MovieService().fetchMovies(from: .nowPlaying) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleSuccess(response: response)
                print(response.results)
            case .failure(let error):
                print(error)
            }

        }
    }

    private func handleSuccess(response: MoviesResponse) {
        var titleRows: [CellModelType] = []

        for movie in response.results {
            let titleRow = MovieListCellModel(identifier: "MovieListRowIdentifier", title: movie.title, didSelectRowAction: nil)
            titleRows.append(titleRow)
        }
        let section = SectionModel(rows: titleRows, identifier: "MovieListSectionIdentifier")
        sections.append(section)
        reloadTable.value = .all
    }
}

extension MoviesViewModel: MoviesViewModelTypeInput {

    func viewReady() {
        loadMovies()
    }

    func didSelectItem(at indexPath: IndexPath) {
        let cellModel = sections[indexPath.section].rows[indexPath.row]
        cellModel.didSelectRowAction?(indexPath)
    }
}

