// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Prettier",
    platforms: [ .macOS(.v10_15), .iOS(.v13), .tvOS(.v13) ],
    products: [
        .library(name: "Prettier", targets: ["Prettier"]),
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
    dependencies: [
        .package(name: "JXKit", url: "https://github.com/jectivex/JXKit.git", .upToNextMajor(from: "3.0.0"))
    ],
    targets: [
        .target(name: "Prettier", dependencies: [.byName(name: "JXKit")], resources: [.copy("standalone.js")]),
        .target(name: "PrettierBabel", dependencies: ["Prettier"], resources: [.copy("parser-babel.js")]),
        .target(name: "PrettierEspree", dependencies: ["Prettier"], resources: [.copy("parser-espree.js")]),
        .target(name: "PrettierFlow", dependencies: ["Prettier"], resources: [.copy("parser-flow.js")]),
        .target(name: "PrettierGlimmer", dependencies: ["Prettier"], resources: [.copy("parser-glimmer.js")]),
        .target(name: "PrettierGraphQL", dependencies: ["Prettier"], resources: [.copy("parser-graphql.js")]),
        .target(name: "PrettierHTML", dependencies: ["Prettier"], resources: [.copy("parser-html.js")]),
        .target(name: "PrettierMarkdown", dependencies: ["Prettier"], resources: [.copy("parser-markdown.js")]),
        .target(name: "PrettierMeriyah", dependencies: ["Prettier"], resources: [.copy("parser-meriyah.js")]),
        .target(name: "PrettierPHP", dependencies: ["Prettier"], resources: [.copy("parser-php.js")]),
        .target(name: "PrettierPostCSS", dependencies: ["Prettier"], resources: [.copy("parser-postcss.js")]),
        .target(name: "PrettierTypeScript", dependencies: ["Prettier"], resources: [.copy("parser-typescript.js")]),
        .target(name: "PrettierYAML", dependencies: ["Prettier"], resources: [.copy("parser-yaml.js")]),
        .testTarget(name: "PrettierTests", dependencies: [
            "Prettier",
            "PrettierBabel",
            "PrettierMarkdown",
            "PrettierPHP",
            "PrettierPostCSS",
            "PrettierHTML"
        ])
    ]
)
