//
//  ListMovieTableViewCell.swift
//  HomeFeature
//
//  Created by MEKARI on 07/03/22.
//

import UIKit

protocol TableViewCellProtocol: AnyObject {
    static var identifier: String { get }
    static func nib() -> UINib
}

class ListMovieTableViewCell: UITableViewCell, TableViewCellProtocol {
    
    static var identifier: String = "ListMovieTableViewCell"
    static func nib() -> UINib {
        return .init(nibName: identifier, bundle: Bundle(for: ListMovieTableViewCell.self))
    }

    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with title: String) {
        titleLabel.text = title
    }
    
}
