import SwiftUI
import Lottie

struct NewPageView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            // Анимированная иконка Lottie
            LottieView(animationName: "iconAnimation", loopMode: .loop)
                .frame(width: 150, height: 150)
                .padding()

            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Назад")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

