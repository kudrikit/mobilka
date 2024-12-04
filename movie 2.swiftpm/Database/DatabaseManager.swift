import SQLite
import SwiftUI

class DatabaseManager {
    static let shared = DatabaseManager()
    private var db: Connection?

    private let moviesTable = Table("movies")
    private let id = Expression<String>("id")
    private let title = Expression<String>("title")
    private let description = Expression<String>("description")
    private let genre = Expression<String>("genre")
    private let image = Expression<Data>("image")
    private let rating = Expression<Double>("rating")
    private let ratingCount = Expression<Int>("ratingCount")

    private init() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

        do {
            db = try Connection("\(path)/movies.sqlite3")
            createTable()
        } catch {
            print("Ошибка подключения к базе данных: \(error)")
        }
    }

    private func createTable() {
        do {
            try db?.run(moviesTable.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(title)
                table.column(description)
                table.column(genre)
                table.column(image)
                table.column(rating)
                table.column(ratingCount)
            })
        } catch {
            print("Ошибка создания таблицы: \(error)")
        }
    }

    func addMovie(_ movie: Movie) {
        do {
            let imageData = movie.image.jpegData(compressionQuality: 1.0) ?? Data()
            let insert = moviesTable.insert(
                id <- movie.id.uuidString,
                title <- movie.title,
                description <- movie.description,
                genre <- movie.genre.rawValue,
                image <- imageData,
                rating <- movie.rating,
                ratingCount <- movie.ratingCount
            )
            try db?.run(insert)
        } catch {
            print("Ошибка добавления фильма: \(error)")
        }
    }

    func getMovies() -> [Movie] {
        var movies: [Movie] = []
        do {
            for movieRow in try db!.prepare(moviesTable) {
                if let uuid = UUID(uuidString: movieRow[id]), let movieImage = UIImage(data: movieRow[image]) {
                    let movie = Movie(
                        id: uuid,
                        title: movieRow[title],
                        description: movieRow[description],
                        genre: Genre(rawValue: movieRow[genre])!,
                        image: movieImage,
                        rating: movieRow[rating],
                        ratingCount: movieRow[ratingCount]
                    )
                    movies.append(movie)
                }
            }
        } catch {
            print("Ошибка получения фильмов: \(error)")
        }
        return movies
    }



    func deleteMovie(_ movie: Movie) {
        do {
            let movieToDelete = moviesTable.filter(id == movie.id.uuidString)
            try db?.run(movieToDelete.delete())
        } catch {
            print("Ошибка удаления фильма: \(error)")
        }
    }
    
    func updateMovie(_ movie: Movie) {
        do {
            let movieToUpdate = moviesTable.filter(id == movie.id.uuidString)
            let imageData = movie.image.jpegData(compressionQuality: 1.0) ?? Data()
            try db?.run(movieToUpdate.update(
                title <- movie.title,
                description <- movie.description,
                genre <- movie.genre.rawValue,
                image <- imageData,
                rating <- movie.rating,
                ratingCount <- movie.ratingCount
            ))
        } catch {
            print("Ошибка обновления фильма: \(error)")
        }
    }

}
