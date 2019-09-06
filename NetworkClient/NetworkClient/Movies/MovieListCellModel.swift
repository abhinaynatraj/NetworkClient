//
//  MovieListCellModel.swift
//  NetworkClient
//
//  Created by Abhiney Natarajan on 9/6/19.
//  Copyright © 2019 Abhiney Natarajan. All rights reserved.
//

import Foundation
import UIKit

struct MovieListCellModel: CellModelType {

    let reuseIdentifier: String = String(describing: MoviesListCell.self)
    var identifier: String
    var title: String?
    var didSelectRowAction: CellModelType.RowSelection?
}
