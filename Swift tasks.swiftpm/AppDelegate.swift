import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("App is about to terminate (deinit equivalent)")
    }
}
