/// Where a schema sits in the USD standardization hierarchy.
///
/// - ``core``: AOUSD Core Spec — composition, value resolution, file formats.
/// - ``domain``: Canonical domain schemas built on core (UsdGeom, UsdShade, UsdUI…).
/// - ``preliminary``: Proposed standard carrying `Preliminary_` prefix, on path to graduation.
/// - ``vendor``: Vendor-specific, closed schema unlikely to become canonical.
public enum USDSchemaTier: Hashable, Sendable, Codable {
  case core
  case domain(spec: DomainSpecStatus)
  case preliminary
  case vendor
}

/// Whether an AOUSD working group has published a normative spec for a domain.
public enum DomainSpecStatus: Hashable, Sendable, Codable {
  /// A normative spec has been published by AOUSD.
  case published(version: String)
  /// An AOUSD working group is actively drafting a spec.
  case workingGroupDraft
  /// Stable in OpenUSD codebase but no AOUSD normative spec exists yet.
  case deFactoStable
}
