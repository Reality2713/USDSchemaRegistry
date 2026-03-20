import Testing
@testable import USDSchemaRegistry

@Suite("USDSchemaRegistry")
struct USDSchemaRegistryTests {

  @Test("All schemas have non-empty id and typeName")
  func allSchemasHaveRequiredFields() {
    for schema in USDSchemaRegistry.all {
      #expect(!schema.id.isEmpty)
      #expect(!schema.typeName.isEmpty)
      #expect(!schema.ecosystemID.isEmpty)
      #expect(!schema.lastVerified.isEmpty)
    }
  }

  @Test("Catalog is non-empty")
  func catalogIsNonEmpty() {
    #expect(USDSchemaRegistry.all.count > 0)
    #expect(USDSchemaRegistry.ecosystems.count > 0)
  }

  @Test("Schema IDs are unique")
  func schemaIDsAreUnique() {
    let ids = USDSchemaRegistry.all.map(\.id)
    #expect(Set(ids).count == ids.count)
  }

  @Test("Every schema references a valid ecosystem")
  func ecosystemReferencesAreValid() {
    let ecosystemIDs = Set(USDSchemaRegistry.ecosystems.map(\.id))
    for schema in USDSchemaRegistry.all {
      #expect(ecosystemIDs.contains(schema.ecosystemID),
              "\(schema.id) references unknown ecosystem '\(schema.ecosystemID)'")
    }
  }

  @Test("Query by origin returns correct schemas")
  func queryByOrigin() {
    let appleSchemas = USDSchemaRegistry.schemas(for: .apple)
    #expect(appleSchemas.allSatisfy { $0.origin == .apple })
    #expect(!appleSchemas.isEmpty)

    let nvidiaSchemas = USDSchemaRegistry.schemas(for: .nvidia)
    #expect(nvidiaSchemas.allSatisfy { $0.origin == .nvidia })
    #expect(!nvidiaSchemas.isEmpty)
  }

  @Test("Query by ecosystem ID")
  func queryByEcosystem() {
    let domainSchemas = USDSchemaRegistry.schemas(in: "openusd_domains")
    #expect(!domainSchemas.isEmpty)
    #expect(domainSchemas.allSatisfy { $0.ecosystemID == "openusd_domains" })
  }

  @Test("Lookup by typeName")
  func lookupByTypeName() {
    let accessibilityAPI = USDSchemaRegistry.descriptor(forTypeName: "AccessibilityAPI")
    #expect(accessibilityAPI != nil)
    #expect(accessibilityAPI?.domain == "UsdUI")

    let missing = USDSchemaRegistry.descriptor(forTypeName: "NonExistentSchema")
    #expect(missing == nil)
  }

  @Test("Preliminary filter")
  func preliminaryFilter() {
    let preliminary = USDSchemaRegistry.preliminary
    #expect(!preliminary.isEmpty)
    #expect(preliminary.allSatisfy { $0.tier == .preliminary })
  }

  @Test("Vendor filter")
  func vendorFilter() {
    let vendors = USDSchemaRegistry.vendor
    #expect(!vendors.isEmpty)
    #expect(vendors.allSatisfy { $0.tier == .vendor })
  }

  @Test("Superseded schemas include old AccessibilityAPI")
  func supersededSchemas() {
    let superseded = USDSchemaRegistry.superseded
    #expect(superseded.contains { $0.id == "Apple_AccessibilityAPI_old" })
  }

  @Test("Ecosystem lookup by ID")
  func ecosystemLookup() {
    let core = USDSchemaRegistry.ecosystem(forID: "openusd_core")
    #expect(core != nil)
    #expect(core?.name == "OpenUSD Core")

    let missing = USDSchemaRegistry.ecosystem(forID: "nonexistent")
    #expect(missing == nil)
  }

  @Test("USDSchemaCoverage is Comparable")
  func coverageComparable() {
    #expect(USDSchemaCoverage.none < USDSchemaCoverage.full)
    #expect(USDSchemaCoverage.partial < USDSchemaCoverage.good)
    #expect(USDSchemaCoverage.detected > USDSchemaCoverage.detectedPathOnly)
  }

  @Test("USDSchemaOrigin static constants")
  func originConstants() {
    #expect(USDSchemaOrigin.pixar.id == "pixar")
    #expect(USDSchemaOrigin.apple.id == "apple")
    #expect(USDSchemaOrigin.nvidia.id == "nvidia")
    #expect(USDSchemaOrigin.aousd.id == "aousd")
  }

  @Test("Tier equality")
  func tierEquality() {
    #expect(USDSchemaTier.core == USDSchemaTier.core)
    #expect(USDSchemaTier.preliminary == USDSchemaTier.preliminary)
    #expect(USDSchemaTier.vendor == USDSchemaTier.vendor)
    #expect(USDSchemaTier.core != USDSchemaTier.preliminary)
  }

  @Test("Tool coverage defaults to none")
  func toolCoverageDefault() {
    let coverage = USDToolCoverage()
    #expect(coverage.coverage(for: "UsdGeom") == .none)
  }

  @Test("Tool coverage returns declared level")
  func toolCoverageDeclared() {
    let coverage = USDToolCoverage(entries: [
      "UsdGeom": .good,
      "UsdShade": .partial,
    ])
    #expect(coverage.coverage(for: "UsdGeom") == .good)
    #expect(coverage.coverage(for: "UsdShade") == .partial)
    #expect(coverage.coverage(for: "UsdVol") == .none)
  }

  @Test("Tool coverage gaps returns uncovered schemas")
  func toolCoverageGaps() {
    let coverage = USDToolCoverage(entries: [
      "UsdGeom": .good,
    ])
    let gaps = coverage.gaps()
    #expect(!gaps.isEmpty)
    #expect(!gaps.contains { $0.id == "UsdGeom" })
  }

  @Test("Tool coverage schemas at or above level")
  func toolCoverageAtOrAbove() {
    let coverage = USDToolCoverage(entries: [
      "UsdGeom": .good,
      "UsdShade": .partial,
      "UsdSkel": .detected,
    ])
    let goodPlus = coverage.schemas(atOrAbove: .good)
    #expect(goodPlus.count == 1)
    #expect(goodPlus.first?.id == "UsdGeom")
  }

  @Test("Tool coverage summary counts")
  func toolCoverageSummary() {
    let coverage = USDToolCoverage(entries: [
      "UsdGeom": .good,
      "UsdShade": .good,
    ])
    let summary = coverage.summary()
    #expect(summary[.good] == 2)
    let totalCovered = USDSchemaRegistry.all.count
    #expect(summary[.none] == totalCovered - 2)
  }
}
