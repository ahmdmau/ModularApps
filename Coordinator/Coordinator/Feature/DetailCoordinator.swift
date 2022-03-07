//
//  DetailCoordinator.swift
//  Coordinator
//
//  Created by Ahmad Maulana on 07/03/22.
//

import UIKit
import DetailFeature

public class DetailCoordinator: Coordinator {
    public var childCoordinators = [Coordinator]()
    public var navigationController: UINavigationController
    public var movieId: Int
    public var movieTitle: String
    
    public init(navigationController: UINavigationController, movieId: Int, movieTitle: String) {
        self.navigationController = navigationController
        self.movieId = movieId
        self.movieTitle = movieTitle
    }
    
    public func start() {
        let detailViewController = DetailViewController(movieId: movieId, movieTitle: movieTitle)
        self.navigationController.pushViewController(detailViewController, animated: true)
    }
    
}
