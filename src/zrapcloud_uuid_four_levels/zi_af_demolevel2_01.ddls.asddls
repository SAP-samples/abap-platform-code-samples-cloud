@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forDemoLevel2'
define view entity ZI_AF_DEMOLEVEL2_01
  as select from ZUUID_LEVEL_2
  association to parent ZI_AF_DemoLevel1_01 as _DemoLevel1 on $projection.ParentUUID = _DemoLevel1.UuidLevel1
  composition [0..*] of ZI_AF_DemoLevel3_01 as _DemoLevel3
{
  key UUID_LEVEL_2 as UuidLevel2,
  PARENT_UUID as ParentUUID,
  SEMANTIC_KEY_2 as SemanticKey2,
  DESCRIPTION as Description,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LOCAL_LAST_CHANGED_AT as LocalLastChangedAt,
  _DemoLevel3,
  _DemoLevel1
  
}
