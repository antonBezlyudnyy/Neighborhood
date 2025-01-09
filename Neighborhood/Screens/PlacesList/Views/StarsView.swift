import SwiftUI

/// Displays a star rating.
struct StarsView: View {
    var stars: Int
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach((1...5), id: \.self) { star in
                Image(systemName: "star.fill")
                    .foregroundStyle(stars >= star ? .orange : .gray)
            }
        }
    }
}

struct StarsView_Previews: PreviewProvider {
    static var previews: some View {
        StarsView(stars: 3)
    }
}
