LOTRConverter
====

### Basic knowledge
> Struct is immutable, if you want to change it, you should use Property wrapper. Property wrapper is something that kind of invisibly, we can't exactly see it, but it wraps around
@state: tell swiftUI view that we want to be able to change the value in our view 
```
    @State var isShowExchangeInfo = false
```

@environment: an evironment property kind of exposes certain values or certain functionality
```
    @Environment(\.dismiss) var dismiss
```

@Binding: a variable can communicate with other struct or class 
 

### Update in iOS 17
> SF Symbols 5 for icon (a library of iconography)
```
// Example for SF Symbols 5
Image(systemName: "equal")
    .font(.largeTitle)
    .foregroundStyle(.white)
    .symbolEffect(.pulse)
```

### Screenshot
![](img/1.png)
![](img/2.png)
![](img/3.png)
