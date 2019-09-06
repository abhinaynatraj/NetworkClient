//
//  TableReload.swift
//  NetworkClient
//
//  Created by Abhiney Natarajan on 9/6/19.
//  Copyright © 2019 Abhiney Natarajan. All rights reserved.
//

import Foundation
import UIKit

/// Table Reload Operations
enum TableReload {

    // Table Editing Operations
    enum Change {
        case insert([IndexPath], UITableView.RowAnimation)
        case insertSections(IndexSet, UITableView.RowAnimation)
        case delete([IndexPath], UITableView.RowAnimation)
        case deleteSections(IndexSet, UITableView.RowAnimation)
        case move(IndexPath, IndexPath)
        case moveSection(Int, Int)
    }

    case sections(IndexSet, UITableView.RowAnimation)
    case rows([IndexPath], UITableView.RowAnimation)
    case all
    case changes([Change])
}

extension UITableView {

    func reload(change: TableReload) {
        switch change {
        case .all:
            self.reloadData()
        case let .rows(indexPaths, animation):
            if #available(iOS 11, *) {
                self.reloadRows(at: indexPaths, with: animation)
            } else {
                // To fix reload crash issue below 10.3
                self.reloadData()
            }
        case let .sections(indexSet, animation):
            if #available(iOS 11, *) {
                self.reloadSections(indexSet, with: animation)
            } else {
                // To fix reload crash issue below 10.3
                self.reloadData()
            }
        case let .changes(changes):
            let updateBlock: () -> Void = {
                for change in changes {
                    switch change {
                    case let .insert(indexPaths, animation):
                        self.insertRows(at: indexPaths, with: animation)
                    case let .insertSections(indexSet, animation):
                        self.insertSections(indexSet, with: animation)
                    case let .delete(indexPaths, animation):
                        self.deleteRows(at: indexPaths, with: animation)
                    case let .deleteSections(indexSet, animation):
                        self.deleteSections(indexSet, with: animation)
                    case let .move(atIndexPath, toIndexPath):
                        self.moveRow(at: atIndexPath, to: toIndexPath)
                    case let .moveSection(from, to):
                        self.moveSection(from, toSection: to)
                    }
                }
            }
            if #available(iOS 11, *) {
                self.performBatchUpdates(updateBlock, completion: nil)
            } else {
                self.beginUpdates()
                updateBlock()
                self.endUpdates()
            }
        }
    }

}
