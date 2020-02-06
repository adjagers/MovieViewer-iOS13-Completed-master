//
//  MovieManager.swift
//  Clima
//
//  Created by Henk Jagers on 05/02/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import UIKit

protocol MovieManagerDelegate {
    func didUpdateMovie(_ movieManager: MovieManager, movie: MovieModel)
    func didFailWithError(error: Error)
}

struct MovieManager {
    let movieURL = "https://api.themoviedb.org/3/search/movie?api_key=45da515f7caf83710b95d27db48fb128&page=1"
    
    var delegate: MovieManagerDelegate?
    
    func fetchMovie(original_title: String) {
        let urlString = "\(movieURL)&query=\(original_title)"
        performRequest(with: urlString)
    }
    
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let movie = self.parseJSON(safeData) {
                        self.delegate?.didUpdateMovie(self, movie: movie)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ movieData: Data) -> MovieModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MovieData.self, from: movieData)
            let name = decodedData.results[0].original_title
            let movieId = decodedData.results[0].id
            let vote = decodedData.results[0].vote_average
            let description = decodedData.results[0].overview
            
            let movie = MovieModel(original_title: name, id: movieId,  overview: description, vote_average: vote)
            return movie
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
}



