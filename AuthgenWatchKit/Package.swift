// swift-tools-version: 5.10

import PackageDescription

let package = Package(
  name: "AuthgenWatchKit",
  platforms: [.watchOS(.v10)],
  products: [
    .library(
      name: "AuthgenWatchKit",
      targets: ["AuthgenWatchKit"]
    )
  ],
  dependencies: [
    .package(path: "../Common"),
    .package(path: "../Domain"),
    .package(path: "../WatchFeatures"),
  ],
  targets: [
    .target(
      name: "AuthgenWatchKit",
      dependencies: [
        "Common",
        "Domain",
        "WatchFeatures",
      ]
    )
  ]
)
