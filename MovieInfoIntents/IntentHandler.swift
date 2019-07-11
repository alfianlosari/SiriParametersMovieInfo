//
//  IntentHandler.swift
//  MovieInfoIntents
//
//  Created by Alfian Losari on 11/07/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import Intents
import MovieKit

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        if intent is ShowMovieIntent {
            return ShowMovieIntentHandler()
        } else if intent is SearchMovieIntent {
            return SearchMovieIntentHandler()
        }
        fatalError()
    }
}
