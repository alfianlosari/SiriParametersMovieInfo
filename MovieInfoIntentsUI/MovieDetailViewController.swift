//
//  MovieDetailViewController.swift
//  TrendingMovies
//
//  Created by Alfian Losari on 11/25/18.
//  Copyright © 2018 Alfian Losari. All rights reserved.
//

import UIKit
import MovieKit

class MovieDetailViewController: UITableViewController {
    
    var movie: MovieResult? {
        didSet {
            title = movie?.displayString
        }
    }
    
    init(movie: MovieResult) {
        self.movie = movie
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    private func setupTableView() {
        navigationController?.navigationBar.prefersLargeTitles = false
        tableView.tableFooterView = UIView()
        tableView.register(MovieBackdropTableViewCell.nib, forCellReuseIdentifier: "BackdropCell")
        tableView.register(MovieDetailTableViewCell.nib, forCellReuseIdentifier: "DetailCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.reloadData()
    }

    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            let cell = tableView.dequeueReusableCell(withIdentifier: "BackdropCell", for: indexPath) as! MovieBackdropTableViewCell
            cell.imageURL = movie?.backdropURL
            return cell
            
        case (0, 1):
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! MovieDetailTableViewCell
            cell.movie = movie
            return cell
            
        default:
            fatalError()
        }
        
       
    }

    
}
