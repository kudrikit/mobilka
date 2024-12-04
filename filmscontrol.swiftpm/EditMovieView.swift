import SwiftUI

struct EditMovieView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var title: String
    @State private var description: String
    @State private var image: UIImage?
    @State private var showingImagePicker = false
    let movie: Movie
    let onUpdate: (Movie) -> Void

    init(movie: Movie, onUpdate: @escaping (Movie) -> Void) {
        self.movie = movie
        self.onUpdate = onUpdate
        _title = State(initialValue: movie.title)
        _description = State(initialValue: movie.description)
    }

    var body: some View {
        VStack {
            TextField("Название фильма", text: $title)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Описание фильма", text: $description)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Выбрать изображение") {
                showingImagePicker = true
            }
            .padding()
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $image)
            }

            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            } else {
                Image(uiImage: loadImage(from: movie.imagePath))
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            }

            Button("Сохранить изменения") {
                let imagePath = saveImage(image)
                let updatedMovie = Movie(
                    id: movie.id,
                    title: title,
                    description: description,
                    imagePath: imagePath.isEmpty ? movie.imagePath : imagePath
                )
                DatabaseManager.shared.updateMovie(updatedMovie)
                onUpdate(updatedMovie)
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
        .padding()
    }

    private func saveImage(_ image: UIImage?) -> String {
        guard let image = image else { return "" }
        let data = image.jpegData(compressionQuality: 0.8)
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let filePath = "\(path)/\(UUID().uuidString).jpg"
        FileManager.default.createFile(atPath: filePath, contents: data, attributes: nil)
        return filePath
    }

    private func loadImage(from path: String) -> UIImage {
        if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            return UIImage(data: data) ?? UIImage(systemName: "photo")!
        }
        return UIImage(systemName: "photo")!
    }
}
