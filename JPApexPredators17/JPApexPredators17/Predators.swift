//
//  Predators.swift
//  JPApexPredators17
//
//  Created by zouminyi on 2/13/24.
//

import Foundation

class Predators {
    var apexPredators: [ApexPredator] = []
    var allApexPredators: [ApexPredator] = []
    
    init() {
        decodeData()
    }
    
    func decodeData() {
        guard let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            allApexPredators = try decoder.decode([ApexPredator].self, from: data)
            apexPredators = allApexPredators
            
        } catch {
            print("Error decoding Json data: \(error)")
        }
    }
    
    func search(for searchTerm: String) -> [ApexPredator] {
        if searchTerm.isEmpty {
            return apexPredators
        } else {
            return apexPredators.filter { predator in
                predator.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    func sort(by alphabetical: Bool) {
        apexPredators.sort { p1, p2 in
            if alphabetical {
                p1.name < p2.name
            } else {
                p1.id < p2.id
            }
        }
    }
    
    func filter(by type: PredatorType)  {
        if type != .all {
            apexPredators = allApexPredators.filter { p in
                p.type == type
            }
        }
    }
}
