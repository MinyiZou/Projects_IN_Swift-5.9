//
//  CharacterVIew.swift
//  BB Quotes
//
//  Created by zouminyi on 2/16/24.
//

import SwiftUI

struct CharacterVIew: View {
    let show: String
    let character: Character
            
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                Image(show.lowerNoSpace)
                    .resizable()
                    .scaledToFit()
                
                ScrollView {
                    VStack {
                        AsyncImage(url: character.images.randomElement()) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }

                    }
                    .frame(width: geo.size.width/1.2, height: geo.size.height/1.7)
                    .clipShape(.rect(cornerRadius: 25))
                    .padding(.top, 60)
                    
                    
                    VStack(alignment: .leading) {
                        Group {
                            
                        
                            Text(character.name)
                            .font(.largeTitle)
                        
                            Text("Portrayed by: \(character.portrayedBy)")
                            .font(.subheadline)
                        
                        Divider()
                        
                            Text("\(character.name) Character Info")
                            .font(.title2)
                        
                            Text("Born: \(character.birthday)")
                        
                        Divider()
                    }
                        
                    Group {
                        Text("Occupations:")
                        
                        ForEach(character.occupations, id: \.self) { i in
                            Text("• \(i)")
                                .font(.subheadline)
                            
                        }
                        
                        
                        
                        Divider()
                        
                        Text("Nickname:")
                        
                        if character.aliases.count > 0 {
                            
                            ForEach(character.aliases, id: \.self) { i in
                                Text("• \(i)")
                                    .font(.subheadline)
                                
                            }
                        } else {
                            Text("None")
                        }
                    }
                        
                    }
                .padding([.leading, .bottom], 40)
                }
                
            }
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CharacterVIew(show: Constants.bcs, character: Constants.previewCharacter)
}
