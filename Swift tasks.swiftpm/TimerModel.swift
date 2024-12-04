import SwiftUI
import Combine

class TimerModel: ObservableObject {
    @Published var counter: Int = 0
}
