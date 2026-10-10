// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "InternalOSSettings",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .executable(
            name: "InternalOSSettings",
            targets: ["InternalOSSettings"]
        )
    ],
    targets: [
        .executableTarget(
            name: "InternalOSSettings",
            path: "Sources/InternalOSSettings"
        )
    ]
)
