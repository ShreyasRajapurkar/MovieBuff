//
//  MovieCell.swift
//  MovieBuff
//
//  Created by Shreyas Rajapurkar on 23/09/23.
//

import UIKit
import Foundation

protocol FavoriteButtonProtocol: NSObject {
    func favoriteButtonTapped(id: Int)
}

final class MovieCell: UICollectionViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let playlistsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let favoriteButtonIcon: UIImageView = {
        let image = UIImage(systemName: "heart.fill")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    weak var favoriteButtonDelegate: FavoriteButtonProtocol?
    private var viewModel: MovieCellViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setupViews()
        setupConstraints()
        setupLayout()
        setupInteractions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(playlistsLabel)
        contentView.addSubview(favoriteButtonIcon)
    }

    private func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor))
        constraints.append(imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor))
        constraints.append(imageView.topAnchor.constraint(equalTo: contentView.topAnchor))
        constraints.append(imageView.heightAnchor.constraint(equalToConstant: 100))

        constraints.append(titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor))
        constraints.append(titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor))
        
        constraints.append(ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor))
        constraints.append(ratingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor))
        
        constraints.append(playlistsLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor))
        constraints.append(playlistsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor))

        constraints.append(favoriteButtonIcon.topAnchor.constraint(equalTo: imageView.bottomAnchor))
        constraints.append(favoriteButtonIcon.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 50))

        NSLayoutConstraint.activate(constraints)
    }

    private func setupLayout() {
        contentView.backgroundColor = UIColor.gray
    }
    
    private func setupInteractions() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(favoriteButtonTapped))
        favoriteButtonIcon.isUserInteractionEnabled = true
        favoriteButtonIcon.addGestureRecognizer(tapGestureRecognizer)
    }

    func setup(_ viewModel: MovieCellViewModel) {
        titleLabel.text = viewModel.title
        ratingLabel.text = viewModel.rating
        let urlString = GlobalConstants.movieImageBaseURL + viewModel.thumbnailURL
        imageView.loadImageFromURL(urlString: urlString)
        self.viewModel = viewModel
    }

    @objc
    func favoriteButtonTapped() {
        if let viewModel = viewModel {
            favoriteButtonDelegate?.favoriteButtonTapped(id: viewModel.id)
        } else {
            assert(true, "View model should not be nil here")
        }
    }
}
