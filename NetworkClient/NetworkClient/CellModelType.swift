//
//  CellModelType.swift
//  NetworkClient
//
//  Created by Abhiney Natarajan on 9/6/19.
//  Copyright © 2019 Abhiney Natarajan. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

protocol CellModelType {
    typealias RowSelection = (IndexPath) -> Void

    // Cell row Height
    var height: CGFloat { get }
    // Cell borders
    var borders: UIRectEdge { get set }
    // Reuse Id of the cell view / template
    var reuseIdentifier: String { get }
    // Unique Id of the cell model for accessibility or identifying models
    var identifier: String { get }
    // Cell row selection handler
    var didSelectRowAction: RowSelection? { get }
}

// Default values
extension CellModelType {
    var height: CGFloat {
        return UITableView.automaticDimension
    }
    var borders: UIRectEdge {
        set {
            // Protocol cannot store value, implement it when needed
        }
        get {
            return []
        }
    }
    var didSelectRowAction: RowSelection? {
        return nil
    }
    var identifier: String {
        return ""
    }
}
