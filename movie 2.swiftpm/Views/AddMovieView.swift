import SwiftUI

struct AddMovieView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: MovieViewModel

    @State private var title: String = ""
    @State private var description: String = ""
    @State private var selectedGenre: Genre = .action
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Название фильма")) {
                    TextField("Введите название", text: $title)
                }

                Section(header: Text("Описание фильма")) {
                    TextField("Введите описание", text: $description)
                }

                Section(header: Text("Жанр")) {
                    Picker("Выберите жанр", selection: $selectedGenre) {
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
                        Text("Выберите фото")
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
            .navigationBarTitle("Добавить фильм")
            .navigationBarItems(leading: Button("Отмена") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Сохранить") {
                if let image = selectedImage {
                    let newMovie = Movie(title: title, description: description, genre: selectedGenre, image: image)
                    viewModel.addMovie(newMovie) // Убедитесь, что метод вызывается без метки `movie:`
                    presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}
