// swift-tools-version: 5.10

import PackageDescription

let package = Package(
  name: "Features",
  platforms: [.iOS(.v17), .macOS(.v14), .watchOS(.v10)],
  products: [
    .library(name: "Features", targets: ["Features"]),
    .library(name: "Root", targets: ["Root"]),
    .library(name: "Home", targets: ["Home"]),
    .library(name: "OTPGen", targets: ["OTPGen"]),
    .library(name: "Settings", targets: ["Settings"]),
  ],
  dependencies: [
    .package(path: "../Common"),
    .package(path: "../Domain"),
  ],
  targets: [
    .target(
      name: "Features",
      dependencies: ["Root"]
    ),
    .target(
      name: "Root",
      dependencies: [
        "Common",
        "Domain",
        "Home",
        "Settings",
      ]
    ),
    .target(
      name: "Home",
      dependencies: [
        "Common",
        "Domain",
        "OTPGen",
      ]
    ),
    .target(
      name: "OTPGen",
      dependencies: [
        "Common",
        "Domain",
      ]
    ),
    .target(name: "Settings", dependencies: ["Common"]),
    .testTarget(
      name: "FeaturesTests",
      dependencies: ["Features", "Root"]
    ),
  ]
)
