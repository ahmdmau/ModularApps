//
//  MovieDetailTableViewCell.swift
//  DetailFeature
//
//  Created by MEKARI on 07/03/22.
//

import UIKit

protocol TableViewCellProtocol: AnyObject {
    static var identifier: String { get }
    static func nib() -> UINib
}

class MovieDetailTableViewCell: UITableViewCell, TableViewCellProtocol {
    
    static var identifier: String = "MovieDetailTableViewCell"
    static func nib() -> UINib {
        return .init(nibName: identifier, bundle: Bundle(for: MovieDetailTableViewCell.self))
    }

    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    func configure(backdropURL: String, title: String, overview: String) {
        let imageURL = "https://image.tmdb.org/t/p/w500"
        if let backdropURL = URL(string: imageURL + backdropURL) {
            posterImageView.load(from: backdropURL)
        }
        
        titleLabel.text = title
        overviewLabel.text = overview
    }
    
}
