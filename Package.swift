// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Inspire",
    platforms: [.iOS(.v8)],
    products: [
        .library(name: "Inspire", targets: ["Inspire"]),
    ],
    targets: [
        .target(
            name: "Inspire",
            dependencies: [],
            path: "Source"
        )
    ],
    swiftLanguageVersions: [.v5]
)
