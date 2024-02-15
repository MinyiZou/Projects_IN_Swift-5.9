//
//  ContentView.swift
//  JPApexPredators17
//
//  Created by zouminyi on 2/13/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let predators = Predators()
    @State var searchText = ""
    @State var isAlphabetical = true
    @State var currentType = PredatorType.all
    
    
    var filteredData: [ApexPredator] {

        predators.filter(by: currentType)
        predators.sort(by: isAlphabetical)
        return predators.search(for: searchText)
    }
    
    var body: some View {
        NavigationStack {
            List(filteredData
            ) { predator in
                NavigationLink {
                    PredatorDetail(predator: predator, position: .camera(MapCamera(centerCoordinate: predator.location , distance: 30000)))
                } label: {
                    HStack {
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .black, radius: 1)
                        
                        VStack(alignment: .leading) {
                            Text(predator.name)
                                .fontWeight(.bold)
                            
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(predator.type.background)
                                .clipShape(.capsule)
                        }
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            isAlphabetical.toggle()
                        }
                    } label: {
                        Image(systemName: isAlphabetical ? "film" : "textformat")
                            .symbolEffect(.bounce, value: isAlphabetical)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $currentType.animation()) {
                            ForEach(PredatorType.allCases) { type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)
                            }
                        }
                        
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
                
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
