//
//  MovieListViewController.swift
//  MovieBuff
//
//  Created by Shreyas Rajapurkar on 23/09/23.
//

import UIKit
import Foundation

final class MovieListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, FavoriteButtonProtocol {
    // MARK: - Properties

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        // TODO: Remove hardcoded height and use dynamic height
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 200)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: Constants.cellReuseIdentifier)
        return collectionView
    }()

    let viewModel: MovieListViewModelProtocol
    var cellViewModels: [MovieCellViewModel]? = [MovieCellViewModel]() {
        didSet {
            collectionView.reloadData()
        }
    }

    // MARK: - Init
    
    init(viewModel: MovieListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self

        setupSubviews()
        setupConstraints()

        viewModel.fetchMoviesList { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let cellViewModels):
                    self.cellViewModels = cellViewModels
                case .failure(let error):
                    // TODO: Handle error - show empty state with some text
                    break
            }
        }
    }

    private func setupSubviews() {
        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(collectionView.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor))

        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellReuseIdentifier, for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }

        if let cellViewModel = cellViewModels?[indexPath.row] {
            cell.setup(cellViewModel)
            cell.favoriteButtonDelegate = self
        }

        return cell
    }

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels?.count ?? 0
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // MARK: - FavoriteButtonProtocol

    func favoriteButtonTapped(id: Int) {
        // TODO: Not making a proper bottom sheet due to time constraint. Ideally there should exist a BottomSheetViewController in which a UIView can be injected.
        let bottomSheetViewController = UIViewController()
        let playlists = viewModel.fetchPlaylistsFromCache()
        bottomSheetViewController.view.addSubview(SelectPlaylistBottomSheetView(playlists: playlists))
        present(bottomSheetViewController, animated: true)
    }

    // MARK: - Constants

    private enum Constants {
        static let cellReuseIdentifier = "MovieCell"
    }
}
