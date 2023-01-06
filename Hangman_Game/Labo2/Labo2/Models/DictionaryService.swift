//
//  DictionaryService.swift
//  Labo2
//
// Franck Stefani
// Karim Mokni
// Adel Amaouz

import Foundation

class DictionaryService {
    private static let wordUrl = URL(string: "https://random-word-api.herokuapp.com/word")!
    private var task: URLSessionDataTask?
    static var shared = DictionaryService()
    
    private init() {}
    
    func getWord(callback: @escaping (Bool, Dictionary?) -> Void) {
        let request = createQuoteRequest()
        let session = URLSession(configuration: .default)
        
        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                
                guard let responseJSON = try? JSONDecoder().decode([String].self, from: data) else{
                    callback(false, nil)
                    return
                }
                
                let text = responseJSON[0]
                
                let word = Dictionary(word: text)
                callback(true, word)
            }
        }
        
        task?.resume()
    }
    
    private func createQuoteRequest() -> URLRequest {
        var request = URLRequest(url: DictionaryService.wordUrl)
        request.httpMethod = "GET"

        return request
    }
    
}
