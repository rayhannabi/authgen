// swift-tools-version: 5.10

import PackageDescription

let package = Package(
  name: "SharedFeatures",
  platforms: [.iOS(.v17), .macOS(.v14), .watchOS(.v10)],
  products: [
    .library(
      name: "SharedFeatures",
      targets: ["SharedFeatures"]
    ),
    .library(
      name: "OTPGenerator",
      targets: ["OTPGenerator"]
    ),
  ],
  dependencies: [
    .package(path: "../Common"),
    .package(path: "../Domain"),
  ],
  targets: [
    .target(
      name: "SharedFeatures",
      dependencies: [
        "OTPGenerator"
      ]
    ),
    .target(
      name: "OTPGenerator",
      dependencies: [
        "Common",
        "Domain",
      ]
    ),
    .testTarget(
      name: "SharedFeaturesTests",
      dependencies: ["SharedFeatures"]
    ),
  ]
)
