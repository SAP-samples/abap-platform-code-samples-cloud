CLASS lhc_calculator DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Calculator
        RESULT result,
      calculatecalcresult FOR DETERMINE ON modify
        IMPORTING
          keys FOR  Calculator~CalculateCalcResult .
ENDCLASS.

CLASS lhc_calculator IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD calculatecalcresult.

    "read transfered instances
    READ ENTITIES OF ZR_CalculatorTP_01 IN LOCAL MODE
      ENTITY Calculator
        FIELDS ( OperandA OperandB Operator )
        WITH CORRESPONDING #( keys )
      RESULT DATA(entities).

    "read and set product details
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<entity>).

      CASE <entity>-Operator.
        WHEN '+'.
          <entity>-CalcResult = <entity>-OperandA + <entity>-OperandB.
        WHEN '-'.
          <entity>-CalcResult = <entity>-OperandA - <entity>-OperandB.
        WHEN '*'.
          <entity>-CalcResult = <entity>-OperandA * <entity>-OperandB.
        WHEN '/'.
          IF <entity>-OperandB IS NOT INITIAL .
            <entity>-CalcResult = <entity>-OperandA / <entity>-OperandB.
          ENDIF.
        WHEN OTHERS.

      ENDCASE.

    ENDLOOP.

    "update instances
    MODIFY ENTITIES OF ZR_CalculatorTP_01 IN LOCAL MODE
      ENTITY Calculator
        UPDATE FIELDS ( CalcResult )
        WITH VALUE #( FOR entity IN entities INDEX INTO i (
                           %tky           = entity-%tky
                           CalcResult      = entity-CalcResult
                        ) ).
  ENDMETHOD.

ENDCLASS.
