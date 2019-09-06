//
//  MoviesViewModel.swift
//  NetworkClient
//
//  Created by Abhiney Natarajan on 9/6/19.
//  Copyright © 2019 Abhiney Natarajan. All rights reserved.
//

import Foundation

protocol RedditListViewModelType {
    var inputs: RedditListViewModelTypeInput { get }
    var outputs: RedditListViewModelTypeOutput { get }
}

protocol RedditListViewModelTypeInput {
    func viewReady()
    func didSelectItem(at indexPath: IndexPath)
}

protocol RedditListViewModelTypeOutput {
    var reloadTable: Observable<TableReload> { get }
    var sections: [SectionModel] { get }
}

class RedditListViewModel: RedditListViewModelType, RedditListViewModelTypeOutput {
    var inputs: RedditListViewModelTypeInput { return self }
    var outputs: RedditListViewModelTypeOutput { return self }

    var reloadTable: Observable<TableReload> = Observable(.all)
    var sections: [SectionModel] = []
}

// MARK: Quote Services
fileprivate extension RedditListViewModel {

    func loadData() {
        RedditService().fetchData { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleSuccess(response: response)
            case .failure(let error):
                print(error)
            }

        }
    }

    private func handleSuccess(response: RedditListResponse) {
        var titleRows: [CellModelType] = []

        for child in response.data.children {
            let imageUrl = child.data.thumbnail != "self" ? child.data.thumbnail : nil
            let titleRow = RedditListCellModel(identifier: "RedditListRowIdentifier", title: child.data.title, imageUrl: imageUrl, postedBy: child.data.author, description: child.data.selftext, didSelectRowAction: nil)
            titleRows.append(titleRow)
        }
        let section = SectionModel(rows: titleRows, identifier: "RedditListSectionIdentifier")
        sections.append(section)
        reloadTable.value = .all
    }
}

extension RedditListViewModel: RedditListViewModelTypeInput {

    func viewReady() {
        loadData()
    }

    func didSelectItem(at indexPath: IndexPath) {
        let cellModel = sections[indexPath.section].rows[indexPath.row]
        cellModel.didSelectRowAction?(indexPath)
    }
}

