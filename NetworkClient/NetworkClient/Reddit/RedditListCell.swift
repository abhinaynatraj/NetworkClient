//
//  MoviesListCell.swift
//  NetworkClient
//
//  Created by Abhiney Natarajan on 9/6/19.
//  Copyright © 2019 Abhiney Natarajan. All rights reserved.
//

import Foundation
import UIKit

class RedditListCell: UITableViewCell {
    @IBOutlet weak var horizontalStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
            titleLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var postedByLabel: UILabel! {
        didSet {
            postedByLabel.font = UIFont.systemFont(ofSize: 14)
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = UIFont.systemFont(ofSize: 15)
            descriptionLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var postImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension RedditListCell: CellView {
    func configure(cellModel: CellModelType, indexPath: IndexPath) {
        guard let model = cellModel as? RedditListCellModel else {
            return
        }
        titleLabel.text = model.title
        if let postedBy = model.postedBy {
            postedByLabel.text = "Posted by: \(postedBy)"
        }
        descriptionLabel.text = model.description
        horizontalStackView.removeArrangedSubview(postImageView)
        if let postImageUrl = model.imageUrl {
            postImageView.setImage(from: postImageUrl)
            postImageView.isHidden = false
        } else {
            postImageView.isHidden = true
        }
    }
}
