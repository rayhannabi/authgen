// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "AuthenticatorKit",
  platforms: [.iOS(.v17), .macOS(.v14), .watchOS(.v10)],
  products: [
    .library(
      name: "AuthenticatorKit",
      targets: ["AuthenticatorKit"]
    )
  ],
  dependencies: [
    .package(path: "../Features"),
    .package(path: "../Domain"),
    .package(path: "../Utilities"),
  ],
  targets: [
    .target(
      name: "AuthenticatorKit",
      dependencies: [
        "Features",
        "Domain",
        "Utilities",
      ]
    )
  ]
)
