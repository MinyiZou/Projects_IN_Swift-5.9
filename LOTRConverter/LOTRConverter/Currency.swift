//
//  Currency.swift
//  LOTRConverter
//
//  Created by zouminyi on 2/12/24.
//

import SwiftUI

// calculate the currency by rate in advance
enum Currency: Double, CaseIterable, Identifiable {
    case goldPiece = 1
    case goldPenny = 4
    case silverPiece = 16
    case silverPenny = 64
    case copperPenny = 6400
    
    var id: Double { rawValue }
    
    var name: String {
        return String(describing: self)
            .replacingOccurrences(of: "([a-z])([A-Z])", with: "$1 $2", options: .regularExpression)
            .capitalized
    }
    
    var image: ImageResource {
        switch self {
        case .copperPenny:
                .copperpenny
        case .goldPenny:
                .goldpenny
        case .goldPiece: 
                .goldpiece
        case .silverPenny: 
                .silverpenny
        case .silverPiece: 
                .silverpiece
        }
    }
    
    func convert(_ amountString: String, to currency: Currency) -> String {
        guard let exchangeAmount = Double(amountString) else {
            return ""
        }
        
        let amount = (exchangeAmount / self.rawValue) * currency.rawValue
        return String(format: "%.2f", amount)
    }
}
