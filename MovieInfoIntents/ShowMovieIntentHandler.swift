//
//  ShowMovieIntentHandler.swift
//  MovieInfoIntents
//
//  Created by Alfian Losari on 12/07/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import Intents
import MovieKit

class ShowMovieIntentHandler: NSObject, ShowMovieIntentHandling {

    func resolveFilterType(for intent: ShowMovieIntent, with completion: @escaping (FilterTypeResolutionResult) -> Void) {
        if intent.filterType == .unknown {
            completion(.needsValue())
            return
        }
        completion(.success(with: intent.filterType))
    }
    
    func resolveMovie(for intent: ShowMovieIntent, with completion: @escaping (MovieResultResolutionResult) -> Void) {
        guard let movie = intent.movie else {
            completion(.needsValue())
            return
        }        
        completion(MovieResultResolutionResult.confirmationRequired(with: movie))
    }
    
    func provideMovieOptions(for intent: ShowMovieIntent, with completion: @escaping ([MovieResult]?, Error?) -> Void) {
        if intent.filterType == .unknown {
            completion(nil, nil)
            return
        }
        
        let endpoint: Endpoint
        switch intent.filterType {
        case .nowPlaying:
            endpoint = .nowPlaying
            
        case .popular:
            endpoint = .popular
            
        case .topRated:
            endpoint = .topRated
            
        case .upcoming:
            endpoint = .upcoming
            
        case .unknown:
            completion(nil, nil)
            return
        }
        
        MovieStore.shared.fetchMovies(from: endpoint, successHandler: { (response) in
            let movies = Array(response.results.prefix(upTo: 5)).map {
                MovieResult(identifier: "\($0.id)", display: $0.title)
            }
            
            completion(movies, nil)
        }) { (error) in
            completion(nil, error)
        }
    }

    
    func handle(intent: ShowMovieIntent, completion: @escaping (ShowMovieIntentResponse) -> Void) {
        guard let movie = intent.movie, let _id = movie.identifier, let id = Int(_id) else {
            completion(.init(code: .failure, userActivity: nil))
            return
        }

        MovieStore.shared.fetchMovie(id: id, successHandler: { (movieResult) in
            movie.backdropURL = movieResult.backdropURL
            movie.posterURL = movieResult.posterURL
            movie.releaseDate = movieResult.releaseDateText
            movie.overview = movieResult.overview
            movie.runtime = NSNumber(value: movieResult.runtime ?? 0)
            movie.voteAverage = NSNumber(value: movieResult.voteAverage)
            movie.voteCount = NSNumber(value: movieResult.voteCount)
            movie.tagline = movieResult.tagline
            
            completion(.success(movie: movie))
        }) { (error) in
            completion(.init(code: .failure, userActivity: nil))
        }
    }
   
}
