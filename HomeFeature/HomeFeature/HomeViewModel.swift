//
//  HomeViewModel.swift
//  HomeFeature
//
//  Created by MEKARI on 07/03/22.
//

import Foundation
import Networking

protocol HomeViewModelProtocol: AnyObject {
    func reloadTableView()
}

public class HomeViewModel {
    private var services: HomeServiceable
    weak var delegate: HomeViewModelProtocol?
    var movieResults: [MovieResults] = []
    
    init(services: HomeServiceable) {
        self.services = services
    }
    
    func getTopRatedMovies() {
        Task(priority: .background) { [weak self] in
            let result = try await self?.services.getTopRated()
            switch result {
            case .success(let movieResponse):
                self?.movieResults = movieResponse.results ?? []
                self?.delegate?.reloadTableView()
            case .failure(_):
                break
            case .none:
                break
            }
        }
    }
}
