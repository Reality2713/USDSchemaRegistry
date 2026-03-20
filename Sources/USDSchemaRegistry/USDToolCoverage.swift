/// Declares how well a specific tool covers each schema in the registry.
///
/// Each consuming tool (validator, inspector, agent) creates its own
/// `USDToolCoverage` instance. The registry itself is neutral — it
/// describes what schemas exist; this type describes how well a tool
/// handles them.
///
/// ```swift
/// let preflight = USDToolCoverage(entries: [
///   "UsdGeom": .good,
///   "UsdShade": .good,
///   "UsdUI_AccessibilityAPI": .detected,
/// ])
/// preflight.coverage(for: "UsdGeom")  // .good
/// preflight.gaps()                     // schemas with .none coverage
/// ```
public struct USDToolCoverage: Hashable, Sendable, Codable {
  /// Schema ID → coverage level.
  public var entries: [String: USDSchemaCoverage]

  public init(entries: [String: USDSchemaCoverage] = [:]) {
    self.entries = entries
  }

  /// Returns the coverage level for a schema ID, defaulting to `.none`.
  public func coverage(for schemaID: String) -> USDSchemaCoverage {
    entries[schemaID] ?? .none
  }

  /// All registry schemas that this tool does not cover at all.
  public func gaps() -> [USDSchemaDescriptor] {
    USDSchemaRegistry.all.filter { coverage(for: $0.id) == .none }
  }

  /// All registry schemas that this tool covers at the given level or above.
  public func schemas(atOrAbove level: USDSchemaCoverage) -> [USDSchemaDescriptor] {
    USDSchemaRegistry.all.filter { coverage(for: $0.id) >= level }
  }

  /// Summary: count of schemas at each coverage level.
  public func summary() -> [USDSchemaCoverage: Int] {
    var counts: [USDSchemaCoverage: Int] = [:]
    for level in USDSchemaCoverage.allCases {
      counts[level] = 0
    }
    for schema in USDSchemaRegistry.all {
      let level = coverage(for: schema.id)
      counts[level, default: 0] += 1
    }
    return counts
  }
}
