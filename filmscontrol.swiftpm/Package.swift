// swift-tools-version: 5.6

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "filmscontrol",
    platforms: [
        .iOS("15.2")
    ],
    products: [
        .iOSApplication(
            name: "filmscontrol",
            targets: ["AppModule"],
            bundleIdentifier: "task.filmscontrol",
            teamIdentifier: "8D4N5A4FG6",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .lightningBolt),
            accentColor: .presetColor(.mint),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/stephencelis/SQLite.swift", from: "0.13.2") 
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            dependencies: [
                .product(name: "SQLite", package: "SQLite.swift")
            ],
            path: "."
        )
    ]
)
