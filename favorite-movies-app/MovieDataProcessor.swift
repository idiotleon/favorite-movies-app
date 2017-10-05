//
//  MovieDataProcessor.swift
//  favorite-movies-app
//
//  Created by Yang Lu on 10/5/17.
//  Copyright © 2017 Leon. All rights reserved.
//

import Foundation

class MovieDataProcessor{
    static func mapJsonToMovies(object: [String: AnyObject], moviesKey: String) -> [Movie]{
        print("mapJsonToMovies(), MovieDataProcessor got called")
        print(object)
        var mappedMovies: [Movie] = []
        print("mappedMovies.count, newly created: " +  String(mappedMovies.count))
        
        guard let movies = object[moviesKey] as? [[String: AnyObject]] else{
            print("mappedMovies was returned in guard")
            return mappedMovies
        }
        
        print("movies.count, before parsing: " +  String(movies.count))
        print("mappedMovies.count, before parsing: " +  String(mappedMovies.count))
        for movie in movies{
            guard let id = movie["imdb_id"] as? String,
                let title = movie["title"] as? String,
                let releaseDate = movie["release_date"] as? String,
                let imageUrl = movie["poster_path"] as? String else{ continue }
            
            print("imdb_id: " + id)
            print("title: " + title)
            print("release_date: " + releaseDate)
            print("imageUrl: " + imageUrl)
            
            let movieClass = Movie(id:id, title:title, year: releaseDate, imageUrl:imageUrl)
            mappedMovies.append(movieClass)
        }
        
        return mappedMovies
    }
    
    static func write(movies:[Movie]){
        // todo: implement
        
    }
}
