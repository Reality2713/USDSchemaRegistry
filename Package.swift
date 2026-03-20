// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "USDSchemaRegistry",
  platforms: [
    .macOS(.v14),
    .iOS(.v17),
    .visionOS(.v1),
  ],
  products: [
    .library(name: "USDSchemaRegistry", targets: ["USDSchemaRegistry"]),
  ],
  targets: [
    .target(name: "USDSchemaRegistry"),
    .testTarget(
      name: "USDSchemaRegistryTests",
      dependencies: [
        "USDSchemaRegistry"
      ]
    ),
  ]
)
