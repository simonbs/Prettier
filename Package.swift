// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Prettier",
    products: [
        .library(name: "Prettier", targets: ["Prettier"])
    ],
    targets: [
        .target(name: "Prettier", resources: [.copy("js")]),
        .testTarget(name: "PrettierTests", dependencies: ["Prettier"])
    ]
)
