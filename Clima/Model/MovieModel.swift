//
//  MovieModel.swift
//  Clima
//
//  Created by Henk Jagers on 05/02/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct MovieModel: Codable {
    let original_title: String
    let id: Int
    let overview: String
    let vote_average: Double
    
    var vote_averageString: String {
        return String(vote_average)
    }
    
}
