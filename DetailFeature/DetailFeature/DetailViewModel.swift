//
//  DetailViewModel.swift
//  DetailFeature
//
//  Created by MEKARI on 07/03/22.
//

import Foundation
import Networking
import UIKit

protocol DetailViewModelProtocol: AnyObject {
    func reloadTableView()
}

class DetailViewModel {
    
    weak var delegate: DetailViewModelProtocol?
    private var services: HomeServiceable
    var movieId: Int?
    var movieResult: MovieResults?
    
    init(services: HomeServiceable) {
        self.services = services
    }
    
    func getMovieDetail() {
        guard let movieId = movieId else {
            return
        }

        Task(priority: .background) {
            let result = try await services.getMovieDetail(with: movieId)
            switch result {
            case .success(let movieResult):
                self.movieResult = movieResult
                delegate?.reloadTableView()
            case .failure(let error):
                print("AM debug", error)
            }
        }
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
