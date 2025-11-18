CLASS zcl_test_api_sales_order_srv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    TYPES:

      BEGIN OF tys_item_scheduline.
        INCLUDE TYPE zsc_test_api_sales_order_srv=>tys_a_sales_order_item_type.
    TYPES : to_schedule_line TYPE  zsc_test_api_sales_order_srv=>tyt_a_sales_order_schedule_l_2,
      END OF tys_item_scheduline,

      tyt_item_scheduline TYPE STANDARD TABLE OF tys_item_scheduline WITH DEFAULT KEY,

      BEGIN OF tys_salesorder_item_scheduline.
        INCLUDE TYPE zsc_test_api_sales_order_srv=>tys_a_sales_order_type.
    TYPES : to_item TYPE tyt_item_scheduline,
      END OF tys_salesorder_item_scheduline,

      tyt_item_business_data       TYPE zsc_test_api_sales_order_srv=>tyt_a_sales_order_item_type,
      tys_entity_key               TYPE zsc_test_api_sales_order_srv=>tys_a_sales_order_type,

      material_t                   TYPE c LENGTH 40,
      quantity_t                   TYPE n LENGTH 4,
      purchase_order_by_customer_t TYPE c LENGTH 35.

    CONSTANTS :
         c_proxy_model_key TYPE /iwbep/if_cp_runtime_types=>ty_s_proxy_model_key VALUE 'ZSC_TEST_API_SALES_ORDER_SRV'.

    METHODS CreateSalesorder
      EXPORTING r_error_message TYPE string
      RETURNING VALUE(r_data)   TYPE  tys_salesorder_item_scheduline.

    METHODS constructor
      IMPORTING i_material                   TYPE material_t OPTIONAL
                i_quantity                   TYPE quantity_t OPTIONAL
                i_purchase_order_by_customer TYPE purchase_order_by_customer_t OPTIONAL
                i_requested_delivery_date    TYPE datn OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA deep_busi_data TYPE tys_salesorder_item_scheduline.

ENDCLASS.



CLASS ZCL_TEST_API_SALES_ORDER_SRV IMPLEMENTATION.


  METHOD constructor.

*    c_proxy_model_key = to_upper( 'zsc_test_api_sales_order_srv' ).

    IF i_material <> 'MZ-FG-C900'.

      deep_busi_data    =    VALUE #(
                         sales_order_type            = 'OR'
                         sales_organization          = '1710' "'1010'
                         distribution_channel        = '10'
                         organization_division       = '00'
                         sold_to_party               = 'USCU_L04'      "'10100001'
                         purchase_order_by_customer  = i_purchase_order_by_customer
                         requested_delivery_date     = i_requested_delivery_date
                         to_item = VALUE #( (
                            material =  i_material
                            requested_quantity = i_quantity
                            ) )
                         ).
    ELSE.
      deep_busi_data    =    VALUE #(
                         sales_order_type            = 'OR'
*                         sales_organization          = '1710'
*                         distribution_channel        = '10'
*                         organization_division       = '00'
*                         sold_to_party               = 'LACU_S01' "'1000292'
*                         purchase_order_by_customer  = i_purchase_order_by_customer
                         requested_delivery_date     = i_requested_delivery_date
                         to_item = VALUE #( (
                            material =  i_material
                            requested_quantity = i_quantity
                            ) )
                         ).
    ENDIF.

  ENDMETHOD.


  METHOD CreateSalesorder.

    DATA:
      lt_item_business_data      TYPE tyt_item_business_data,
      ls_entity_key              TYPE tys_entity_key,
      lo_http_client             TYPE REF TO if_web_http_client,
      lo_client_proxy            TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_response                TYPE REF TO /iwbep/if_cp_response_create,
      lo_create_request          TYPE REF TO /iwbep/if_cp_request_create,
      lo_data_desc_node_root     TYPE REF TO /iwbep/if_cp_data_desc_node,
      lo_data_desc_node_child    TYPE REF TO /iwbep/if_cp_data_desc_node,
      lo_data_desc_node_gc_child TYPE REF TO /iwbep/if_cp_data_desc_node,
      ls_deep_response_data      TYPE tys_salesorder_item_scheduline.

    TRY.


        " Create http client
        TRY.
*            DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination(
*                                      i_name = 'S4HANA_ODATA_SalesOrder'
*                                      i_authn_mode            = if_a4c_cp_service=>service_specific
*                                   ).
            " Create http client
            DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                                         comm_scenario  = 'ZBTP_TRIAL_SAP_COM_0109'
                                                         comm_system_id = 'ZBTP_TRIAL_SAP_COM_0109'
                                                         service_id     = 'ZBTP_TRIAL_SAP_COM_0109_REST'
                                                       ).


          CATCH cx_http_dest_provider_error INTO DATA(dest_provider_error).
            "handle exception
            r_error_message = dest_provider_error->get_text(  ).
            EXIT.
        ENDTRY.

        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
        lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
          EXPORTING
             is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                 proxy_model_id      = c_proxy_model_key
                                                 proxy_model_version = '0001' )
            io_http_client             = lo_http_client
*            iv_relative_service_root   =  'sap/opu/odata/SAP/API_SALES_ORDER_SRV/'
            iv_relative_service_root   = ''
            ).

        IF lo_http_client IS NOT BOUND.
          r_error_message = 'http client not bound'.
          EXIT.
        ENDIF.

        " Navigate to the resource and create a request for the create operation
        lo_create_request = lo_client_proxy->create_resource_for_entity_set( 'A_SALES_ORDER' )->create_request_for_create( ).

        "Description of the deep business data
        TRY.

            lo_data_desc_node_root = lo_create_request->create_data_descripton_node( ).
            lo_data_desc_node_root->set_properties( VALUE #( ( |{ to_upper( 'sales_order_type' ) }| )
                                                             ( |{ to_upper( 'sales_organization' ) }| )
                                                             ( |{ to_upper( 'distribution_channel' ) }| )
                                                             ( |{ to_upper( 'organization_division' ) }| )
                                                             ( |{ to_upper( 'sold_to_party' ) }| )
                                                             ( |{ to_upper( 'purchase_order_by_customer' ) }| )
                                                                  ) ).

            lo_data_desc_node_child = lo_data_desc_node_root->add_child( 'TO_ITEM' ).
            lo_data_desc_node_child->set_properties( VALUE #(
                                                                ( |{ to_upper( 'sales_order_item' ) }| )
                                                                ( |{ to_upper( 'material' ) }| )
                                                                ( |{ to_upper( 'requested_quantity' ) }| )
                                                             ) ).

            lo_data_desc_node_gc_child = lo_data_desc_node_child->add_child( 'TO_SCHEDULE_LINE' ).

          CATCH  /iwbep/cx_gateway  INTO DATA(gw_error).
            r_error_message = gw_error->get_text(  ).
            EXIT.
        ENDTRY.


        lo_create_request->set_deep_business_data(
          EXPORTING
            is_business_data            = deep_busi_data
            io_data_description         = lo_data_desc_node_root
            ).

        " Execute the request
        lo_response = lo_create_request->execute( ).

        " Get the after image
        lo_response->get_business_data( IMPORTING es_business_data = ls_deep_response_data ).

        " Set entity key
        ls_entity_key = VALUE #(
                  sales_order  = ls_deep_response_data-sales_order ).

        " Navigate to the resource
        DATA(lo_resource) = lo_client_proxy->create_resource_for_entity_set( 'A_SALES_ORDER' )->navigate_with_key( ls_entity_key )->navigate_to_many( iv_navigation_property_name = 'TO_ITEM' ).

        " Execute the request and retrieve the business data
        DATA(lo_response_read_deep) = lo_resource->create_request_for_read( )->execute( ).
        lo_response_read_deep->get_business_data( IMPORTING et_business_data = lt_item_business_data ).

        IF lt_item_business_data IS NOT INITIAL.
          ls_deep_response_data-to_item = CORRESPONDING #(  lt_item_business_data ).
        ENDIF.

        r_data = ls_deep_response_data.


      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        " Handle remote Exception
        " It contains details about the problems of your http(s) connection
        r_error_message = |remote exc { lx_remote->get_text(  ) }| .
        EXIT.
      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        " Handle Exception
        r_error_message = |gateway exc { lx_gateway->get_text(  ) }| .
        EXIT.
      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
        " Handle Exception
        r_error_message = |gateway exc { lx_web_http_client_error->get_text(  ) }| .
        EXIT.
    ENDTRY.

  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.

    DATA deep_busi_data TYPE tys_salesorder_item_scheduline.
    DATA error_message TYPE string.

    deep_busi_data    =    VALUE #(
                       sales_order_type            = 'OR'
                       sales_organization          = '1010'
                       distribution_channel        = '10'
                       organization_division       = '00'
                       sold_to_party               = '10100001'
                       purchase_order_by_customer  = |SalesOrder Simulation{ sy-uname }|
                       requested_delivery_date     = sy-datum
                       to_item = VALUE #( (
                          material = 'TG1  11'
                          requested_quantity = '5'
                          ) )
                       ).


    DATA(response) = CreateSalesorder(
                       IMPORTING
                         r_error_message  = error_message
                     ).

    IF error_message IS NOT INITIAL.
      out->write( error_message ).
    ELSE.
      out->write( | Customer: { response-purchase_order_by_customer } | ).
      out->write( | SalesOrderID { response-sales_order } | ).
      LOOP AT response-to_item INTO DATA(item).
        out->write( |ItemId { item-sales_order_item }|  ).
        out->write( |Name { item-purchase_order_by_customer }|  ).
        LOOP AT item-to_schedule_line INTO DATA(schedule_line).
          out->write( | amount { schedule_line-confd_order_qty_by_matl_av } | &&
                      | requested delivery date { schedule_line-requested_delivery_date } | &&
                      | confirmed delivery date { schedule_line-confirmed_delivery_date } | ).
        ENDLOOP.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
