JPApexPredators
===

## iOS 17 
In iOS 17, Mapkit integrating maps into SwiftUI and we can leverage the following features:
```
Map(position: $position) {
    ForEach(predators.apexPredators) { predator in
        Annotation(predator.name, coordinate: predator.location) {
            Image(predator.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .scaleEffect(x: -1)
                .shadow(color: .white, radius: 3)
        }
    }
}
.mapStyle(satellite ? .imagery(elevation:  .realistic) : .standard(elevation: .realistic))
.overlay(alignment: .bottomTrailing) {
    Button {
        satellite.toggle()
    } label: {
        Image(systemName: satellite ? "globe.americas.fill" : "globe.americas")
            .font(.largeTitle)
            .imageScale(.large)
            .padding(3)
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: 7))
            .shadow(radius: 3)
            .padding()
        
    }
}
```

## Sticker
Create Sticker in target, add all the images in the Stickers folder, and you can send the stickers in imessage
Stickers in iMessage: 
[](/img/3.png)

## Decoder
>   When working with JSON data in Swift that uses snake_case for its keys (like scene_description in your example), and you prefer to use camelCase in your Swift code (like sceneDescription), you can utilize the convertFromSnakeCase key decoding strategy available in JSONDecoder. This strategy automatically converts snake_case keys in your JSON to camelCase property names in your Swift structs or classes that conform to Codable.
```
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            apexPredators = try decoder.decode([ApexPredator].self, from: data)
```

## Create SearchBar
```
    @State var searchText = ""
    
    var filteredData: [ApexPredator] {
        if searchText.isEmpty {
            return predators.apexPredators
        } else {
            return predators.apexPredators.filter { predator in
                predator.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    // add it to body view
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
```

## Gradient
```
Image(predator.type.rawValue)
    .resizable()
    .scaledToFit()
    .overlay {
        LinearGradient(stops: [Gradient.Stop(color: .clear, location: 0.8), Gradient.Stop(color: .black, location: 1)], startPoint: .top, endPoint: .bottom)
    }
```
Before:
[](/img/1.PNG)
After:
[](/img/2.PNG)

All the screenshot of the App:

[](/img/4.png)
[](/img/5.png)
[](/img/6.png)
[](/img/7.png)
[](/img/3.png)

