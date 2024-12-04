import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    
    var body: some View {
        VStack {
            if let image = try? Data(contentsOf: URL(fileURLWithPath: movie.imagePath)),
               let uiImage = UIImage(data: image) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .padding()
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .padding()
            }
            
            Text(movie.title)
                .font(.title)
                .bold()
            
            Text(movie.description)
                .font(.body)
                .padding()
            
            Spacer()
        }
        .padding()
    }
}
