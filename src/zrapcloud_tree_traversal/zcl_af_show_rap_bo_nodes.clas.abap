CLASS zcl_af_show_rap_bo_nodes DEFINITION
  PUBLIC
  INHERITING FROM cl_xco_cp_adt_simple_classrun CREATE PUBLIC.
  PUBLIC SECTION.
  PROTECTED SECTION.
    METHODS: main REDEFINITION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_af_show_rap_bo_nodes IMPLEMENTATION.
  METHOD main.
    DATA(travel_bo_entities) = new zcl_af_get_nodes_from_rap_bo( 'ZI_SALESORDERES5' ).
    LOOP AT travel_bo_entities->get_entities(  ) INTO DATA(entity).
      out->write( entity->name ).
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
