//
//  HomeViewModel.swift
//  HomeFeature
//
//  Created by MEKARI on 08/03/22.
//

import Foundation
import Networking

protocol HomeViewModelProtocol: AnyObject {
    func reloadTableView()
}

class HomeViewModel {
    private var services: HomeServiceable
    weak var delegate: HomeViewModelProtocol?
    var movieResults: [MovieResults] = []
    
    init(services: HomeServiceable) {
        self.services = services
    }
    
    func getTopRatedMovies() {
        Task(priority: .background) { [weak self] in
            let result = try await services.getTopRated()
            switch result {
            case .success(let movieResponse):
                self?.movieResults = movieResponse.results ?? []
                self?.delegate?.reloadTableView()
                break
            case .failure(_):
                break
            }
        }
    }
    
}
