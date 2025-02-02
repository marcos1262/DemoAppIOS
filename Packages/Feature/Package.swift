// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Feature",
    platforms: [
        .iOS(.v14), .macOS(.v11)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Feature",
            targets: ["Feature"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(path: "../UIComponents"),
        .package(path: "../ViewModels"),
        .package(path: "../Interfaces"),
        .package(url: "https://github.com/Quick/Quick.git", branch: "main"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "10.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Feature",
            dependencies: [
                "UIComponents",
                "ViewModels"
            ]
        ),
        .testTarget(
            name: "FeatureTests",
            dependencies: ["Feature", "Quick", "Nimble", .product(name: "InterfaceMocks", package: "Interfaces")]),
    ]
)
