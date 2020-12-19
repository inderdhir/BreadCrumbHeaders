// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BreadCrumbHeaders",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "BreadCrumbHeaders",
            targets: ["BreadCrumbHeaders"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "BreadCrumbHeaders",
            dependencies: []),
        .testTarget(
            name: "BreadCrumbHeadersTests",
            dependencies: ["BreadCrumbHeaders"]),
    ]
)
