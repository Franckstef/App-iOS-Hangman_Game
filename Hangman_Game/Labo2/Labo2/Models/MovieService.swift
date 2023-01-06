//
//  MovieService.swift
//  Labo2

// Franck Stefani
// Karim Mokni
// Adel Amaouz

import Foundation


class MovieService {


    func getIdFilm()-> String{

        var numb = ""
        let randomInt: Int = Int.random(in: 000001..<0055252);

        if randomInt < 10 {numb = "000000" + String(randomInt)}
        else if(randomInt<100){ numb = "00000" + String(randomInt)}
        else if (randomInt<1000){numb = "0000" + String(randomInt)}
        else if (randomInt<10000){numb = "000" + String(randomInt)}
        else if (randomInt<100000){numb = "00" + String(randomInt)}
        else {numb = "0" + String(randomInt)}
        
        return numb

    }
    

    private var task: URLSessionDataTask?
    static var shared = MovieService()
    
   
    private init() {}
    
    func getMovie(callback: @escaping (Bool, String, String, String, String, String, String) -> Void) {
        let url = getIdFilm()
        let movieUrl = URL(string: "https://www.omdbapi.com/?i=tt\(url)&apikey=b55f37bb")!
        let request = URLRequest(url: movieUrl)
        let session = URLSession(configuration: .default)
        
        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
            
            //
            
            DispatchQueue.main.async {
                //
                guard let data = data, error == nil else {
                    callback(false, "","","","","","")
                    return
                }
                //
           
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, "","","","","","")
                    return
                }
                //
             
                guard let responseJSON = try? JSONDecoder().decode(Movie.self, from: data) else {
                    callback(false, "","","","","","")
                    return
                    
                }
                
                print("title is: \(responseJSON)")
                
                let textTitle = responseJSON.Title
                let textReleased = responseJSON.Released
                let textRating = responseJSON.imdbRating
                let textGenre = responseJSON.Genre
                let textActeur = responseJSON.Actors
                let textRealisateur = responseJSON.Director
                callback(true, textTitle, textReleased, textGenre, textActeur, textRealisateur, textRating )
      
            }
            
        }
        
        task?.resume()
    }
    

    
 
}
