//
//  Constants.swift
//  BB Quotes
//
//  Created by zouminyi on 2/15/24.
//

import Foundation

enum Constants {
    static let bcs = "Better Call Saul"
    static let bb = "Breaking Bad"
    
    static let previewCharacter: Character = {
       let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let data = try! Data(contentsOf: Bundle.main.url(forResource: "samplecharacter", withExtension: "json")!)
        return try! decoder.decode([Character].self, from: data)[0]
    }()
}
extension String {
    var replaceSpaceWithPlus: String {
        self.replacingOccurrences(of: " ", with: "+")
    }
    
    var noSpace: String {
        self.replacingOccurrences(of: " ", with: "")
    }
    var lowerNoSpace: String {
        self.noSpace.lowercased()
    }
}
