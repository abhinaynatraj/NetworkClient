//
//  MoviesListCell.swift
//  NetworkClient
//
//  Created by Abhiney Natarajan on 9/6/19.
//  Copyright © 2019 Abhiney Natarajan. All rights reserved.
//

import Foundation
import UIKit

class MoviesListCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!

}

extension MoviesListCell: CellView {
    func configure(cellModel: CellModelType, indexPath: IndexPath) {
        guard let model = cellModel as? MovieListCellModel else {
            return
        }
        titleLabel.text = model.title
    }
}
