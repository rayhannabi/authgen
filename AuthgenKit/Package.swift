// swift-tools-version: 5.9

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
    .package(path: "../Features"),
    .package(path: "../Domain"),
    .package(path: "../Utilities"),
  ],
  targets: [
    .target(
      name: "AuthgenKit",
      dependencies: [
        "Features",
        "Domain",
        "Utilities",
      ]
    )
  ]
)
