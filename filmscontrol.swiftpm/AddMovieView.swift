import SwiftUI

struct AddMovieView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var description = ""
    @State private var image: UIImage? // Для изображения, выбранного пользователем
    @State private var showingImagePicker = false // Для отображения галереи
    let onSave: (Movie) -> Void

    var body: some View {
        VStack {
            // Поле для ввода названия фильма
            TextField("Название фильма", text: $title)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            // Поле для ввода описания фильма
            TextField("Описание фильма", text: $description)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            // Кнопка выбора изображения
            Button("Выбрать изображение") {
                showingImagePicker = true
            }
            .padding()
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $image)
            }

            // Показ изображения, если выбрано
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            }

            // Кнопка сохранения фильма
            Button("Сохранить") {
                guard let image = image else {
                    print("Ошибка: изображение не выбрано")
                    return
                }
                let imagePath = saveImage(image) // Сохраняем изображение
                guard !imagePath.isEmpty else {
                    print("Ошибка: путь к изображению пуст")
                    return
                }

                let newMovie = Movie(id: 0, title: title, description: description, imagePath: imagePath)
                if let newId = DatabaseManager.shared.addMovie(newMovie) {
                    print("Фильм добавлен с ID: \(newId)")
                    let savedMovie = Movie(id: newId, title: title, description: description, imagePath: imagePath)
                    onSave(savedMovie) // Передаём данные обратно в ContentView
                    presentationMode.wrappedValue.dismiss()
                } else {
                    print("Ошибка добавления фильма в базу данных")
                }
            }
            .disabled(title.isEmpty || description.isEmpty || image == nil) // Блокируем кнопку, если данные не заполнены
            .padding()
        }
        .padding()
    }

    // Сохранение изображения в файловую систему
    private func saveImage(_ image: UIImage) -> String {
        let data = image.jpegData(compressionQuality: 0.8) // Сохранение в формате JPEG
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let filePath = "\(path)/\(UUID().uuidString).jpg" // Генерация уникального пути
        print("Попытка сохранить изображение по пути: \(filePath)")

        if FileManager.default.createFile(atPath: filePath, contents: data, attributes: nil) {
            print("Изображение сохранено успешно!")
            return filePath
        } else {
            print("Ошибка сохранения изображения.")
            return ""
        }
    }
}
