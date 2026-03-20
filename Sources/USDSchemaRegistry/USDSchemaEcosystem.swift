import Foundation

/// A vendor or standards body ecosystem that produces USD schemas.
public struct USDSchemaEcosystem: Hashable, Sendable, Codable, Identifiable {
  public let id: String
  public let name: String
  public let description: String
  public let governedBy: String
  public let specURL: URL?
  public let origin: USDSchemaOrigin

  public init(
    id: String,
    name: String,
    description: String,
    governedBy: String,
    specURL: URL? = nil,
    origin: USDSchemaOrigin
  ) {
    self.id = id
    self.name = name
    self.description = description
    self.governedBy = governedBy
    self.specURL = specURL
    self.origin = origin
  }
}

extension USDSchemaEcosystem {
  public static let openUSDCore = USDSchemaEcosystem(
    id: "openusd_core",
    name: "OpenUSD Core",
    description: "The data model layer: composition, value resolution, file formats. Governed by AOUSD Core Spec.",
    governedBy: "AOUSD Core Specification",
    specURL: URL(string: "https://aousd.org/news/core-spec-announcement/"),
    origin: .aousd
  )

  public static let openUSDDomains = USDSchemaEcosystem(
    id: "openusd_domains",
    name: "OpenUSD Domain Schemas",
    description: "Domain-specific schemas built on the core. Stable in OpenUSD codebase; AOUSD working groups are formalizing them as normative specs.",
    governedBy: "OpenUSD project (Pixar) + AOUSD working groups",
    specURL: URL(string: "https://openusd.org/dev/user_guides/schemas/index.html"),
    origin: .pixar
  )

  public static let applePreliminary = USDSchemaEcosystem(
    id: "apple_preliminary",
    name: "Apple Preliminary AR Schemas",
    description: "Schemas developed jointly by Apple and Pixar for AR/spatial computing. Still carry Preliminary_ prefix.",
    governedBy: "Apple",
    specURL: URL(string: "https://developer.apple.com/documentation/usd/usd-schemas-for-ar"),
    origin: .apple
  )

  public static let appleRealityKit = USDSchemaEcosystem(
    id: "apple_realitykit",
    name: "Apple RealityKit Proprietary Schemas",
    description: "Proprietary Apple schemas authored by Reality Composer Pro. Not part of any open standard.",
    governedBy: "Apple",
    origin: .apple
  )

  public static let nvidiaOmniverse = USDSchemaEcosystem(
    id: "nvidia_omniverse",
    name: "NVIDIA Omniverse USD Extensions",
    description: "NVIDIA-proprietary USD extensions using the omni: namespace prefix. Widely used in enterprise/industrial workflows.",
    governedBy: "NVIDIA",
    specURL: URL(string: "https://docs.omniverse.nvidia.com/usd/latest/usd_schemas.html"),
    origin: .nvidia
  )
}
