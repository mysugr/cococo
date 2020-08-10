// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "cococo",
    dependencies: [
        .package(url: "https://github.com/apple/swift-tools-support-core.git", from: "0.1.10"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "cococo",
            dependencies: ["cococoLibrary", .product(name: "SwiftToolsSupport-auto", package: "swift-tools-support-core")],
            path: "./cococo"),
        .target(
            name: "cococoLibrary",
            dependencies: [],
            path: "./cococoLibrary"),
        .testTarget(
            name: "cococoLibraryTests",
            dependencies: ["cococoLibrary"],
            path: "./cococoLibraryTests"),
    ]
)
