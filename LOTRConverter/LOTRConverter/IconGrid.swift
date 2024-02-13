//
//  IconGrid.swift
//  LOTRConverter
//
//  Created by zouminyi on 2/12/24.
//

import SwiftUI

struct IconGrid: View {
    @Binding var currency: Currency
    
    var body: some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]){
            ForEach(Currency.allCases) {c in
                if currency == c {
                    CurrencyIcon(image: c.image, title: c.name)
                        .shadow(color: .black, radius: 10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(lineWidth: 3)
                                .opacity(0.5)
                        }
                } else {
                    CurrencyIcon(image: c.image, title: c.name)
                        .onTapGesture {
                            currency = c
                        }
                }
                
            }
        }
    }
}

#Preview {
    IconGrid(currency: .constant(.goldPenny))
}
