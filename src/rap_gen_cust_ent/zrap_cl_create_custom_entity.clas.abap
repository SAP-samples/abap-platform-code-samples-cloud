CLASS zrap_cl_create_custom_entity DEFINITION
  PUBLIC
  INHERITING FROM cl_xco_cp_adt_simple_classrun
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  PROTECTED SECTION.
    METHODS main REDEFINITION.
    METHODS get_json_string
      RETURNING VALUE(json_string) TYPE string.
  PRIVATE SECTION.

ENDCLASS.



CLASS zrap_cl_create_custom_entity IMPLEMENTATION.

  METHOD main.
    TRY.
        DATA(json_string) = get_json_string(  ).
        DATA(rap_generator) = /dmo/cl_rap_generator=>create_for_cloud_development( json_string ).

        DATA(framework_messages) = rap_generator->generate_bo( ).
        IF rap_generator->exception_occured( ).
          out->write( |Caution: Exception occured | ).
          out->write( |Check repository objects of RAP BO { rap_generator->get_rap_bo_name(  ) }.| ).
        ELSE.
          out->write( |RAP BO { rap_generator->get_rap_bo_name(  ) }  generated successfully| ).
        ENDIF.
        out->write( |Messages from framework:| ).
        LOOP AT framework_messages INTO DATA(framework_message).
          out->write( framework_message ).
        ENDLOOP.
      CATCH /dmo/cx_rap_generator INTO DATA(rap_generator_exception).
        out->write( 'RAP Generator has raised the following exception:' ).
        out->write( rap_generator_exception->get_text(  ) ).
    ENDTRY.
  ENDMETHOD.

  METHOD get_json_string.
    json_string = '{' && |\r\n|  &&
                  '    "$schema": "https://raw.githubusercontent.com/SAP-samples/cloud-abap-rap/main/json_schemas/RAPGenerator-schema-all.json",' && |\r\n|  &&
                  '    "namespace": "Z",' && |\r\n|  &&
                  '    "bindingType": "odata_v2_ui",' && |\r\n|  &&
                  '    "dataSourceType": "cds_view",' && |\r\n|  &&
                  '    "implementationtype": "unmanaged_semantic",' && |\r\n|  &&
                  '    "package": "ZRAP_EPM_PRODUCTS_DEMO",' && |\r\n|  &&
                  '    "draftenabled": false,' && |\r\n|  &&
                  '    "prefix": "ABS_",' && |\r\n|  &&
                  '    "suffix": "_DEMO",' && |\r\n|  &&
                  '    "hierarchy": {' && |\r\n|  &&
                  '        "entityName": "Product",' && |\r\n|  &&
                  '        "dataSource": "ZDEMO_SEPMRA_I_PRODUCT_E",' && |\r\n|  &&
                  '        "objectId": "Product",' && |\r\n|  &&
                  '        "etagMaster": "LastChangedDateTime"        ' && |\r\n|  &&
                  '    }' && |\r\n|  &&
                  '}'.
  ENDMETHOD.

ENDCLASS.
