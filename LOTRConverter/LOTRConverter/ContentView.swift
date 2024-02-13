//
//  ContentView.swift
//  LOTRConverter
//
//  Created by zouminyi on 2/11/24.
//

import SwiftUI
import TipKit

struct ContentView: View {
    @State var isShowExchangeInfo = false
    @State var isShowSelecyCurrencyView = false
    @State var leftAmount = ""
    @State var rightAmount = ""
    
    @FocusState var leftTyping
    @FocusState var rightTyping

    @State var leftCurrency: Currency = .silverPenny
    @State var rightCurrency: Currency = .goldPenny
    
    
    var body: some View {
        ZStack {
            // Background
            Image(.background)
                .resizable()
                .ignoresSafeArea()
            
            // Content session
            VStack {
                // Logo Image
                Image(.prancingpony)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                // Currency Exchange title
                Text("Currency Exchange")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                
                // Currency Exchange session
                HStack {
                    // Left button
                    VStack {
                        HStack {
                            // Currency image
                            Image(leftCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 30)
                                
                            
                            Text(leftCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                        
                           
                            
                        }
                        .onTapGesture {
                            isShowSelecyCurrencyView.toggle()
                        }
                        .popoverTip(CurrencyTip(), arrowEdge: .bottom)
                        
                        TextField("Amount", text: $leftAmount)
                            .textFieldStyle(.roundedBorder)
                            .focused($leftTyping)
                            .keyboardType(.decimalPad)
                    }
                    
                    
                    // SF Symbols 5
                    Image(systemName: "equal")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .symbolEffect(.pulse)
                    
                    // Left button
                    VStack {
                        HStack {
                            Text(rightCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                            
                            // Currency image
                            Image(rightCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 30)
                            
                        }
                        .onTapGesture {
                            isShowSelecyCurrencyView.toggle()
                        }
                        
                        TextField("Amount", text: $rightAmount)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.trailing)
                            .focused($rightTyping)
                            .keyboardType(.decimalPad)
                        
                    }
                }
                .task{
                    try? Tips.configure()
                }
                .padding()
                .background(.black.opacity(0.5))
                .clipShape(.capsule)
                
                Spacer()
                
                // SF Symbols 5
                 
                HStack {
                    Spacer()
                    
                    Button {
                        isShowExchangeInfo.toggle()
                        print(isShowExchangeInfo)
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    }
                    .padding(.trailing)
                    .onChange(of: leftAmount) {
                        if leftTyping {
                            rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
                        }
                    }
                    .onChange(of: rightAmount) {
                        if rightTyping {
                            leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
                        }
                    }
                    .onChange(of: rightCurrency) {
                            rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
                        }
                    }
                    .onChange(of: leftCurrency) {
                            leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency) 
                    }
                    .sheet(isPresented: $isShowExchangeInfo) {
                        ExchangeInfoView()
                    }
                    .sheet(isPresented: $isShowSelecyCurrencyView) {
                        SelectCurrencyView(topCurrency: $leftCurrency, bottomCurrency: $rightCurrency)
                    }
                    
                }
            }
//            check view tips
//            .border(.blue)
            }
    }


#Preview {
    ContentView()
}
