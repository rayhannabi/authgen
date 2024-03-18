// swift-tools-version: 5.10

import PackageDescription

let package = Package(
  name: "Utilities",
  platforms: [.iOS(.v17), .macOS(.v14), .watchOS(.v10)],
  products: [
    .library(
      name: "Utilities",
      targets: ["Utilities"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.8.0"),
    .package(url: "https://github.com/tgrapperon/swift-dependencies-additions", from: "1.0.0"),
  ],
  targets: [
    .target(
      name: "Utilities",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "DependenciesAdditions", package: "swift-dependencies-additions"),
      ]
    ),
    .testTarget(
      name: "UtilitiesTests",
      dependencies: ["Utilities"]
    ),
  ]
)
