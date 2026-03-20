/// The entity that authored or proposed a USD schema.
///
/// Used across both `preliminary` and `vendor` tiers — the same origin
/// can appear in either context.
public struct USDSchemaOrigin: Hashable, Sendable, Codable {
  public let id: String
  public let displayName: String

  public init(id: String, displayName: String) {
    self.id = id
    self.displayName = displayName
  }
}

extension USDSchemaOrigin {
  public static let pixar = USDSchemaOrigin(id: "pixar", displayName: "Pixar")
  public static let apple = USDSchemaOrigin(id: "apple", displayName: "Apple")
  public static let nvidia = USDSchemaOrigin(id: "nvidia", displayName: "NVIDIA")
  public static let aousd = USDSchemaOrigin(id: "aousd", displayName: "AOUSD")
}
