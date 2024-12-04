import SwiftUI

struct MovieRow: View {
    let movie: Movie
    @ObservedObject var viewModel: MovieViewModel
    @State private var showingDetail = false
    @State private var showingEditMovieView = false

    var body: some View {
        HStack {
            Image(uiImage: movie.image)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                Text(movie.description)
                    .font(.subheadline)
                    .lineLimit(2)

                Text("Рейтинг: \(movie.rating, specifier: "%.1f")")
            }

            Spacer()

            Button(action: {
                showingEditMovieView = true
            }) {
                Image(systemName: "pencil")
                    .foregroundColor(.blue)
            }
            .sheet(isPresented: $showingEditMovieView) {
                EditMovieView(viewModel: viewModel, movie: movie)
            }
        }
        .onTapGesture {
            showingDetail = true
        }
        .sheet(isPresented: $showingDetail) {
            MovieDetailView(movie: movie, viewModel: viewModel)
        }
    }
}
