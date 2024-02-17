//
//  QuoteView.swift
//  BB Quotes
//
//  Created by zouminyi on 2/16/24.
//

import SwiftUI

struct QuoteView: View {
    @StateObject private var viewModel = ViewModel(controller: FetchController())
    @State private var showCharacterInfo = false
    let show: String
    
    var body: some View {
        GeometryReader { geo in
            ZStack(content: {
                Image(show.lowerNoSpace)
                    .resizable()
                    .frame(width: geo.size.width * 2.7, height: geo.size.height * 1.2)
                
                VStack {
                    Spacer(minLength: 140)
                    
                    switch viewModel.status {
                    
                    case .success(let data):
                        Text("\(data.quote.quote)")
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding()
                            .background(.black.opacity(0.5))
                            .clipShape(.rect(cornerRadius: 25))
                            .padding(.horizontal)
                        
                        
                        ZStack(alignment: .bottom) {
                            AsyncImage(url: data.character.images[0], content: { image in
                                image.resizable()
                                    .scaledToFill()
                            }) {
                                ProgressView()
                            }
                            // resize the image
                            .frame(width: geo.size.width / 1.1, height: geo.size.height/1.8)
                            .onTapGesture {
                                showCharacterInfo.toggle()
                            }
                            .sheet(isPresented: $showCharacterInfo, content: {
                                CharacterVIew(show: show, character: data.character)
                            })
                                
                            
                            Text("\(data.character.name)")
                                .foregroundColor(.white)
                                .padding(10)
                                .frame(maxWidth: .infinity)
                                .background(.ultraThinMaterial)
                        }
                        .frame(width: geo.size.width / 1.1, height: geo.size.height/1.8)
                        .clipShape(.rect(cornerRadius: 25))
                    case .fetching:
                        ProgressView()
                    default:
                        EmptyView()
                    }
                    
                    
                    Spacer()
                    
                    Button {
                        Task {
                            await viewModel.getData(for: show)
                        }
                        
                    } label: {
                        Text("Get Random Quote")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color("\(show.lowerNoSpace)Button"))
                        .clipShape(.rect(cornerRadius: 10))
                        .shadow(color: Color("\(show.lowerNoSpace)Shadow"), radius: 2)
                    }
                    Spacer(minLength: 180)
                }
                .frame(width: geo.size.width)
                
                
            })
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
    }
        
}

#Preview {
    QuoteView(show: Constants.bb)
        .preferredColorScheme(.dark )
}
