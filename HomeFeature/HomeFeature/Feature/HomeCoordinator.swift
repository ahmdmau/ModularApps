//
//  HomeCoordinator.swift
//  HomeFeature
//
//  Created by MEKARI on 08/03/22.
//

import UIKit
import Coordinator

public class HomeCoordinator: Coordinator {
    
    public var childCoordinators = [Coordinator]()
    public var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let homeViewController = HomeViewController()
        homeViewController.title = "List Movie"
        self.navigationController.pushViewController(homeViewController, animated: true)
    }

}
