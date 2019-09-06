//
//  SectionModel.swift
//  NetworkClient
//
//  Created by Abhiney Natarajan on 9/6/19.
//  Copyright © 2019 Abhiney Natarajan. All rights reserved.
//

import Foundation

class SectionModel {

    // Section header model
    let header: HeaderFooterModelType?

    // Cell Rows
    var rows: [CellModelType]

    // Section footer model
    let footer: HeaderFooterModelType?

    // section model identifier for Accesibility
    let identifier: String

    init(header: HeaderFooterModelType? = nil,
         rows: [CellModelType] = [CellModelType](),
         footer: HeaderFooterModelType? = nil,
         identifier: String = "") {
        self.header = header
        self.footer = footer
        self.identifier = identifier
        self.rows =  rows
    }

    /// To get row index by its identifier
    ///
    /// - Parameter identifier: a unique string as the row id
    /// - Returns: a index of row
    func rowIndex(for identifier: String) -> Int? {
        return rows.firstIndex(where: { $0.identifier == identifier })
    }

    /// To find a row by its identifier
    ///
    /// - Parameter identifier: a unique string as the row id
    /// - Returns: the row matched the identifier
    func row(for identifier: String) -> CellModelType? {
        return rows.first(where: { $0.identifier == identifier })
    }
}

extension Array where Element: SectionModel {
    /// Get a row IndexPath by its identifier
    ///
    /// - Parameter rowIdentifier: a unique string as the row id
    /// - Returns: a IndexPath of the row
    func indexPath(for rowIdentifier: String) -> IndexPath? {
        for (sectionIndex, section) in self.enumerated() {
            if let rowIndex = section.rowIndex(for: rowIdentifier) {
                return IndexPath(row: rowIndex, section: sectionIndex)
            }
        }
        return nil
    }

    /// Get a list row indexPaths by section identifier
    ///
    /// - Parameter sectionIdentifier: a unique string as the section id
    /// - Returns: a array of indexPath
    func indexPaths(for sectionIdentifier: String) -> [IndexPath] {
        var indexPaths = [IndexPath]()
        if let section = section(for: sectionIdentifier),
            let sectionIndex = sectionIndex(for: sectionIdentifier) {
            for (rowIndex, _) in section.rows.enumerated() {
                indexPaths.append(IndexPath(row: rowIndex, section: sectionIndex))
            }
        }
        return indexPaths
    }

    /// Get a section index by its identifier
    ///
    /// - Parameter sectionIdentifier: a unique string as the section id
    /// - Returns: a index of section
    func sectionIndex(for sectionIdentifier: String) -> Int? {
        return self.firstIndex(where: { $0.identifier == sectionIdentifier })
    }

    /// To find a section by its identifier
    ///
    /// - Parameter identifier: a unique string as the section id
    /// - Returns: the section matched the identifier
    func section(for identifier: String) -> SectionModel? {
        return self.first(where: { $0.identifier == identifier })
    }

    /// To find a row by its identifier
    ///
    /// - Parameter identifier: a unique string as the row id
    /// - Returns: the row matched the identifier
    func row(for identifier: String) -> CellModelType? {
        for section in self {
            if let row = section.row(for: identifier) {
                return row
            }
        }
        return nil
    }
}
