//
//  SelectPlaylistBottomSheetView.swift
//  MovieBuff
//
//  Created by Shreyas Rajapurkar on 23/09/23.
//

import UIKit
import Foundation

protocol SelectPlaylist {
    func didSelectPlaylist(_ playlist: Playlist)
}

class SelectPlaylistBottomSheetView: UIView {
    // TODO: Use table view if no. of playlists is expected to be high, using stack view for now due to time constraint
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8.0
        return stackView
    }()

    let playlists: [Playlist]

    init(playlists: [Playlist]) {
        self.playlists = playlists
        super.init(frame: CGRect.zero)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        self.addSubview(stackView)
        
        for playlist in playlists {
            let label = UILabel()
            label.text = playlist.name
        }
    }

    private func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor))
        constraints.append(stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor))
        constraints.append(stackView.topAnchor.constraint(equalTo: self.topAnchor))
        constraints.append(stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor))
    }
}
