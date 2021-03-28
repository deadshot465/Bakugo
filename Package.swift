// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Bakugo",
    dependencies: [
        .package(url: "https://github.com/Azoy/Sword", .branch("master"))
    ],
    targets: [
        .target(
            name: "Bakugo",
            dependencies: ["Sword"]),
        .testTarget(
            name: "SwiftTests",
            dependencies: ["Bakugo"]),
    ]
)
