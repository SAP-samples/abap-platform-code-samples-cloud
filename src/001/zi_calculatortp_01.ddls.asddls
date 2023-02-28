@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View forCalculator'
define root view entity ZI_CalculatorTP_01
  provider contract transactional_interface
  as projection on ZR_CalculatorTP_01
{
  key CalcUUID,
  OperandA,
  OperandB,
  CalcResult,
  Operator,
  CreatedAt,
  CreatedBy,
  LastChangedBy,
  LastChangedAt,
  LocalLastChangedAt
  
}
