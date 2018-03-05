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
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        
        // Set the rest of the properties
    }


}
