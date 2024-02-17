//
//  FetchController.swift
//  BB Quotes
//
//  Created by zouminyi on 2/15/24.
//

import Foundation

struct FetchController {
    enum NetworkError: Error {
        case badURL, badResponse
    }
    
    private let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
//    https://breaking-bad-api-six.vercel.app/api/quotes/random?production=breaking+bad
    func fetchQuote(from show: String) async throws -> Quote {
        let quoteURl = baseURL.appending(path: "quotes/random")
        var quoteComponents = URLComponents(url: quoteURl, resolvingAgainstBaseURL: true)
        let quoteQueryItems = URLQueryItem(name: "production", value: show.replaceSpaceWithPlus)
        quoteComponents?.queryItems = [quoteQueryItems]
        
        guard let url = quoteComponents?.url else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        return quote
    }
    
    func fetchCharacter(from name: String) async throws -> Character {
        let characterUrl = baseURL.appending(path: "characters")
        var components = URLComponents(url: characterUrl, resolvingAgainstBaseURL: true)
        let queryItems = URLQueryItem(name: "name", value: name.replaceSpaceWithPlus)
        components?.queryItems = [queryItems]
        
        guard let url = components?.url else { throw NetworkError.badURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let character = try decoder.decode([Character].self, from: data)
        return character[0]
    }
}
