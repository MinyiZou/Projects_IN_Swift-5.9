//
//  FetchController.swift
//  Dex3
//
//  Created by zouminyi on 2/18/24.
//

import Foundation
import CoreData

struct FetchController {
    enum NetworkError: Error {
        case badURL, badData, badResponse
    }
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    func fetchAllPokemon() async throws -> [TempPokemon]? {
        if havePokemon() {
            return nil
        }
        
        var allPokemon: [TempPokemon] = []
        
        var fetchComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        fetchComponents?.queryItems = [URLQueryItem(name: "limit", value: "386")]
        
        guard let url = fetchComponents?.url else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        guard let dic = try JSONSerialization.jsonObject(with: data) as? [String: Any], let results = dic["results"] as? [[String: String]] else {
            throw NetworkError.badData
        }
        
        for pokemon in results {
            if let urlString = pokemon["url"], let url = URL(string: urlString){
                allPokemon.append(try await fetchPokemon(from: url))
            }
        }
        return allPokemon
    }
    
    private func fetchPokemon(from url: URL) async throws -> TempPokemon {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        let pokemon = try JSONDecoder().decode(TempPokemon.self, from: data)
        
        print("\(pokemon.id): \(pokemon.name)")
        
        return pokemon
    }
    
    private func havePokemon() -> Bool {
        let content = PersistenceController.shared.container.newBackgroundContext()
        
        let fetchRequest: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id IN %@", [1, 386])
        
        do {
            let checkPokemon = try content.fetch(fetchRequest)
            if checkPokemon.count == 2 {
                return true
            }
        } catch {
            print("fetching failed")
            return false
        }
        return false
    }
}
