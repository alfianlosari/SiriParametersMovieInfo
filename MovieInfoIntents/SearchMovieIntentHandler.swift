//
//  SearchMovieIntentHandler.swift
//  MovieInfoIntents
//
//  Created by Alfian Losari on 12/07/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import Intents
import MovieKit

class SearchMovieIntentHandler: NSObject, SearchMovieIntentHandling {

    func handle(intent: SearchMovieIntent, completion: @escaping (SearchMovieIntentResponse) -> Void) {
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
    
    func resolveTitle(for intent: SearchMovieIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        guard let title = intent.title?.trimmingCharacters(in: .whitespacesAndNewlines), !title.isEmpty else {
            completion(.needsValue())
            return
        }
        completion(.success(with: title))
    }
    
    func resolveMovie(for intent: SearchMovieIntent, with completion: @escaping (MovieResultResolutionResult) -> Void) {
        guard let movie = intent.movie else {
            completion(.needsValue())
            return
        }
        completion(MovieResultResolutionResult.confirmationRequired(with: movie))
    }
    
    func provideMovieOptions(for intent: SearchMovieIntent, with completion: @escaping ([MovieResult]?, Error?) -> Void) {
        guard let title = intent.title, !title.isEmpty else {
            completion(nil, nil)
            return
        }
        
        MovieStore.shared.searchMovie(query: title, params: nil, successHandler: { (movieResponse) in
            let movies = Array(movieResponse.results.prefix(upTo: 5)).map {
                MovieResult(identifier: "\($0.id)", display: $0.title)
            }
            completion(movies, nil)
        }) { (error) in
            completion(nil, error)
        }
    }
    
}
