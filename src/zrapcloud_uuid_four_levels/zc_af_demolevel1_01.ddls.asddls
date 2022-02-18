@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forDemoLevel1'
@ObjectModel.semanticKey: [ 'SemanticKey1' ]
@Search.searchable: true
define root view entity ZC_AF_DEMOLEVEL1_01
  as projection on ZI_AF_DemoLevel1_01
{
  key UuidLevel1,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
  SemanticKey1,
  Description,
  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt,
  _DemoLevel2 : redirected to composition child ZC_AF_DemoLevel2_01
  
}
