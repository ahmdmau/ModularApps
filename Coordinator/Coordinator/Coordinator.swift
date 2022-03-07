//
//  Coordinator.swift
//  Coordinator
//
//  Created by Ahmad Maulana on 07/03/22.
//

import UIKit

public protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
