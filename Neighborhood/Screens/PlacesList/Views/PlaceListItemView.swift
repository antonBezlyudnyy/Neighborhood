import SwiftUI

/// Displays a single place in a list of places.
struct PlaceListItemView: View {
    
    var place: Place
    
    init(place: Place) {
        self.place = place
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(place.name)
                    .bold()
                Text(place.address)
                    .padding(.bottom, 1)
                HStack(spacing: 5) {
                    StarsView(stars: place.stars)
                    Text("(\(place.reviews))")
                    Text(place.price)
                }
                .font(.system(size: 12))
            }
            Spacer()
            if let imageURL = place.imageURL {
                AsyncImage(url: imageURL) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Color.gray
                }
                .frame(maxWidth: 100, maxHeight: 100)
            }
        }
    }
}

struct PlaceListItemView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListItemView(place: .examplePlace)
    }
}
