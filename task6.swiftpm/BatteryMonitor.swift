import SwiftUI
import Combine

class BatteryMonitor: ObservableObject {
    @Published var batteryLevel: Float = 100.0 
    init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
        if UIDevice.current.batteryLevel >= 0 {
            batteryLevel = UIDevice.current.batteryLevel * 100
        }
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(batteryLevelDidChange),
            name: UIDevice.batteryLevelDidChangeNotification,
            object: nil
        )
    }

    @objc func batteryLevelDidChange(notification: NSNotification) {
        if UIDevice.current.batteryLevel >= 0 {
            batteryLevel = UIDevice.current.batteryLevel * 100
        } else {
            batteryLevel = 100.0
        }
    }
}
