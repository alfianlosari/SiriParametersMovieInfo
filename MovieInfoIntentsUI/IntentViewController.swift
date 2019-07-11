//
//  IntentViewController.swift
//  MovieInfoIntentsUI
//
//  Created by Alfian Losari on 11/07/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import IntentsUI
import MovieKit
class IntentViewController: UIViewController, INUIHostedViewControlling {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    // MARK: - INUIHostedViewControlling
    
    // Prepare your view controller for the interaction to handle.
    func configureView(for parameters: Set<INParameter>, of interaction: INInteraction, interactiveBehavior: INUIInteractiveBehavior, context: INUIHostedViewContext, completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {

        let _movie: MovieResult
        if let response = interaction.intentResponse as? ShowMovieIntentResponse, let movie = response.movie {
            _movie = movie
        } else if let reponse = interaction.intentResponse as? SearchMovieIntentResponse, let movie = reponse.movie {
            _movie = movie
        } else {
            completion(false, parameters, .zero)
            return
        }
        
        let vc = MovieDetailViewController(movie: _movie)
        
        attachChild(vc)
        completion(true, parameters, desiredSize)

    }
    
    private var desiredSize: CGSize {
        let width = self.extensionContext?.hostedViewMaximumAllowedSize.width ?? 320
        return CGSize(width: width, height: 640)
    }
    
    private func attachChild(_ viewController: UIViewController) {
        addChild(viewController)
        
        if let subview = viewController.view {
            view.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
            
            // Set the child controller's view to be the exact same size as the parent controller's view.
            subview.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            subview.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
            
            subview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            subview.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
        
        viewController.didMove(toParent: self)
    }
}
