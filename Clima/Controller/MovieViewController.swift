//
//  ViewController.swift
//
//  Created by Anton Jagers
//  Copyright © 2020 MovieViewer. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController  {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var movieManager = MovieManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        movieManager.delegate = self
        searchTextField.delegate = self
    }

}

//MARK: - UITextFieldDelegate

extension MovieViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let movie = searchTextField.text {
            movieManager.fetchMovie(original_title: movie)
        }
        
        searchTextField.text = ""
        
    }
}

//MARK: - MovieManagerDelegate


extension MovieViewController: MovieManagerDelegate {
    
    func didUpdateMovie(_ movieManager: MovieManager, movie: MovieModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = movie.vote_averageString
            self.cityLabel.text = movie.original_title
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}


