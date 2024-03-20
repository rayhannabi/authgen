// swift-tools-version: 5.10

import PackageDescription

let package = Package(
  name: "Common",
  platforms: [.iOS(.v17), .macOS(.v14), .watchOS(.v10)],
  products: [
    .library(
      name: "Common",
      targets: ["Common"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.8.0"),
    .package(url: "https://github.com/tgrapperon/swift-dependencies-additions", from: "1.0.0"),
    .package(path: "../Utilities"),
  ],
  targets: [
    .target(
      name: "Common",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "DependenciesAdditions", package: "swift-dependencies-additions"),
        "Utilities",
      ]
    ),
    .testTarget(
      name: "CommonTests",
      dependencies: ["Common"]
    ),
  ]
)
