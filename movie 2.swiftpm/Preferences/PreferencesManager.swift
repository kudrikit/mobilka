import Foundation

class PreferencesManager {
    static let shared = PreferencesManager()

    private let defaults = UserDefaults.standard
    private let selectedGenreKey = "selectedGenre"
    private let lastViewedMovieTitleKey = "lastViewedMovieTitle"

    func saveSelectedGenre(_ genre: Genre) {
        defaults.set(genre.rawValue, forKey: selectedGenreKey)
    }

    func getSelectedGenre() -> Genre? {
        if let genreString = defaults.string(forKey: selectedGenreKey) {
            return Genre(rawValue: genreString)
        }
        return nil
    }

    func saveLastViewedMovieTitle(_ title: String) {
        defaults.set(title, forKey: lastViewedMovieTitleKey)
    }

    func getLastViewedMovieTitle() -> String? {
        return defaults.string(forKey: lastViewedMovieTitleKey)
    }
}
