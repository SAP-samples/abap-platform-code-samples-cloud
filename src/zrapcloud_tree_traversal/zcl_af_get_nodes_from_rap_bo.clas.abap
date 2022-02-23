CLASS zcl_af_get_nodes_from_rap_bo DEFINITION
  PUBLIC.

  PUBLIC SECTION.
    TYPES t_childentities TYPE STANDARD TABLE OF REF TO if_xco_data_definition WITH EMPTY KEY.

    METHODS constructor
      IMPORTING i_root_bo_name TYPE sxco_cds_object_name.

    METHODS get_entities
      RETURNING VALUE(r_entities) TYPE t_childentities.

  PROTECTED SECTION.

  PRIVATE SECTION.
    CONSTANTS:
      BEGIN OF package_abap_language_version,
        standard                    TYPE sychar01 VALUE ' ',
        abap_for_key_users          TYPE sychar01 VALUE '2',
        abap_for_sap_cloud_platform TYPE sychar01 VALUE '5',
      END OF package_abap_language_version.

    DATA abap_language_version TYPE sychar01 .
    DATA root_entity  TYPE REF TO if_xco_data_definition.
    DATA entities TYPE t_childentities.

    METHODS get_composition_childs
      IMPORTING definition                TYPE REF TO if_xco_data_definition
      RETURNING VALUE(child_csn_entities) TYPE t_childentities.

    METHODS traverse_child_entities
      IMPORTING definition TYPE REF TO if_xco_data_definition.

    METHODS get_entity_definition
      IMPORTING iv_name                   TYPE sxco_cds_object_name
      RETURNING VALUE(ro_data_definition) TYPE REF TO if_xco_data_definition.

ENDCLASS.



CLASS zcl_af_get_nodes_from_rap_bo IMPLEMENTATION.

  METHOD traverse_child_entities.
    " syntax as found in
    " https://www.geeksforgeeks.org/inorder-traversal-of-an-n-ary-tree/
    DATA current_child_number TYPE i.
    DATA(child_entities) = get_composition_childs( definition ).
    CHECK child_entities IS NOT INITIAL.
    DATA(number_of_child_entities) = lines( child_entities ).
    WHILE current_child_number < number_of_child_entities - 1.
      current_child_number += 1 .
      APPEND child_entities[ current_child_number ] TO entities.
      traverse_child_entities( child_entities[ current_child_number ] ).
    ENDWHILE.
    APPEND child_entities[ number_of_child_entities ] TO entities.
    "last child entity
    traverse_child_entities( child_entities[ number_of_child_entities ] ).
  ENDMETHOD.

  METHOD get_composition_childs.
    DATA compositions TYPE sxco_t_cds_compositions.
    DATA composition TYPE REF TO if_xco_cds_composition  .
    DATA composition_targets TYPE STANDARD TABLE OF sxco_cds_object_name.
    DATA(view_type) = definition->get_type( ).
    CASE view_type.
      WHEN xco_cp_data_definition=>type->view_entity.
        compositions = definition->view_entity( )->compositions->all->get(  ).
      WHEN xco_cp_data_definition=>type->custom_entity.
        DATA(lo_fields) = definition->custom_entity( )->fields->all->get(  ).
        LOOP AT lo_fields INTO DATA(lo_field).
          IF lo_field->content(  )->get(  )-composition-target IS NOT INITIAL.
            APPEND lo_field->content(  )->get(  )-composition-target TO composition_targets.
          ENDIF.
        ENDLOOP.
      WHEN xco_cp_data_definition=>type->view.
        compositions = definition->view( )->compositions->all->get(  ).
      WHEN OTHERS.
        "do nothing
    ENDCASE.

    LOOP AT compositions INTO DATA(composition_line).
      APPEND get_entity_definition( CONV #( composition_line->target ) ) TO child_csn_entities.
    ENDLOOP.

    LOOP AT composition_targets INTO DATA(composition_target).
      APPEND get_entity_definition( CONV #( composition_target ) ) TO child_csn_entities.
    ENDLOOP.

  ENDMETHOD.

  METHOD get_entity_definition.
    CASE abap_language_version.
      WHEN package_abap_language_version-standard.
*        ro_data_definition = xco_abap_repository=>object->ddls->for( iv_name  ).
      WHEN package_abap_language_version-abap_for_sap_cloud_platform.
        ro_data_definition = xco_cp_abap_repository=>object->ddls->for( iv_name  ).
    ENDCASE.
  ENDMETHOD.

  METHOD constructor.
    super->constructor( ).
    abap_language_version = package_abap_language_version-abap_for_sap_cloud_platform.
    "abap_language_version = package_abap_language_version-standard.
    entities = VALUE #( ( get_entity_definition( i_root_bo_name ) ) ).
    traverse_child_entities( get_entity_definition( i_root_bo_name ) ).
  ENDMETHOD.

  METHOD get_entities.
    r_entities = entities.
  ENDMETHOD.

ENDCLASS.
