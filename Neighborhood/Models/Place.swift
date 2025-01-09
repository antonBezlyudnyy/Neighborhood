import Foundation

/// A place in the neighborhood.
struct Place: Codable, Identifiable {
    var id: String
    var name: String
    var address: String
    var stars: Int
    var reviews: Int
    var price: String
    var description: String
    var imageURL: URL?
}

/// Sample place data.
extension Place {
    static var examplePlace: Place = Place(
        id: "todo1",
        name: "TODO",
        address: "TODO",
        stars: 3,
        reviews: 0,
        price: "$",
        description: "TODO"
    )
    
    static var examplePlace2: Place = Place(
        id: "todo2",
        name: "TODO",
        address: "TODO",
        stars: 3,
        reviews: 0,
        price: "$",
        description: "TODO"
    )
    
    static var examplePlaces: [Place] = [.examplePlace, .examplePlace2]
}

/// Response from places API.
struct PlaceResult: Codable {
    var places: [Place]
}

/// Response from images API.
struct ImageResult: Codable {
    var image: URL
    
    enum CodingKeys: String, CodingKey {
      case image = "img"
    }
}
