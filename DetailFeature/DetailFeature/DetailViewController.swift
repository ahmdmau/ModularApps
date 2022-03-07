//
//  DetailViewController.swift
//  DetailFeature
//
//  Created by Ahmad Maulana on 07/03/22.
//

import UIKit
import Networking

public class DetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = DetailViewModel(services: HomeServices())
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "DetailViewController", bundle: Bundle(for: DetailViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(movieId: Int, movieTitle: String) {
        self.init()
        viewModel.delegate = self
        viewModel.movieId = movieId
        self.title = movieTitle
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getMovieDetail()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieDetailTableViewCell.nib(), forCellReuseIdentifier: MovieDetailTableViewCell.identifier)
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailTableViewCell.identifier, for: indexPath) as? MovieDetailTableViewCell else { return UITableViewCell() }
        cell.configure(backdropURL: viewModel.movieResult?.backdropPath ?? "",
                       title: viewModel.movieResult?.title ?? "-",
                       overview: viewModel.movieResult?.overview ?? "-")
        cell.selectionStyle = .none
        return cell
    }
    
}

extension DetailViewController: DetailViewModelProtocol {
    
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

}
