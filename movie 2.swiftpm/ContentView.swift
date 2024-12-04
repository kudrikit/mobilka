import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MovieViewModel()
    @State private var selectedGenre: Genre?
    @State private var selectedRating: Double = 0.0
    @State private var searchText: String = ""
    @State private var showingAddMovieView = false

    var filteredMovies: [Movie] {
        viewModel.filterMovies(byGenre: selectedGenre, byRating: selectedRating, searchText: searchText)
    }

    var body: some View {
        NavigationView {
            VStack {
                // Поле для поиска
                SearchBar(text: $searchText)
                
                // HStack для выбора жанра и рейтинга
                HStack {
                    Picker("Жанр", selection: $selectedGenre) {
                        Text("Все жанры").tag(Genre?.none)
                        ForEach(Genre.allCases, id: \.self) { genre in
                            Text(genre.rawValue).tag(genre as Genre?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Stepper(value: $selectedRating, in: 0...5, step: 0.5) {
                        Text("Рейтинг: \(selectedRating, specifier: "%.1f")")
                            .font(.subheadline)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.horizontal)

                // Список фильмов
                List {
                    ForEach(filteredMovies) { movie in
                        MovieRow(movie: movie, viewModel: viewModel)
                    }
                    .onDelete { indexSet in
                        viewModel.deleteMovie(at: indexSet)
                    }
                }

                // Кнопка для добавления нового фильма
                Button(action: {
                    showingAddMovieView = true
                }) {
                    Text("Добавить фильм")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $showingAddMovieView) {
                    AddMovieView(viewModel: viewModel)
                }
            }
            .navigationBarTitle("Фильмы")
            .onAppear {
                viewModel.movies = DatabaseManager.shared.getMovies()
            }
        }
    }
}
