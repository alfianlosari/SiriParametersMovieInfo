//
//  AppDelegate.swift
//  MovieInfo
//
//  Created by Alfian Losari on 10/03/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import UIKit
import MovieKit
import Intents

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let showMovieIntent = ShowMovieIntent()
        showMovieIntent.filterType = .nowPlaying
        let showMovieIntentShortcut = INShortcut(intent: showMovieIntent)!
        
        let searchMovieIntent = SearchMovieIntent()
        searchMovieIntent.title = " "
        let searchMovieIntentShortcut = INShortcut(intent: searchMovieIntent)!
        
        INVoiceShortcutCenter.shared.setShortcutSuggestions([showMovieIntentShortcut, searchMovieIntentShortcut])

        return true
    }

}

