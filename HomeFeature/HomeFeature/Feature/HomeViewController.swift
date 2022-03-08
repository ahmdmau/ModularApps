//
//  HomeViewController.swift
//  HomeFeature
//
//  Created by MEKARI on 08/03/22.
//

import UIKit
import Networking

public class HomeViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel = HomeViewModel(services: HomeServices())
    @IBOutlet weak var tableView: UITableView!
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "HomeViewController", bundle: Bundle(for: HomeViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewModel()
    }

}

extension HomeViewController {
    
    private func setupViewModel() {
        viewModel.delegate = self
        viewModel.getTopRatedMovies()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListMovieTableViewCell.nib(), forCellReuseIdentifier: ListMovieTableViewCell.identifier)
    }
    
}

extension HomeViewController: HomeViewModelProtocol {
    
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieResults.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListMovieTableViewCell.identifier, for: indexPath) as? ListMovieTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = viewModel.movieResults[indexPath.row]
        cell.configure(posterUrl: movie.posterPath ?? "",
                       movieTitle: movie.title ?? "-",
                       movieLanguage: movie.originalLanguage ?? "-",
                       movieDate: movie.releaseDate ?? "-")
        cell.selectionStyle = .none
        return cell
        
    }
    
}
