// swift-tools-version: 5.10

import PackageDescription

let package = Package(
  name: "AuthgenKit",
  platforms: [.iOS(.v17), .macOS(.v14), .watchOS(.v10)],
  products: [
    .library(
      name: "AuthgenKit",
      targets: ["AuthgenKit"]
    )
  ],
  dependencies: [
    .package(path: "../Common"),
    .package(path: "../Domain"),
    .package(path: "../Features"),
  ],
  targets: [
    .target(
      name: "AuthgenKit",
      dependencies: [
        "Common",
        "Domain",
        "Features",
      ]
    )
  ]
)
