// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ZenMWS",
    products: [
        .library(
            name: "ZenMWS",
            targets: ["ZenMWS"]),
    ],
    dependencies: [
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", .branch("master")),
        .package(url: "https://github.com/tadija/AEXML.git", .branch("master")),
    ],
    targets: [
        .target(
            name: "ZenMWS",
            dependencies: ["CryptoSwift", "AEXML"]),
        .testTarget(
            name: "ZenMWSTests",
            dependencies: ["ZenMWS"]),
    ]
)
