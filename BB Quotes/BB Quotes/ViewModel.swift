//
//  ViewModel.swift
//  BB Quotes
//
//  Created by zouminyi on 2/16/24.
//

import Foundation

@MainActor
class ViewModel: ObservableObject {
    enum Status {
        case notStarting
        case fetching
        case success(datat: (quote: Quote, character: Character))
        case failed(error: Error)
    }
    
    // let others see the property but not to modify it
    @Published private(set) var status: Status = .notStarting
    
    private let controller: FetchController
    
    init(controller: FetchController) {
        self.controller = controller
    }
    
    func getData(for show: String) async {
        print("run get data")
        
        do {
            let quote = try await controller.fetchQuote(from: show)
            let character = try await controller.fetchCharacter(from: quote.character)
            
            print(quote, character)
            status = .success(datat: (quote, character))
        } catch {
            print(error)
            status = .failed(error: error)
        }
    }
      
}
