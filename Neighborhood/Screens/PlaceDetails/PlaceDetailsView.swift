import SwiftUI

/// Displays detailed information about a place.
struct PlaceDetailsView: View {
    var place: Place
    @StateObject private var viewModel: PlaceDetailsViewModel
    @State private var placeImage: Image?
    @State private var showImageLodingError: Bool = false
    @Environment(\.dismiss) var dismiss
    
    init(place: Place) {
        self.place = place
        #if DEBUG
        if UITestingHelper.isUITesting {
            let mock: NetworkManagerImpl = UITestingHelper.isDetailsSuccessful ?
            DetailsImageResponseSuccessMock() : DetailsImageResponseFailureMock()
            _viewModel = StateObject(wrappedValue: PlaceDetailsViewModel(networkManager: mock))
        } else {
            _viewModel = StateObject(wrappedValue: PlaceDetailsViewModel())
        }
        #else
        _viewModel = StateObject(wrappedValue: PlaceDetailsViewModel())
        #endif
    }
    
    var body: some View {
        
        // TODO: Implement this view. See the README for more details.
        ZStack(alignment: .topLeading) {
//            if let imageURL = place.imageURL {
//                AsyncImage(url: imageURL) { image in
//                    image.resizable()
//                        .accessibilityIdentifier("placeDetailsImage")
//                        .aspectRatio(contentMode: .fit)
//                } placeholder: {
//                    Color.gray
//                }
//            }
            if let placeImage = placeImage {
                placeImage
                    .resizable()
                    .accessibilityIdentifier("placeDetailsImage")
                    .aspectRatio(contentMode: .fit)
            }
            HStack {
                backButton
                    .padding()
                Spacer()
            }
        }
        VStack(alignment: .leading) {
            Text(place.name)
                .bold()
            Text(place.address)
                .padding(.bottom, 1)
            HStack(spacing: 5) {
                StarsView(stars: place.stars)
                Text("(\(place.reviews))")
                Text(place.price)
                Spacer()
            }
            .font(.system(size: 12))
            .padding(.bottom, 5)
            Text(place.description)
            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .task {
            do {
                let data = try await viewModel.loadImage(url: place.imageURL)
                if let data = data,
                    let uiImage = UIImage(data: data) {
                    placeImage = Image(uiImage: uiImage)
                } else {
                    showImageLodingError = true
                }
            } catch {
                showImageLodingError = true
            }
        }
        .alert("Image loading failed", isPresented: $showImageLodingError) {}
    }
}


extension PlaceDetailsView {
    
    var backButton : some View {
        Button(action: {
            dismiss()
        }) {
            // Ready system image
            //            Image(systemName: "arrow.left.circle")
            //                .resizable()
            //                .scaledToFit()
            //                .frame(width: 40, height: 40)
            //                .foregroundStyle(Color.black)
            //                .background(Color.white)
            //                .clipShape(.circle)
            
            // Or draw it from scratch
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 40, height: 40)
                    .scaledToFit()
                    .overlay(
                        Circle()
                            .stroke(Color.black, lineWidth: 1) // Apply border with stroke
                    )
                
                Image(systemName: "arrow.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color.black)
            }
        }
    }
}

struct PlaceDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailsView(place: .examplePlace)
    }
}
