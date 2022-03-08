//
//  ListMovieTableViewCell.swift
//  HomeFeature
//
//  Created by MEKARI on 08/03/22.
//

import UIKit

protocol TableViewCellProtocol: AnyObject {
    static var identifier: String { get }
    static func nib() -> UINib
}

class ListMovieTableViewCell: UITableViewCell, TableViewCellProtocol {
    
    static var identifier: String = "ListMovieTableViewCell"
    static func nib() -> UINib {
        .init(nibName: identifier, bundle: Bundle(for: ListMovieTableViewCell.self))
    }
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.layer.cornerRadius = 8.0
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
    }
    
    func configure(posterUrl: String,
                   movieTitle: String,
                   movieLanguage: String,
                   movieDate: String) {
        let imageURL = "https://image.tmdb.org/t/p/w500"
        if let posterUrl = URL(string: imageURL + posterUrl) {
            posterImageView.load(from: posterUrl)
        }
        
        titleLabel.text = movieTitle
        languageLabel.text = movieLanguage
        dateLabel.text = movieDate
    }
    
}

extension UIImageView {
    func load(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
