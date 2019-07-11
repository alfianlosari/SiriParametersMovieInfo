//
//  MovieDetailTableViewCell.swift
//  MovieKit
//
//  Created by Alfian Losari on 11/25/18.
//  Copyright © 2018 Alfian Losari. All rights reserved.
//

import UIKit
import MovieKit

public class MovieDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var adultLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var crewLabel: UILabel!
    
    public static var nib: UINib {
        return UINib(nibName: "MovieDetailTableViewCell", bundle: Bundle(for: MovieDetailTableViewCell.self))
    }
    
    public static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        return dateFormatter
    }()
    
    public var movie: MovieResult? {
        didSet {
            guard let movie = movie else {
                return
            }
            
            taglineLabel.text = movie.tagline
            overviewLabel.text = movie.overview
            yearLabel.text = movie.releaseDate
            if movie.voteCount == 0 {
                ratingLabel.isHidden = true
            } else {
                ratingLabel.isHidden = false
                
                
                ratingLabel.text = "\(Int(movie.voteAverage?.doubleValue ?? 0) * 10)%"

            }
            
            durationLabel.text = "\(movie.runtime ?? 0) mins"

            
            
        }
    }
  
}
