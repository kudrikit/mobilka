import SwiftUI

struct Movie: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var genre: Genre
    var image: UIImage
    var rating: Double = 0.0
    var ratingCount: Int = 0
    
    init(id: UUID = UUID(), title: String, description: String, genre: Genre, image: UIImage, rating: Double = 0.0, ratingCount: Int = 0) {
            self.id = id
            self.title = title
            self.description = description
            self.genre = genre
            self.image = image
            self.rating = rating
            self.ratingCount = ratingCount
        }
    
    
    mutating func updateRating(newRating: Double) {
        let totalRating = rating * Double(ratingCount) + newRating
        ratingCount += 1
        rating = totalRating / Double(ratingCount)
    }
}
