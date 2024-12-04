import UIKit
import SwiftUI

// TimerViewController для работы с таймером и отображением
class TimerViewController: UIViewController {

    var timer: Timer?
    var counter: Int = 0
    var timerModel: TimerModel?
    var isAppInBackground = false

    // Добавляем UILabel для отображения таймера
    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "Timer: 0"
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("[TimerViewController] onCreate - App is starting fresh")
        
        // Настройка интерфейса
        view.backgroundColor = .white
        view.addSubview(timerLabel)
        
        // Устанавливаем ограничения для метки
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        // Добавляем наблюдателей на события фона и переднего плана
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("[TimerViewController] onStart - App is about to appear")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("[TimerViewController] onResume - App is now running")
        startTimer()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("[TimerViewController] onPause - App is about to go to background")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("[TimerViewController] onStop - App is no longer visible")
    }

    func startTimer() {
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.counter += 1
            self.timerModel?.counter = self.counter
            self.updateTimerLabel() // Обновляем метку на экране
            print("[TimerViewController] Counter: \(self.counter)")
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
        print("[TimerViewController] Timer stopped")
    }

    func updateTimerLabel() {
        timerLabel.text = "Timer: \(counter)"
    }

    // Обработчик для входа в передний план
    @objc func appWillEnterForeground() {
        print("[TimerViewController] App has returned to foreground")
        startTimer()
    }

    // Обработчик для входа в фон
    @objc func appDidEnterBackground() {
        print("[TimerViewController] App has entered background")
        stopTimer()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// BackgroundChangerViewController для смены фона
class BackgroundChangerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("[BackgroundChangerViewController] onCreate - App is starting fresh")
        view.backgroundColor = .white
        
        let changeColorButton = UIButton(type: .system)
        changeColorButton.setTitle("Change Background Color", for: .normal)
        changeColorButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        changeColorButton.translatesAutoresizingMaskIntoConstraints = false
        changeColorButton.addTarget(self, action: #selector(changeBackgroundColor), for: .touchUpInside)
        view.addSubview(changeColorButton)
        
        NSLayoutConstraint.activate([
            changeColorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeColorButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func changeBackgroundColor() {
        view.backgroundColor = UIColor(
            red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: 1.0
        )
        print("[BackgroundChangerViewController] Background color changed")
    }

    @objc func appWillEnterForeground() {
        print("[BackgroundChangerViewController] App has resumed")
    }
    
    @objc func appDidEnterBackground(){
        print("[BackgroundChangerViewController] App is paused")
    }
}

// MainTabBarController для переключения между вкладками
class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    let timerVC = TimerViewController()
    let backgroundChangerVC = BackgroundChangerViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        timerVC.tabBarItem = UITabBarItem(title: "Timer", image: UIImage(systemName: "timer"), tag: 0)
        backgroundChangerVC.tabBarItem = UITabBarItem(title: "Change Background", image: UIImage(systemName: "paintbrush"), tag: 1)
        
        viewControllers = [timerVC, backgroundChangerVC]
        self.delegate = self
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 0 {
            print("[MainTabBarController] Timer App is resumed")
            timerVC.startTimer()
            backgroundChangerVC.appDidEnterBackground()
        } else if item.tag == 1 {
            print("[MainTabBarController] Timer App is paused, BackgroundChanger continues")
            timerVC.stopTimer()
            backgroundChangerVC.appWillEnterForeground()
        }
    }
}
