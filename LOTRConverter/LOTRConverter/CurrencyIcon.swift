//
//  CurrencyIcon.swift
//  LOTRConverter
//
//  Created by zouminyi on 2/12/24.
//

import SwiftUI

struct CurrencyIcon: View {
    let image: ImageResource
    let title: String
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(image)
                .resizable()
                .scaledToFit()
            
            Text(title)
                .padding(3)
                .font(.caption)
                .frame(maxWidth: .infinity)
                .background(.brown.opacity(0.75))
            
            
        }
        .padding(3)
        .frame(width: 100, height: 100)
        .background(.brown)
        .clipShape(.rect(cornerRadius: 25))
        
    }
}

#Preview {
    CurrencyIcon(image: .silverpenny, title: "silver Penny")
}
