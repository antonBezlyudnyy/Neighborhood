import SwiftUI

/// Displays the main content of the app.
struct ContentView: View {
    var body: some View {
        NavigationView {
            PlaceListView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
