//
//  HomeViewController.swift
//  HomeFeature
//
//  Created by MEKARI on 07/03/22.
//

import UIKit
import Networking

public protocol HomeCoordinatorDelegate: AnyObject {
    func routeToDetail(with movieId: Int, title: String)
}

public class HomeViewController: UIViewController {
    
    // MARK: - Properties
    public weak var delegate: HomeCoordinatorDelegate?
    let viewModel = HomeViewModel(services: HomeServices())
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Initialization
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "HomeViewController", bundle: Bundle(for: HomeViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.delegate = self
        viewModel.getTopRatedMovies()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListMovieTableViewCell.nib(), forCellReuseIdentifier: ListMovieTableViewCell.identifier)
    }
    
}

// MARK: - Table View
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieResults.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListMovieTableViewCell.identifier, for: indexPath) as? ListMovieTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.configure(with: viewModel.movieResults[indexPath.row].title ?? "-")
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieId = viewModel.movieResults[indexPath.row].id,
                let movieTitle = viewModel.movieResults[indexPath.row].title
        else { return }
        delegate?.routeToDetail(with: movieId, title: movieTitle)
    }
    
}

// MARK: - Home View Model Delegate
extension HomeViewController: HomeViewModelProtocol {
    
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
}
