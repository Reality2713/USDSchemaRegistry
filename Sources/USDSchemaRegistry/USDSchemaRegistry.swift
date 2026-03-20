import Foundation

/// The canonical catalog of known USD schemas across all ecosystems.
///
/// This registry is the source of truth for schema graduation status,
/// tier classification, and lifecycle state. Consuming tools (validators,
/// inspectors, agents) query the registry to understand what a schema is
/// and how to treat it.
public enum USDSchemaRegistry {

  // MARK: - Ecosystems

  public static let ecosystems: [USDSchemaEcosystem] = [
    .openUSDCore,
    .openUSDDomains,
    .applePreliminary,
    .appleRealityKit,
    .nvidiaOmniverse,
  ]

  // MARK: - Full catalog

  public static let all: [USDSchemaDescriptor] = openUSDDomainSchemas
    + applePreliminarySchemas
    + appleRealityKitSchemas
    + nvidiaOmniverseSchemas

  // MARK: - Queries

  public static func schemas(for origin: USDSchemaOrigin) -> [USDSchemaDescriptor] {
    all.filter { $0.origin == origin }
  }

  public static func schemas(in ecosystemID: String) -> [USDSchemaDescriptor] {
    all.filter { $0.ecosystemID == ecosystemID }
  }

  public static func schemas(withTier tier: USDSchemaTier) -> [USDSchemaDescriptor] {
    all.filter { $0.tier == tier }
  }

  public static func descriptor(forTypeName typeName: String) -> USDSchemaDescriptor? {
    all.first { $0.typeName == typeName }
  }

  public static func ecosystem(forID id: String) -> USDSchemaEcosystem? {
    ecosystems.first { $0.id == id }
  }

  public static var preliminary: [USDSchemaDescriptor] {
    all.filter { $0.tier == .preliminary }
  }

  public static var vendor: [USDSchemaDescriptor] {
    all.filter { $0.tier == .vendor }
  }

  public static var superseded: [USDSchemaDescriptor] {
    all.filter {
      if case .superseded = $0.lifecycle { return true }
      return false
    }
  }
}

// MARK: - OpenUSD Domain Schemas

extension USDSchemaRegistry {
  static let openUSDDomainSchemas: [USDSchemaDescriptor] = [
    USDSchemaDescriptor(
      id: "UsdGeom",
      typeName: "UsdGeom",
      domain: "UsdGeom",
      namespace: "geomTokens:",
      origin: .pixar,
      tier: .domain(spec: .workingGroupDraft),
      ecosystemID: "openusd_domains",
      docsURL: URL(string: "https://openusd.org/dev/api/usd_geom_page_front.html"),
      notes: "AOUSD Geometry WG drafting normative spec. Mesh, curves, points, scopes, bounds.",
      lastVerified: "2026-03-20"
    ),
    USDSchemaDescriptor(
      id: "UsdShade",
      typeName: "UsdShade",
      domain: "UsdShade",
      namespace: "material: / shader: / inputs:",
      origin: .pixar,
      tier: .domain(spec: .workingGroupDraft),
      ecosystemID: "openusd_domains",
      docsURL: URL(string: "https://openusd.org/dev/api/usd_shade_page_front.html"),
      notes: "AOUSD Materials WG drafting MaterialX interchange spec. UsdPreviewSurface, NodeGraph, bindings.",
      lastVerified: "2026-03-20"
    ),
    USDSchemaDescriptor(
      id: "UsdSkel",
      typeName: "UsdSkel",
      domain: "UsdSkel",
      namespace: "skel:",
      origin: .pixar,
      tier: .domain(spec: .deFactoStable),
      ecosystemID: "openusd_domains",
      docsURL: URL(string: "https://openusd.org/dev/api/usd_skel_page_front.html"),
      notes: "Skeleton, SkelAnimation, blend shapes, skinning. No AOUSD WG yet.",
      lastVerified: "2026-03-20"
    ),
    USDSchemaDescriptor(
      id: "UsdLux",
      typeName: "UsdLux",
      domain: "UsdLux",
      namespace: "light:",
      origin: .pixar,
      tier: .domain(spec: .deFactoStable),
      ecosystemID: "openusd_domains",
      docsURL: URL(string: "https://openusd.org/dev/api/usd_lux_page_front.html"),
      notes: "DiskLight, DistantLight, DomeLight, RectLight, SphereLight, etc.",
      lastVerified: "2026-03-20"
    ),
    USDSchemaDescriptor(
      id: "UsdPhysics",
      typeName: "UsdPhysics",
      domain: "UsdPhysics",
      namespace: "physics:",
      origin: .pixar,
      tier: .domain(spec: .workingGroupDraft),
      ecosystemID: "openusd_domains",
      docsURL: URL(string: "https://openusd.org/dev/api/usd_physics_page_front.html"),
      notes: "AOUSD Physics WG drafting rigid-body spec. Planned extension to soft-body.",
      lastVerified: "2026-03-20"
    ),
    USDSchemaDescriptor(
      id: "UsdUI_AccessibilityAPI",
      typeName: "AccessibilityAPI",
      domain: "UsdUI",
      namespace: "accessibility:",
      origin: .pixar,
      tier: .domain(spec: .deFactoStable),
      ecosystemID: "openusd_domains",
      docsURL: URL(string: "https://openusd.org/release/user_guides/schemas/usdUI/AccessibilityAPI.html"),
      notes: "Multiple-apply schema. Attributes: accessibility:<instance>:label, :description, :priority (low/standard/high). Canonical since OpenUSD 25.05. Supersedes Apple's Preliminary_AccessibilityAPI.",
      lastVerified: "2026-03-20"
    ),
    USDSchemaDescriptor(
      id: "UsdUI_Hints",
      typeName: "UsdUIObjectHints",
      domain: "UsdUI",
      namespace: "ui: / uiHints:",
      origin: .pixar,
      tier: .domain(spec: .deFactoStable),
      ecosystemID: "openusd_domains",
      docsURL: URL(string: "https://openusd.org/dev/api/usd_u_i_page_front.html"),
      notes: "UsdUIObjectHints, UsdUIPropertyHints, UsdUIAttributeHints. DCC display metadata. Added in OpenUSD 25.05.",
      lastVerified: "2026-03-20"
    ),
    USDSchemaDescriptor(
      id: "UsdMedia_SpatialAudio",
      typeName: "SpatialAudio",
      domain: "UsdMedia",
      namespace: "audio:",
      origin: .pixar,
      tier: .domain(spec: .deFactoStable),
      ecosystemID: "openusd_domains",
      docsURL: URL(string: "https://openusd.org/dev/api/usd_media_page_front.html"),
      notes: "Spatial audio playback within USD stages. Relevant for visionOS.",
      lastVerified: "2026-03-20"
    ),
    USDSchemaDescriptor(
      id: "UsdVol",
      typeName: "UsdVol",
      domain: "UsdVol",
      namespace: "volume:",
      origin: .pixar,
      tier: .domain(spec: .deFactoStable),
      ecosystemID: "openusd_domains",
      docsURL: URL(string: "https://openusd.org/dev/api/usd_vol_page_front.html"),
      notes: "OpenVDB volumes. Not supported by RealityKit.",
      lastVerified: "2026-03-20"
    ),
    USDSchemaDescriptor(
      id: "UsdRender",
      typeName: "UsdRender",
      domain: "UsdRender",
      namespace: "render:",
      origin: .pixar,
      tier: .domain(spec: .deFactoStable),
      ecosystemID: "openusd_domains",
      docsURL: URL(string: "https://openusd.org/dev/api/usd_render_page_front.html"),
      notes: "Render settings prims. Relevant for Hydra-based renderers, not RealityKit.",
      lastVerified: "2026-03-20"
    ),
    USDSchemaDescriptor(
      id: "UsdProc",
      typeName: "UsdProc",
      domain: "UsdProc",
      namespace: "proc:",
      origin: .pixar,
      tier: .domain(spec: .deFactoStable),
      ecosystemID: "openusd_domains",
      docsURL: URL(string: "https://openusd.org/dev/api/usd_proc_page_front.html"),
      notes: "Procedural generation schemas. Niche usage.",
      lastVerified: "2026-03-20"
    ),
  ]
}

// MARK: - Apple Preliminary Schemas

extension USDSchemaRegistry {
  static let applePreliminarySchemas: [USDSchemaDescriptor] = [
    USDSchemaDescriptor(
      id: "Apple_AnchoringAPI",
      typeName: "Preliminary_AnchoringAPI",
      namespace: "preliminary:anchoring: / preliminary:planeAnchoring:",
      origin: .apple,
      tier: .preliminary,
      ecosystemID: "apple_preliminary",
      docsURL: URL(string: "https://developer.apple.com/documentation/usd/usd-schemas-for-ar"),
      notes: "Anchors content to real-world planes, images, or faces.",
      lastVerified: "2026-03-20"
    ),
    USDSchemaDescriptor(
      id: "Apple_Behavior",
      typeName: "Preliminary_Behavior",
      namespace: "rel triggers / rel actions",
      origin: .apple,
      tier: .preliminary,
      ecosystemID: "apple_preliminary",
      notes: "Interactive trigger-action pairs for AR experiences.",
      lastVerified: "2026-03-20"
    ),
    USDSchemaDescriptor(
      id: "Apple_Trigger",
      typeName: "Preliminary_Trigger",
      namespace: "info:id",
      origin: .apple,
      tier: .preliminary,
      ecosystemID: "apple_preliminary",
      notes: "Event definitions (TapGesture, ProximityToCamera, SceneTransition).",
      lastVerified: "2026-03-20"
    ),
    USDSchemaDescriptor(
      id: "Apple_Action",
      typeName: "Preliminary_Action",
      namespace: "info:id",
      origin: .apple,
      tier: .preliminary,
      ecosystemID: "apple_preliminary",
      notes: "Actions performed when triggers execute (PlayTimeline, Impulse, Group).",
      lastVerified: "2026-03-20"
    ),
    USDSchemaDescriptor(
      id: "Apple_Text",
      typeName: "Preliminary_Text",
      namespace: "content / font / pointSize / depth",
      origin: .apple,
      tier: .preliminary,
      ecosystemID: "apple_preliminary",
      notes: "3D extruded text geometry with font, size, and alignment properties.",
      lastVerified: "2026-03-20"
    ),
    USDSchemaDescriptor(
      id: "Apple_ReferenceImage",
      typeName: "Preliminary_ReferenceImage",
      namespace: "image / physicalWidth",
      origin: .apple,
      tier: .preliminary,
      ecosystemID: "apple_preliminary",
      notes: "Image anchoring reference with physical dimensions.",
      lastVerified: "2026-03-20"
    ),
    USDSchemaDescriptor(
      id: "Apple_PhysicsRigidBodyAPI",
      typeName: "Preliminary_PhysicsRigidBodyAPI",
      namespace: "preliminary:physics:rigidBody:",
      origin: .apple,
      tier: .preliminary,
      ecosystemID: "apple_preliminary",
      notes: "Mass and activation state for rigid body simulation.",
      lastVerified: "2026-03-20"
    ),
    USDSchemaDescriptor(
      id: "Apple_PhysicsMaterialAPI",
      typeName: "Preliminary_PhysicsMaterialAPI",
      namespace: "preliminary:physics:material:",
      origin: .apple,
      tier: .preliminary,
      ecosystemID: "apple_preliminary",
      notes: "Restitution and friction coefficients for physics materials.",
      lastVerified: "2026-03-20"
    ),
    USDSchemaDescriptor(
      id: "Apple_PhysicsColliderAPI",
      typeName: "Preliminary_PhysicsColliderAPI",
      namespace: "preliminary:physics:collider:",
      origin: .apple,
      tier: .preliminary,
      ecosystemID: "apple_preliminary",
      notes: "Convex collision shapes for physics simulation.",
      lastVerified: "2026-03-20"
    ),
    USDSchemaDescriptor(
      id: "Apple_PhysicsGravitationalForce",
      typeName: "Preliminary_PhysicsGravitationalForce",
      namespace: "preliminary:physics:gravitationalForce:",
      origin: .apple,
      tier: .preliminary,
      ecosystemID: "apple_preliminary",
      notes: "Gravity field for physics simulations.",
      lastVerified: "2026-03-20"
    ),
    USDSchemaDescriptor(
      id: "Apple_InfiniteColliderPlane",
      typeName: "Preliminary_InfiniteColliderPlane",
      origin: .apple,
      tier: .preliminary,
      ecosystemID: "apple_preliminary",
      notes: "Infinite collision plane for floors and walls.",
      lastVerified: "2026-03-20"
    ),
    USDSchemaDescriptor(
      id: "Apple_AccessibilityAPI_old",
      typeName: "Preliminary_AccessibilityAPI",
      namespace: "preliminary:accessibilityLabel / preliminary:accessibilityDescription",
      origin: .apple,
      tier: .preliminary,
      lifecycle: .superseded(by: "UsdUI.AccessibilityAPI"),
      ecosystemID: "apple_preliminary",
      notes: "Old flat-attribute Apple schema. Replaced by canonical usdUI:AccessibilityAPI in OpenUSD 25.05.",
      lastVerified: "2026-03-20"
    ),
  ]
}

// MARK: - Apple RealityKit Proprietary Schemas

extension USDSchemaRegistry {
  static let appleRealityKitSchemas: [USDSchemaDescriptor] = [
    USDSchemaDescriptor(
      id: "Apple_RealityKitTimeline",
      typeName: "RealityKitTimeline",
      origin: .apple,
      tier: .vendor,
      ecosystemID: "apple_realitykit",
      notes: "Declarative animation timeline container. Authored by Reality Composer Pro.",
      lastVerified: "2026-03-20"
    ),
    USDSchemaDescriptor(
      id: "Apple_RealityKitTrack",
      typeName: "RealityKitTrack",
      origin: .apple,
      tier: .vendor,
      ecosystemID: "apple_realitykit",
      notes: "Animation track within a RealityKitTimeline.",
      lastVerified: "2026-03-20"
    ),
    USDSchemaDescriptor(
      id: "Apple_RealityKitAction",
      typeName: "RealityKitAction",
      origin: .apple,
      tier: .vendor,
      ecosystemID: "apple_realitykit",
      notes: "Individual action with type (spin, orbit, emphasize, playAudio), startTime, duration.",
      lastVerified: "2026-03-20"
    ),
    USDSchemaDescriptor(
      id: "Apple_RealityKitComponent",
      typeName: "RealityKitComponent",
      origin: .apple,
      tier: .vendor,
      ecosystemID: "apple_realitykit",
      notes: "ECS component data. Dynamic user-defined components parsed via realitytool.",
      lastVerified: "2026-03-20"
    ),
  ]
}

// MARK: - NVIDIA Omniverse Schemas

extension USDSchemaRegistry {
  static let nvidiaOmniverseSchemas: [USDSchemaDescriptor] = [
    USDSchemaDescriptor(
      id: "Nvidia_PhysXSchema",
      typeName: "PhysXSchema",
      namespace: "physxRigidBody: / physxCollision: / physxArticulation:",
      origin: .nvidia,
      tier: .vendor,
      ecosystemID: "nvidia_omniverse",
      docsURL: URL(string: "https://docs.omniverse.nvidia.com/kit/docs/omni_physics/latest/extensions/runtime/source/omni.physx/docs/index.html"),
      notes: "Extends canonical UsdPhysics with NVIDIA PhysX simulation features: articulations, joints, GPU settings.",
      lastVerified: "2026-03-20"
    ),
    USDSchemaDescriptor(
      id: "Nvidia_OmniGraph",
      typeName: "OmniGraph",
      namespace: "omni:graph:",
      origin: .nvidia,
      tier: .vendor,
      ecosystemID: "nvidia_omniverse",
      docsURL: URL(string: "https://docs.omniverse.nvidia.com/kit/docs/omni.graph.docs/latest/dev/Usd.html"),
      notes: "Procedural/compute graph in USD. Analogous to RealityKit behaviors but general-purpose.",
      lastVerified: "2026-03-20"
    ),
    USDSchemaDescriptor(
      id: "Nvidia_Geospatial",
      typeName: "OmniGeospatial",
      namespace: "omni:geospatial:",
      origin: .nvidia,
      tier: .vendor,
      ecosystemID: "nvidia_omniverse",
      docsURL: URL(string: "https://docs.omniverse.nvidia.com/kit/docs/omni.usd.schema.geospatial/latest/Overview.html"),
      notes: "WGS84 coordinate systems, geodetic positions for AEC/digital twin workflows.",
      lastVerified: "2026-03-20"
    ),
    USDSchemaDescriptor(
      id: "Nvidia_Replicator",
      typeName: "OmniReplicator",
      namespace: "replicator:",
      origin: .nvidia,
      tier: .vendor,
      ecosystemID: "nvidia_omniverse",
      docsURL: URL(string: "https://docs.omniverse.nvidia.com/extensions/latest/ext_replicator.html"),
      notes: "Synthetic data generation pipeline schemas for AI training.",
      lastVerified: "2026-03-20"
    ),
  ]
}
