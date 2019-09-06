//
//  RedditListCellModel.swift
//  NetworkClient
//
//  Created by Abhiney Natarajan on 9/6/19.
//  Copyright © 2019 Abhiney Natarajan. All rights reserved.
//

import Foundation
import UIKit

struct RedditListCellModel: CellModelType {

    let reuseIdentifier: String = String(describing: RedditListCell.self)
    var identifier: String
    var title: String?
    var imageUrl: String?
    var postedBy: String?
    var description: String?
    var didSelectRowAction: CellModelType.RowSelection?
}
