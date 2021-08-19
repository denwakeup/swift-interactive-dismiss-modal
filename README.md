# Swift Interactive Dismiss Modal

**Usage**

```swift
struct ContentView: View {
    @State var isPresented = false
    @State var canDismissSheet = false

    var body: some View {
        Button("Tap me") {
            isPresented = true
        }
        .sheet(
            isPresented: $isPresented,
            content: {
                NavigationView {
                    Text("Hello World")
                }
                .interactiveDismiss(canDismissSheet: canDismissSheet) {
                    print("attemptToDismissHandler")
                }
            }
        )
    }
}
```
