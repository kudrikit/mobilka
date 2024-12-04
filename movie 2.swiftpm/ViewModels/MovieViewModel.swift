import SwiftUI

class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []

    func addMovie(_ movie: Movie) {
        movies.append(movie)
        DatabaseManager.shared.addMovie(movie)
    }

    func deleteMovie(at offsets: IndexSet) {
        offsets.forEach { index in
            let movie = movies[index]
            DatabaseManager.shared.deleteMovie(movie)
        }
        movies.remove(atOffsets: offsets)
    }

    func filterMovies(byGenre genre: Genre? = nil, byRating rating: Double? = nil, searchText: String = "") -> [Movie] {
        var filteredMovies = movies
        
        if let genre = genre {
            filteredMovies = filteredMovies.filter { $0.genre == genre }
        }
        
        if let rating = rating {
            filteredMovies = filteredMovies.filter { $0.rating >= rating }
        }
        
        if !searchText.isEmpty {
            filteredMovies = filteredMovies.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
        
        return filteredMovies
    }
}
