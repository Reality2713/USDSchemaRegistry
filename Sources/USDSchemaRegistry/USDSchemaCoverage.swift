/// How well a consuming tool covers a schema's validation surface.
///
/// Ordered from least to most coverage — supports `Comparable`.
public enum USDSchemaCoverage: Int, Hashable, Sendable, Codable, Comparable, CaseIterable {
  /// Schema not detected or validated at all.
  case none = 0
  /// Prim type detected, path collected, no attribute reading.
  case detectedPathOnly = 1
  /// Prim type detected with key attributes read and surfaced.
  case detected = 2
  /// Some validation rules implemented, meaningful gaps remain.
  case partial = 3
  /// Core validation rules implemented, minor gaps only.
  case good = 4
  /// Comprehensive validation including all critical attributes and relationships.
  case full = 5

  public static func < (lhs: USDSchemaCoverage, rhs: USDSchemaCoverage) -> Bool {
    lhs.rawValue < rhs.rawValue
  }
}
