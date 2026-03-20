/// The lifecycle state of a schema — orthogonal to its tier.
///
/// Any schema in any tier can be active, superseded, or deprecated.
public enum USDSchemaLifecycle: Hashable, Sendable, Codable {
  /// Schema is current and actively maintained.
  case active
  /// Replaced by a canonical successor. Files may still contain old attributes.
  case superseded(by: String)
  /// Deprecated with no direct successor.
  case deprecated(reason: String)
}
