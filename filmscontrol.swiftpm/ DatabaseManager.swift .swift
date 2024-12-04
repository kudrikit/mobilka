import SQLite
import UIKit

class DatabaseManager {
    static let shared = DatabaseManager()
    private let db: Connection
    
    private let movies = Table("movies")
    private let id = Expression<Int64>("id")
    private let title = Expression<String>("title")
    private let description = Expression<String>("description")
    private let imagePath = Expression<String>("imagePath")
    
    private init() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let dbPath = "\(path)/movies.sqlite3"
        do {
            db = try Connection(dbPath)
            createTable()
        } catch {
            fatalError("Error initializing database: \(error)")
        }
    }
    
    // Создание таблицы
    private func createTable() {
        do {
            try db.run(movies.create(ifNotExists: true) { table in
                table.column(id, primaryKey: .autoincrement)
                table.column(title)
                table.column(description)
                table.column(imagePath)
            })
        } catch {
            print("Error creating table: \(error)")
        }
    }
    
    // Добавление фильма
    func addMovie(_ movie: Movie) -> Int64? {
        do {
            let rowId = try db.run(movies.insert(
                title <- movie.title,
                description <- movie.description,
                imagePath <- movie.imagePath
            ))
            print("Фильм добавлен с ID: \(rowId), путь к изображению: \(movie.imagePath)")
            return rowId
        } catch {
            print("Ошибка добавления фильма: \(error)")
            return nil
        }
    }


    
    // Получение списка фильмов
    func fetchMovies() -> [Movie] {
        var movieList: [Movie] = []
        do {
            for movie in try db.prepare(movies) {
                let fetchedMovie = Movie(
                    id: movie[id],
                    title: movie[title],
                    description: movie[description],
                    imagePath: movie[imagePath]
                )
                print("Загружен фильм: \(fetchedMovie)")
                movieList.append(fetchedMovie)
            }
        } catch {
            print("Ошибка при извлечении фильмов: \(error)")
        }
        return movieList
    }


    
    // Удаление фильма
    func deleteMovie(_ movieId: Int64) {
        do {
            let movieToDelete = movies.filter(id == movieId)
            try db.run(movieToDelete.delete())
            print("Movie deleted with ID: \(movieId)")
        } catch {
            print("Error deleting movie: \(error)")
        }
    }
    
    // Обновление фильма
    func updateMovie(_ movie: Movie) {
        do {
            let movieToUpdate = movies.filter(id == movie.id)
            try db.run(movieToUpdate.update(
                title <- movie.title,
                description <- movie.description,
                imagePath <- movie.imagePath
            ))
            print("Movie updated with ID: \(movie.id)")
        } catch {
            print("Error updating movie: \(error)")
        }
    }
    
    // Загрузка изображения из пути
    func loadImage(from path: String) -> UIImage {
        if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            return UIImage(data: data) ?? UIImage(systemName: "photo")!
        }
        return UIImage(systemName: "photo")!
    }
}
