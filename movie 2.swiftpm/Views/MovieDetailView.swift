import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    @ObservedObject var viewModel: MovieViewModel
    @State private var rating: Double = 0.0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(uiImage: movie.image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 300)
                    .cornerRadius(10)
                    .padding()

                Text(movie.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)

                Text("Жанр: \(movie.genre.rawValue)")
                    .font(.title3)
                    .padding(.horizontal)

                Text(movie.description)
                    .font(.body)
                    .padding(.horizontal)
                    .padding(.top, 5)

                Text("Текущий рейтинг: \(movie.rating, specifier: "%.1f")")
                    .font(.title2)
                    .padding(.horizontal)
                    .padding(.top, 10)

                VStack {
                    Text("Добавить новый рейтинг:")
                        .font(.headline)
                        .padding(.top, 20)

                    Slider(value: $rating, in: 0...5, step: 0.5)
                        .padding(.horizontal)

                    Button(action: {
                        viewModel.updateMovieRating(movie, newRating: rating) // Проверьте, что метод корректно определен
                    }) {
                        Text("Сохранить рейтинг")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top, 10)
                }
            }
            .navigationBarTitle(Text(movie.title), displayMode: .inline)
        }
    }
}
