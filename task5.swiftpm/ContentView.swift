import SwiftUI
import Lottie

struct ContentView: View {
    @State private var showNewPage = false
    
    var body: some View {
        VStack {
            Text("Главная страница")
                .font(.largeTitle)
            
            Button("Открыть новую страницу") {
                showNewPage.toggle()
            }
            .font(.title)
            .padding()
            .sheet(isPresented: $showNewPage) {
                NewPageView()
            }
            
            // Использование анимированной иконки Lottie на главной странице
            LottieView(animationName: "exampleAnimation")
                .frame(width: 100, height: 100)
                .padding()
        }
    }
}
