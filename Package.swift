// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Prettier",
    products: [
        .library(name: "Prettier", targets: ["Prettier"]),
        .library(name: "PrettierAngular", targets: ["PrettierAngular"]),
        .library(name: "PrettierBabel", targets: ["PrettierBabel"]),
        .library(name: "PrettierEspree", targets: ["PrettierEspree"]),
        .library(name: "PrettierFlow", targets: ["PrettierFlow"]),
        .library(name: "PrettierGlimmer", targets: ["PrettierGlimmer"]),
        .library(name: "PrettierGraphQL", targets: ["PrettierGraphQL"]),
        .library(name: "PrettierHTML", targets: ["PrettierHTML"]),
        .library(name: "PrettierMarkdown", targets: ["PrettierMarkdown"]),
        .library(name: "PrettierMeriyah", targets: ["PrettierMeriyah"]),
        .library(name: "PrettierPHP", targets: ["PrettierPHP"]),
        .library(name: "PrettierPostCSS", targets: ["PrettierPostCSS"]),
        .library(name: "PrettierTypeScript", targets: ["PrettierTypeScript"]),
        .library(name: "PrettierYAML", targets: ["PrettierYAML"])
    ],
    targets: [
        .target(name: "Prettier", resources: [.copy("js")]),
        .target(name: "PrettierAngular", dependencies: ["Prettier"], resources: [.copy("js")]),
        .target(name: "PrettierBabel", dependencies: ["Prettier"], resources: [.copy("js")]),
        .target(name: "PrettierEspree", dependencies: ["Prettier"], resources: [.copy("js")]),
        .target(name: "PrettierFlow", dependencies: ["Prettier"], resources: [.copy("js")]),
        .target(name: "PrettierGlimmer", dependencies: ["Prettier"], resources: [.copy("js")]),
        .target(name: "PrettierGraphQL", dependencies: ["Prettier"], resources: [.copy("js")]),
        .target(name: "PrettierHTML", dependencies: ["Prettier"], resources: [.copy("js")]),
        .target(name: "PrettierMarkdown", dependencies: ["Prettier"], resources: [.copy("js")]),
        .target(name: "PrettierMeriyah", dependencies: ["Prettier"], resources: [.copy("js")]),
        .target(name: "PrettierPHP", dependencies: ["Prettier"], resources: [.copy("js")]),
        .target(name: "PrettierPostCSS", dependencies: ["Prettier"], resources: [.copy("js")]),
        .target(name: "PrettierTypeScript", dependencies: ["Prettier"], resources: [.copy("js")]),
        .target(name: "PrettierYAML", dependencies: ["Prettier"], resources: [.copy("js")]),
        .testTarget(name: "PrettierTests", dependencies: [
            "Prettier",
            "PrettierBabel",
            "PrettierMarkdown",
            "PrettierPHP",
            "PrettierHTML"
        ])
    ]
)
