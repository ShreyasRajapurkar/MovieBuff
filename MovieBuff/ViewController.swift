//
//  ViewController.swift
//  MovieBuff
//
//  Created by Shreyas Rajapurkar on 23/09/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let vc = MovieListViewController(viewModel: MovieListViewModel())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

