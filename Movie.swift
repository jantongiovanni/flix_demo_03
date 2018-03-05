//
//  Movie.swift
//  
//
//  Created by Joe Antongiovanni on 3/4/18.
//
//

import Foundation

class Movie {
    var title: String
    var posterUrl: URL?
    var overview: String
    var posterURL: URL?
    //var backdropURL: URL?
    //var baseURLString: String
    var releaseDate: String
    
    init(dictionary: [String: Any]) {
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        title = dictionary["title"] as? String ?? "No title"
        overview = dictionary["overview"] as? String ?? "No overview"
        releaseDate = dictionary["release_date"] as? String ?? "No Release"

        let posterPathString = dictionary["poster_path"] as! String

        
        posterURL = URL(string: baseURLString + posterPathString)!
        
    }
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }

}

//        let title = movie["title"] as! String
//        let overview = movie["overview"] as! String
//        cell.titleLabel.text = title
//        cell.overviewLabel.text = overview
//
//        let posterPathString = movie["poster_path"] as! String
//        let baseURLString = "https://image.tmdb.org/t/p/w500"
//        let posterURL = URL(string: baseURLString + posterPathString)!
//        cell.posterImageView.af_setImage(withURL:posterURL)
