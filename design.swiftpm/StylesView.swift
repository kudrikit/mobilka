import SwiftUI

struct StylesView: View {
    @State private var isBold = false
    @State private var isItalic = false
    @State private var backgroundColor = Color.white
    @State private var fontColor = Color.black
    @State private var textSize: CGFloat = 24

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                
                Text("Жирный шрифт")
                    .font(.system(size: 24))
                    .fontWeight(isBold ? .bold : .regular)
                Button("Изменить жирность текста") {
                    isBold.toggle()
                }
                
             
                Text("Изменение фона")
                    .font(.body)
                    .padding()
                    .background(backgroundColor)
                    .cornerRadius(10)
                Button("Изменить цвет фона") {
                    backgroundColor = backgroundColor == .white ? .yellow : .white
                }
                
                Text("Изменение цвета текста")
                    .font(.title)
                    .foregroundColor(fontColor)
                Button("Изменить цвет текста") {
                    fontColor = fontColor == .black ? .red : .black
                }
                
                Text("Изменение размера шрифта")
                    .font(.system(size: textSize))
                Slider(value: $textSize, in: 12...48, step: 1)
                    .padding()
            }
            .padding()
        }
        .navigationTitle("Разные стили")
    }
}

struct StylesView_Previews: PreviewProvider {
    static var previews: some View {
        StylesView()
    }
}
