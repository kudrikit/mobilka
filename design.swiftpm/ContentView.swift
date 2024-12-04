import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Дизайн и Анимации")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                // Кнопка для перехода к анимациям
                NavigationLink(destination: AnimationsView()) {
                    Text("Анимации")
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                // Кнопка для перехода к стилям
                NavigationLink(destination: StylesView()) {
                    Text("Стили и Цвета")
                        .frame(width: 200, height: 50)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Главное меню")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
