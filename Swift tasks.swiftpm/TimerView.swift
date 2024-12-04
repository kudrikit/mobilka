import SwiftUI
import UIKit

struct TimerView: UIViewControllerRepresentable {

    @ObservedObject var timerModel: TimerModel

    func makeUIViewController(context: Context) -> TimerViewController {
        let viewController = TimerViewController()
        viewController.timerModel = timerModel
        return viewController
    }

    func updateUIViewController(_ uiViewController: TimerViewController, context: Context) {
    }
}
