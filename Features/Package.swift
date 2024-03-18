// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "Features",
  platforms: [.iOS(.v17), .macOS(.v14), .watchOS(.v10)],
  products: [
    .library(
      name: "Features",
      targets: ["Features"]
    ),
    .library(name: "Root", targets: ["Root"]),
    .library(name: "Home", targets: ["Home"]),
    .library(name: "OTPGen", targets: ["OTPGen"]),
  ],
  dependencies: [
    .package(path: "../Domain"),
    .package(path: "../Utilities"),
  ],
  targets: [
    .target(
      name: "Features",
      dependencies: ["Root"]
    ),
    .target(
      name: "Root",
      dependencies: [
        "Utilities",
        "Domain",
        "Home",
      ]
    ),
    .target(
      name: "Home",
      dependencies: [
        "Domain",
        "OTPGen",
        "Utilities",
      ]
    ),
    .target(
      name: "OTPGen",
      dependencies: [
        "Utilities",
        "Domain",
      ]
    ),
    .testTarget(
      name: "FeaturesTests",
      dependencies: ["Features", "Root"]
    ),
  ]
)
