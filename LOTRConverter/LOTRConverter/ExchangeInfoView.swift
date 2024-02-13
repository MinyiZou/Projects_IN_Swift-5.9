//
//  ExchangInfo.swift
//  LOTRConverter
//
//  Created by zouminyi on 2/12/24.
//

import SwiftUI
import Foundation

struct ExchangeRates: Hashable {
    let leftImage: ImageResource
    let text: String
    let rightImage: ImageResource
    
}

struct ExchangeInfoView: View {
    let exchangeRates: [ExchangeRates] = [
        ExchangeRates(leftImage: .goldpiece, text: "1 Gold piece = 4 Gold Pennies", rightImage: .goldpenny),
        ExchangeRates(leftImage: .goldpenny, text: "1 Gold Penny = 4 Silver Pieces", rightImage: .silverpiece),
        ExchangeRates(leftImage: .silverpiece, text: "1 Silver Piece = 4 Silver Pennies", rightImage: .silverpenny),
        ExchangeRates(leftImage: .silverpenny, text: "1 Silver Penny = 100 Copper Pennies", rightImage: .copperpenny),
    ]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack {
                Text("Exchange Rates")
                    .font(.largeTitle)
                    .tracking(3)
                
                
                Text("Here at the Prancing Pony, we are happy to offer you a place where you can exchange all the known currencies in the entire world except one. We used to take Brandy Bucks, but after finding out that it was a person instead of a piece of paper, we realized it had no value to us. Below is a simple guide to our currency exchange rates:")
                    .padding()
                    .font(.title2)
                
                ForEach(exchangeRates, id: \.self) { rate in
                    ExchangeRateView(leftImage: rate.leftImage, text: rate.text, rightImage: rate.rightImage)
                }
                
                Button("Done") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown.opacity(0.7))
                .font(.largeTitle)
                .foregroundStyle(.white)
                .padding()
            }
            .foregroundStyle(.black)
        }
    }
}



#Preview {
    ExchangeInfoView()
}

