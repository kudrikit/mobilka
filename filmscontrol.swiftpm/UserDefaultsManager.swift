import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard
    
    private let darkModeKey = "darkMode"
    private let movieCountKey = "movieCount"
    
    var isDarkModeEnabled: Bool {
        get { defaults.bool(forKey: darkModeKey) }
        set { defaults.set(newValue, forKey: darkModeKey) }
    }
    
    var movieCount: Int {
        get { defaults.integer(forKey: movieCountKey) }
        set { defaults.set(newValue, forKey: movieCountKey) }
    }
}
