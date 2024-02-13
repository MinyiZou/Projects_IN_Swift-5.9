//
//  SelectCurrency.swift
//  LOTRConverter
//
//  Created by zouminyi on 2/12/24.
//

import SwiftUI

struct SelectCurrencyView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var topCurrency: Currency
    @Binding var bottomCurrency: Currency
    
    var body: some View {
        ZStack {
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack {
                Text("Select the currency you are starting with:")
                    .fontWeight(.bold)
                
                
                IconGrid(currency: $topCurrency)
                
                
                Text("Select the currency you would like to convert to:")
                    .fontWeight(.bold)
                
                IconGrid(currency: $bottomCurrency)
                
                Button("Done") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown.opacity(0.7))
                .font(.largeTitle)
                .foregroundStyle(.white)
                .padding()
                
            }
            .padding()
            .multilineTextAlignment(.center)
        }
        
        
    }
    
    
}

#Preview() {
    SelectCurrencyView(topCurrency: .constant(.silverPenny), bottomCurrency: .constant(.goldPenny))
}
