@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forCalculator'
@ObjectModel.semanticKey: [ 'CalcResult' ]
@Search.searchable: true
define root view entity ZC_CalculatorTP_01
  provider contract transactional_query
  as projection on ZR_CalculatorTP_01
{
  key CalcUUID,
  OperandA,
  OperandB,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
  CalcResult,
  Operator,
  CreatedAt,
  CreatedBy,
  LastChangedBy,
  LastChangedAt,
  LocalLastChangedAt
  
}
