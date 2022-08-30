// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "Inspire",
    platforms: [.iOS(.v9)],
    products: [
        .library(name: "Inspire", targets: ["Inspire"]),
    ],
    targets: [
        .target(
            name: "Inspire",
            dependencies: []
        )
    ]
)
