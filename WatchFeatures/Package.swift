// swift-tools-version: 5.10

import PackageDescription

let package = Package(
  name: "WatchFeatures",
  platforms: [.watchOS(.v10)],
  products: [
    .library(
      name: "WatchFeatures",
      targets: ["WatchFeatures"]
    ),
    .library(
      name: "WatchRoot",
      targets: ["WatchRoot"]
    ),
    .library(
      name: "WatchHome",
      targets: ["WatchHome"]
    )
  ],
  dependencies: [
    .package(path: "../Common"),
    .package(path: "../Domain"),
    .package(path: "../SharedFeatures"),
  ],
  targets: [
    .target(
      name: "WatchFeatures",
      dependencies: [
        "WatchRoot",
        "WatchHome",
      ]
    ),
    .target(
      name: "WatchRoot",
      dependencies: [
        "Common",
        "Domain",
        "WatchHome",
      ]
    ),
    .target(
      name: "WatchHome",
      dependencies: [
        "Common",
        "Domain",
        "SharedFeatures"
      ]
    ),
    .testTarget(
      name: "WatchFeaturesTests",
      dependencies: ["WatchFeatures"]
    ),
  ]
)
