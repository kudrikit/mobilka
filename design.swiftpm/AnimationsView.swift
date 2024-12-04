import SwiftUI

struct AnimationsView: View {
    @State private var animate1 = false
    @State private var animate2 = false
    @State private var animate3 = false
    @State private var animate4 = false
    @State private var animate5 = false

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                
                Rectangle()
                    .fill(Color.red)
                    .frame(width: animate1 ? 200 : 100, height: animate1 ? 200 : 100)
                    .animation(.easeInOut(duration: 1), value: animate1)
                Button("Изменить размер") {
                    animate1.toggle()
                }
                
                
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.green)
                    .frame(width: 100, height: 100)
                    .offset(x: animate3 ? 150 : 0, y: 0)
                    .animation(.spring(), value: animate3)
                Button("Переместить") {
                    animate3.toggle()
                }
                
                Ellipse()
                    .fill(Color.purple)
                    .frame(width: 150, height: 100)
                    .opacity(animate4 ? 0.1 : 1)
                    .animation(.easeInOut(duration: 1.5), value: animate4)
                Button("Изменить прозрачность") {
                    animate4.toggle()
                }
                
                Capsule()
                    .fill(animate5 ? Color.orange : Color.gray)
                    .frame(width: 150, height: 70)
                    .animation(.easeIn(duration: 1), value: animate5)
                Button("Изменить цвет") {
                    animate5.toggle()
                }
            }
            .padding()
        }
        .navigationTitle("Разные анимации")
    }
}

struct AnimationsView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationsView()
    }
}
