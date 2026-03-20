import Foundation

/// A single schema entry in the registry.
///
/// Captures what the schema is, who owns it, where it sits in the
/// standardization hierarchy, and how well a consuming tool covers it.
public struct USDSchemaDescriptor: Identifiable, Hashable, Sendable, Codable {
  /// Stable identifier for this schema entry.
  public let id: String
  /// The USD type name as it appears in scene description (e.g. `"Preliminary_AnchoringAPI"`).
  public let typeName: String
  /// The domain this schema belongs to, if any (e.g. `"UsdGeom"`, `"UsdUI"`).
  public let domain: String?
  /// Attribute namespace prefix (e.g. `"accessibility:"`, `"preliminary:anchoring:"`).
  public let namespace: String?
  /// Who authored or proposed this schema.
  public let origin: USDSchemaOrigin
  /// Where this schema sits in the standardization hierarchy.
  public let tier: USDSchemaTier
  /// Whether this schema is active, superseded, or deprecated.
  public let lifecycle: USDSchemaLifecycle
  /// The ecosystem this schema belongs to (references ``USDSchemaEcosystem/id``).
  public let ecosystemID: String
  /// Documentation URL.
  public let docsURL: URL?
  /// Freeform notes about the schema.
  public let notes: String?
  /// ISO date string when this entry was last verified.
  public let lastVerified: String

  public init(
    id: String,
    typeName: String,
    domain: String? = nil,
    namespace: String? = nil,
    origin: USDSchemaOrigin,
    tier: USDSchemaTier,
    lifecycle: USDSchemaLifecycle = .active,
    ecosystemID: String,
    docsURL: URL? = nil,
    notes: String? = nil,
    lastVerified: String
  ) {
    self.id = id
    self.typeName = typeName
    self.domain = domain
    self.namespace = namespace
    self.origin = origin
    self.tier = tier
    self.lifecycle = lifecycle
    self.ecosystemID = ecosystemID
    self.docsURL = docsURL
    self.notes = notes
    self.lastVerified = lastVerified
  }
}
