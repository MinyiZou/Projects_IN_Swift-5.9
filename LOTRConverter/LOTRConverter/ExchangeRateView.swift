//
//  ExchangeRateView.swift
//  LOTRConverter
//
//  Created by zouminyi on 2/12/24.
//

import SwiftUI

struct ExchangeRateView: View {
    let leftImage: ImageResource
    let text: String
    let rightImage: ImageResource
    
    var body: some View {
        
        HStack {
            Image(leftImage)
                .resizable()
                .scaledToFit()
                .frame(height: 30)
            
            Text(text)
            
            Image(rightImage)
                .resizable()
                .scaledToFit()
                .frame(height: 30)
        }
    }
}

#Preview {
    ExchangeRateView(leftImage: .goldpiece, text: "1 Gold piece = 4 Gold Pennies", rightImage: .goldpenny)
}
