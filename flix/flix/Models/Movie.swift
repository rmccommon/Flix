//
//  Movie.swift
//  flix
//
//  Created by Sierra Klix on 10/13/18.
//  Copyright © 2018 Ryan McCommon. All rights reserved.
//

import Foundation

class Movie {
    var title: String
    var description: String
    var mainImageUrl : URL?
    var release: String
    var backgroundURL : URL?
    
    init(dictionary: [String:Any]){
        title = dictionary["title"] as? String ?? "None"
        description = dictionary["overview"] as? String ?? "None"
        release = dictionary["release_date"] as? String ?? "None"
        let base = "https://image.tmdb.org/t/p/w500"
        let imagePath = dictionary["poster_path"] as? String ?? "None"
        let backgroundImagePath = dictionary["backdrop_path"] as? String ?? "None"
        mainImageUrl = URL(string: base + imagePath)
        backgroundURL = URL(string: base + backgroundImagePath)
    }
    class func movies(dictionaries: [[String:Any]])->[Movie]{
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        return movies
    }
    
}


