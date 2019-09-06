//
//  CellView.swift
//  NetworkClient
//
//  Created by Abhiney Natarajan on 9/6/19.
//  Copyright © 2019 Abhiney Natarajan. All rights reserved.
//

import Foundation

protocol CellView {

    /// To configure a tableViewCell with model as CellModelType and IndexPath
    ///
    /// - Parameters:
    ///   - cellModel: a model to confirm with CellModelType
    ///   - indexPath: a IndexPath of the cell
    func configure(cellModel: CellModelType, indexPath: IndexPath)

}
