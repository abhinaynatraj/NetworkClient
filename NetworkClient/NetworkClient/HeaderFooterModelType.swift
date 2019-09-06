//
//  HeaderFooterModelType.swift
//  NetworkClient
//
//  Created by Abhiney Natarajan on 9/6/19.
//  Copyright © 2019 Abhiney Natarajan. All rights reserved.
//

import Foundation
import UIKit

protocol HeaderFooterModelType {
    // header/footer Height
    var height: CGFloat { get }
    // Title
    var title: String? { get }
    // background color
    var backgroundColor: UIColor? { get }
    // Reuse Id of the cell view / template
    var reuseIdentifier: String { get }
    // Unique Id of the cell model
    var identifier: String { get }
}

// Default values
extension HeaderFooterModelType {
    var height: CGFloat {
        return UITableView.automaticDimension
    }
    var identifier: String {
        return ""
    }

    var title: String? {
        return nil
    }

    var backgroundColor: UIColor? {
        return nil
    }
}
