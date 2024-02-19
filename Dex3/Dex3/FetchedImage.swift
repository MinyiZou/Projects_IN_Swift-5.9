//
//  FetchedImage.swift
//  Dex3
//
//  Created by zouminyi on 2/18/24.
//

import SwiftUI

struct FetchedImage: View {
    let url: URL?
    
    var body: some View {
//        cannot use asyn image in home widget
        if let url, let imageData = try? Data(contentsOf: url), let image = UIImage(data: imageData) {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .shadow(color: .black, radius: 6)
        } else {
            Image("bulbasaur")
        }
    }
}

#Preview {
    FetchedImage(url: SamplePokemon.samplePokemon?.sprite)
}
