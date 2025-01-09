import SwiftUI

/// Displays a list of places in the neighborhood.
struct PlaceListView: View {
    @State private var query: String = ""
    @State private var showError: Bool = false
    @StateObject private var viewModel: PlaceListViewModel
    
    init() {
        #if DEBUG
        if UITestingHelper.isUITesting {
            let mock: NetworkManagerImpl = UITestingHelper.isPlacesSuccessful ?
            PlacesResponseSuccessMock() : PlacesResponseFailureMock()
            _viewModel = StateObject(wrappedValue: PlaceListViewModel(networkManager: mock))
        } else {
            _viewModel = StateObject(wrappedValue: PlaceListViewModel())
        }
        #else
        _viewModel = StateObject(wrappedValue: PlaceListViewModel())
        #endif
    }
    
    var body: some View {
        List(filteredPlaces) { place in
            NavigationLink(destination: PlaceDetailsView(place: place)) {
                PlaceListItemView(place: place)
                    .accessibilityIdentifier("item_\(place.id)")
            }
        }
        .accessibilityIdentifier("placesList")
        .navigationTitle("Neighborhood")
        .searchable(text: $query, prompt: "Filter")
        .task {
            do {
                try await viewModel.loadPlaces()
                try await viewModel.loadPlacesImageURLs()
            } catch {
                self.showError = true
            }
        }
        .alert("Loading failed", isPresented: $showError) {}
    }
    
    /// Returns a list of places by taking `places` and filtering based on the search query.
    var filteredPlaces: [Place] {
        
        // TODO: Implement this computed property. See the README for more details.
        guard !query.isEmpty else {
            return viewModel.places
        }
        // Get places that contain provided substring
        return viewModel.places.filter({$0.name.contains(query)})
    }
}

struct PlaceListView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListView()
    }
}
