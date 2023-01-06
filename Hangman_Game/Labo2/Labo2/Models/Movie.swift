//
//  Movie.swift
//  Labo2

// Franck Stefani
// Karim Mokni
// Adel Amaouz

import Foundation

struct Movie: Codable {

    var Title: String
    var Year: String
    var Rated: String
    var Released: String
    var Runtime: String
    var Genre: String
    var Director: String
    var Writer: String
    var Actors: String
    var Language: String
    var Country: String
    var Awards: String
    var Ratings: [Ratings]
    var Metascore: String
    var imdbRating: String
    var imdbVotes: String
    var imdbID: String
    var DVD: String
    var BoxOffice: String
    var Website: String
    var Response: String
}

struct Ratings: Codable{
var Source: String
var Value : String
}
