import SwiftUI

struct EditMovieView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: MovieViewModel
    @State var movie: Movie

    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Название фильма")) {
                    TextField("Введите название", text: $movie.title)
                }

                Section(header: Text("Описание фильма")) {
                    TextField("Введите описание", text: $movie.description)
                }

                Section(header: Text("Жанр")) {
                    Picker("Выберите жанр", selection: $movie.genre) {
                        ForEach(Genre.allCases, id: \.self) { genre in
                            Text(genre.rawValue).tag(genre)
                        }
                    }
                }

                Section(header: Text("Фото")) {
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                    } else {
                        Image(uiImage: movie.image)
                            .resizable()
                            .scaledToFit()
                    }

                    Button(action: {
                        isImagePickerPresented = true
                    }) {
                        Text("Загрузить фото")
                    }
                    .sheet(isPresented: $isImagePickerPresented) {
                        ImagePicker(selectedImage: $selectedImage)
                    }
                }
            }
            .navigationBarTitle("Редактировать фильм")
            .navigationBarItems(leading: Button("Отмена") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Сохранить") {
                if let newImage = selectedImage {
                    movie.image = newImage
                }
                viewModel.updateMovie(movie) // Проверьте, что этот метод определен и корректно вызывается
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
