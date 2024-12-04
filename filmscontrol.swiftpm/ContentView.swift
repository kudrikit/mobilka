import SwiftUI

struct ContentView: View {
    @State private var movies: [Movie] = []
    @State private var showingAddMovieView = false
    @State private var selectedMovie: Movie? = nil
    @State private var showingMovieDetailView = false
    @State private var showingEditMovieView = false

    var body: some View {
        NavigationView {
            VStack {
                // Список фильмов
                List(movies, id: \.id) { movie in
                    HStack {
                        Image(uiImage: DatabaseManager.shared.loadImage(from: movie.imagePath))
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())

                        VStack(alignment: .leading) {
                            Text(movie.title).bold()
                            Text(movie.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        // Иконка "Просмотр"
                        Button(action: {
                            selectedMovie = movie
                            showingMovieDetailView = true
                        }) {
                            Image(systemName: "eye")
                                .font(.title3)
                                .foregroundColor(.blue)
                        }
                        .buttonStyle(BorderlessButtonStyle())

                        // Иконка "Редактировать"
                        Button(action: {
                            selectedMovie = movie
                            showingEditMovieView = true
                        }) {
                            Image(systemName: "pencil")
                                .font(.title3)
                                .foregroundColor(.green)
                        }
                        .buttonStyle(BorderlessButtonStyle())

                        // Иконка "Удалить"
                        Button(action: {
                            deleteMovie(movie)
                        }) {
                            Image(systemName: "trash")
                                .font(.title3)
                                .foregroundColor(.red)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
                .listStyle(PlainListStyle())

                // Кнопка добавления фильма
                Button(action: {
                    showingAddMovieView = true
                }) {
                    HStack {
                        Image(systemName: "plus.circle")
                            .font(.title2)
                        Text("Добавить фильм")
                            .font(.body)
                    }
                }
                .sheet(isPresented: $showingAddMovieView) {
                    AddMovieView(onSave: { _ in
                        refreshMovies()
                    })
                }
            }
            .navigationTitle("Фильмы (\(movies.count))")
            .onAppear {
                refreshMovies()
            }
            .sheet(isPresented: $showingMovieDetailView) {
                if let movie = selectedMovie {
                    MovieDetailView(movie: movie)
                }
            }
            .sheet(isPresented: $showingEditMovieView) {
                if let movie = selectedMovie {
                    EditMovieView(movie: movie, onUpdate: { _ in
                        refreshMovies()
                    })
                }
            }
        }
    }
    
    private func loadImage(from path: String) -> UIImage {
        if FileManager.default.fileExists(atPath: path) {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                print("Изображение успешно загружено: \(path)")
                return UIImage(data: data) ?? UIImage(systemName: "photo")!
            } else {
                print("Ошибка загрузки данных из файла: \(path)")
            }
        } else {
            print("Файл не найден по пути: \(path)")
        }
        return UIImage(systemName: "photo")! // Иконка-заглушка
    }



    // Удаление фильма
    private func deleteMovie(_ movie: Movie) {
        DatabaseManager.shared.deleteMovie(movie.id)
        refreshMovies()
    }

    // Обновление списка фильмов
    private func refreshMovies() {
        movies = DatabaseManager.shared.fetchMovies()
    }
}
