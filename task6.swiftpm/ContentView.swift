import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var batteryMonitor = BatteryMonitor()

    var body: some View {
        VStack {
            Text("Battery Level")
                .font(.largeTitle)
                .padding()
            
            Text(String(format: "%.0f%%", batteryMonitor.batteryLevel))
                .font(.system(size: 50, weight: .bold))
                .foregroundColor(.green)
                .padding()
        }
        .onAppear {
            UIDevice.current.isBatteryMonitoringEnabled = true
        }
    }
}
