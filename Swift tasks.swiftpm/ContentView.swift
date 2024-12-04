import SwiftUI

struct ContentView: View {
    var body: some View {
        MainTabBarView()
            .edgesIgnoringSafeArea(.all)
    }
}

struct MainTabBarView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MainTabBarController {
        return MainTabBarController()
    }

    func updateUIViewController(_ uiViewController: MainTabBarController, context: Context) {
    }
}
