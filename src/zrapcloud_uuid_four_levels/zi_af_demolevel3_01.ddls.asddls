@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forDemoLevel3'
define view entity ZI_AF_DEMOLEVEL3_01
  as select from ZUUID_LEVEL_3
  association to parent ZI_AF_DemoLevel2_01 as _DemoLevel2 on $projection.ParentUUID = _DemoLevel2.UuidLevel2
  association [1] to ZI_AF_DemoLevel1_01 as _DemoLevel1 on $projection.RootUUID = _DemoLevel1.UuidLevel1
  composition [0..*] of ZI_AF_DemoLevel4_01 as _DemoLevel4
{
  key UUID_LEVEL_3 as UuidLevel3,
  PARENT_UUID as ParentUUID,
  ROOT_UUID as RootUUID,
  SEMANTIC_KEY_3 as SemanticKey3,
  DESCRIPTION as Description,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LOCAL_LAST_CHANGED_AT as LocalLastChangedAt,
  _DemoLevel4,
  _DemoLevel2,
  _DemoLevel1
  
}
