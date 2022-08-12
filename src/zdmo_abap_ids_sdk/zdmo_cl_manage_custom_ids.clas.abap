CLASS zdmo_cl_manage_custom_ids DEFINITION
  PUBLIC
  INHERITING FROM cl_xco_cp_adt_simple_classrun
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA user_resources  TYPE STANDARD TABLE OF zdmo_cl_user_json_visitor=>t_user  WITH DEFAULT KEY.
    DATA group_resources  TYPE STANDARD TABLE OF zdmo_cl_group_json_visitor=>t_group  WITH DEFAULT KEY.

    CLASS-METHODS get_instance RETURNING VALUE(ro_obj) TYPE REF TO zdmo_cl_manage_custom_ids.

    "! <p class="shorttext synchronized" lang="en"></p>
    "!
    "! @parameter email | <p class="shorttext synchronized" lang="en">eMail address of the user that will be added to the group.</p>
    "! @parameter group_displayname | <p class="shorttext synchronized" lang="en">Group displayName to which the user will be added.</p>
    "! @parameter status_code | <p class="shorttext synchronized" lang="en">http status code, e.g. 204 = patched successfully</p>
    "! @raising cx_web_http_client_error | <p class="shorttext synchronized" lang="en"></p>
    "! @raising cx_http_dest_provider_error | <p class="shorttext synchronized" lang="en"></p>
    METHODS assign_user_to_group_in_ids
      IMPORTING email              TYPE zdmo_cl_user_json_visitor=>t_user-email
                group_displayname  TYPE string
      RETURNING VALUE(status_code) TYPE if_web_http_response=>http_status-code
      RAISING
                cx_web_http_client_error
                cx_http_dest_provider_error.

    "! <p class="shorttext synchronized" lang="en"></p>
    "!
    "! @parameter user_data | <p class="shorttext synchronized" lang="en">user data</p>
    "! @parameter status_code | <p class="shorttext synchronized" lang="en">http status code, e.g. 201 = created</p>
    "! @raising cx_web_http_client_error | <p class="shorttext synchronized" lang="en"></p>
    "! @raising cx_http_dest_provider_error | <p class="shorttext synchronized" lang="en"></p>
    METHODS create_user_in_ids
      IMPORTING user_data          TYPE zdmo_cl_user_json_visitor=>t_user
      RETURNING VALUE(status_code) TYPE if_web_http_response=>http_status-code
      RAISING
                cx_web_http_client_error
                cx_http_dest_provider_error.

    "! <p class="shorttext synchronized" lang="en"></p>
    "!
    "! @parameter user_data | <p class="shorttext synchronized" lang="en">user data</p>
    "! @parameter status_code | <p class="shorttext synchronized" lang="en">http status code, e.g. 200 = changed successfully</p>
    "! @raising cx_web_http_client_error | <p class="shorttext synchronized" lang="en"></p>
    "! @raising cx_http_dest_provider_error | <p class="shorttext synchronized" lang="en"></p>
    METHODS change_user_in_ids
      IMPORTING user_data          TYPE zdmo_cl_user_json_visitor=>t_user
      RETURNING VALUE(status_code) TYPE if_web_http_response=>http_status-code
      RAISING
                cx_web_http_client_error
                cx_http_dest_provider_error.

    "! <p class="shorttext synchronized" lang="en"></p>
    "!
    "! @parameter user_data | <p class="shorttext synchronized" lang="en">user data</p>
    "! @parameter status_code | <p class="shorttext synchronized" lang="en">http status code, e.g. 204 = patched successfully</p>
    "! @raising cx_web_http_client_error | <p class="shorttext synchronized" lang="en"></p>
    "! @raising cx_http_dest_provider_error | <p class="shorttext synchronized" lang="en"></p>
    METHODS patch_user_in_ids
      IMPORTING user_data          TYPE zdmo_cl_user_json_visitor=>t_user
      RETURNING VALUE(status_code) TYPE if_web_http_response=>http_status-code
      RAISING
                cx_web_http_client_error
                cx_http_dest_provider_error.

    "! <p class="shorttext synchronized" lang="en"></p>
    "!
    "! @parameter filter_string | <p class="shorttext synchronized" lang="en">SCIM query parameters e.g.:<br>
    "! filter=displayName eq "MY_ROLE"
    "! </p>
    "! @parameter items_per_page | <p class="shorttext synchronized" lang="en">Maximum number of entries per page, e.g.: 100.</p>
    "! @parameter start_index | <p class="shorttext synchronized" lang="en">Numer of the first entry on this page, e.g.: 1</p>
    "! @parameter total_results | <p class="shorttext synchronized" lang="en">Total number of results matching the query, e.g.: 273.</p>
    "! @parameter user_resources | <p class="shorttext synchronized" lang="en"></p>
    "! @raising cx_http_dest_provider_error | <p class="shorttext synchronized" lang="en"></p>
    "! @raising cx_web_http_client_error | <p class="shorttext synchronized" lang="en"></p>
    METHODS get_users_from_ids
      IMPORTING filter_string  TYPE string
      EXPORTING
                items_per_page TYPE i
                start_index    TYPE i
                total_results  TYPE i
                user_resources LIKE user_resources
      RAISING
                cx_http_dest_provider_error
                cx_web_http_client_error.

    "! <p class="shorttext synchronized" lang="en"></p>
    "!
    "! @parameter email | <p class="shorttext synchronized" lang="en">eMail of a user used as filter</p>
    "! @parameter user_resource | <p class="shorttext synchronized" lang="en">user</p>
    METHODS get_user_from_ids_by_email
      IMPORTING email                TYPE string
      RETURNING VALUE(user_resource) TYPE zdmo_cl_user_json_visitor=>t_user.

    "! <p class="shorttext synchronized" lang="en"></p>
    "!
    "! @parameter external_id | <p class="shorttext synchronized" lang="en">ExternalID of a user used as filter</p>
    "! @parameter user_resource | <p class="shorttext synchronized" lang="en">user</p>
    METHODS get_user_from_ids_by_extid
      IMPORTING external_id          TYPE string
      RETURNING VALUE(user_resource) TYPE zdmo_cl_user_json_visitor=>t_user.

    "! <p class="shorttext synchronized" lang="en"></p>
    "!
    "! @parameter filter_string | <p class="shorttext synchronized" lang="en">SCIM query parameters e.g.:<br>
    "! filter=userName eq "SHUGO24"
    "! </p>
    "! @parameter items_per_page | <p class="shorttext synchronized" lang="en">Maximum number of entries per page, e.g.: 100.</p>
    "! @parameter start_index | <p class="shorttext synchronized" lang="en">Numer of the first entry on this page, e.g.: 1</p>
    "! @parameter total_results | <p class="shorttext synchronized" lang="en">Total number of results matching the query, e.g.: 273.</p>
    "! @parameter group_resources | <p class="shorttext synchronized" lang="en">Table of groups.</p>
    "! @raising cx_http_dest_provider_error | <p class="shorttext synchronized" lang="en"></p>
    "! @raising cx_web_http_client_error | <p class="shorttext synchronized" lang="en"></p>
    METHODS get_groups_from_ids
      IMPORTING filter_string   TYPE string OPTIONAL
      EXPORTING
                items_per_page  TYPE i
                start_index     TYPE i
                total_results   TYPE i
                group_resources LIKE group_resources
      RAISING
                cx_http_dest_provider_error
                cx_web_http_client_error.

    "! <p class="shorttext synchronized" lang="en"></p>
    "!
    "! @parameter display_name | <p class="shorttext synchronized" lang="en">Group displayName used as filter</p>
    "! @parameter group_resource | <p class="shorttext synchronized" lang="en">group item</p>
    METHODS get_group_from_ids_by_displayn
      IMPORTING display_name          TYPE string
      RETURNING VALUE(group_resource) TYPE zdmo_cl_group_json_visitor=>t_group.

    "! <p class="shorttext synchronized" lang="en"></p>
    "!
    "! @parameter source_system_id | <p class="shorttext synchronized" lang="en">Id (GUID) of the source system in the IdP</p>
    "! @parameter http_status | <p class="shorttext synchronized" lang="en">http status code and text</p>
    "! @raising cx_http_dest_provider_error | <p class="shorttext synchronized" lang="en"></p>
    "! @raising cx_web_http_client_error | <p class="shorttext synchronized" lang="en"></p>
    METHODS start_ids_synch IMPORTING source_system_id   TYPE string
                            RETURNING VALUE(http_status) TYPE if_web_http_response=>http_status
                            RAISING
                                      cx_http_dest_provider_error
                                      cx_web_http_client_error .

  PROTECTED SECTION.

    CONSTANTS: user_agent_key_name      TYPE string VALUE 'User-Agent' ##NO_TEXT,
               user_agent_key_value     TYPE string VALUE 'sample' ##NO_TEXT,
               communication_scenario   TYPE if_com_management=>ty_cscn_id VALUE 'ZDMO_SAP_IDS_INTEGRATION' ##NO_TEXT,
               urnDivision              TYPE string VALUE 'urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:division',
               urn                      TYPE string VALUE 'urn:ietf:params:scim:schemas:extension:enterprise:2.0:User',
               urnGroupName             TYPE string VALUE 'urn:sap:cloud:scim:schemas:extension:custom:2.0:Group:name',
               "Replace with the Id of your IDS source system
               source_system_id_default TYPE string VALUE 'fda14dd2-0f76-4915-bf3a-1d84525b8c07',
               demo_role                TYPE string VALUE 'ZDMO_DEMO_ROLE'.

    METHODS: main REDEFINITION.
  PRIVATE SECTION.

    CLASS-DATA: object_instance TYPE REF TO zdmo_cl_manage_custom_ids.

    METHODS create_http_client RETURNING VALUE(result) TYPE REF TO if_web_http_client RAISING cx_http_dest_provider_error cx_web_http_client_error.

    METHODS get_payload_create_ids_user IMPORTING user TYPE zdmo_cl_user_json_visitor=>t_user RETURNING VALUE(scim_payload) TYPE string.

    METHODS get_payload_change_ids_user IMPORTING user TYPE zdmo_cl_user_json_visitor=>t_user RETURNING VALUE(scim_payload) TYPE string.

    METHODS get_payload_patch_ids_user IMPORTING user TYPE zdmo_cl_user_json_visitor=>t_user RETURNING VALUE(scim_payload) TYPE string.

    METHODS get_payload_assign_to_ids_grp
      IMPORTING user                TYPE  zdmo_cl_user_json_visitor=>t_user
      RETURNING VALUE(scim_payload) TYPE string.

    METHODS set_scim_json_header_fields
      IMPORTING http_client TYPE REF TO if_web_http_client.

    METHODS set_uri_path_users
      IMPORTING
        http_client TYPE REF TO if_web_http_client
        id          TYPE string OPTIONAL.

    METHODS set_filter_string
      IMPORTING http_client TYPE REF TO if_web_http_client.

    METHODS set_uri_path_groups
      IMPORTING
        http_client TYPE REF TO if_web_http_client
        id          TYPE string OPTIONAL.

    METHODS get_formatted_json_string
      IMPORTING json_string_in         TYPE string
      RETURNING VALUE(json_string_out) TYPE string
      RAISING   cx_sxml_parse_error.

    METHODS set_appl_json_header_fields
      IMPORTING
        http_client TYPE REF TO if_web_http_client
      RAISING
        cx_web_message_error.
ENDCLASS.



CLASS zdmo_cl_manage_custom_ids IMPLEMENTATION.

  METHOD get_instance.
    IF object_instance IS NOT BOUND.
      CREATE OBJECT object_instance.
    ENDIF.
    ro_obj = object_instance.
  ENDMETHOD.


  METHOD main.
    DATA user_data  TYPE zdmo_cl_user_json_visitor=>t_user  .
    DATA num TYPE i VALUE 24.
    "display name of a group in SAP BTP ABAP Environment and in your
    "SAP IDS instance to which demo users are assigned for testing purposes
    DATA group_display_name TYPE string VALUE demo_role.
    DATA itemsperpage TYPE i.
    DATA startindex TYPE i.
    DATA totalresults TYPE i.

    DATA(filter_string_by_partnerid) = |filter=urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:division eq "1234"&startIndex=6&count=5|.

    TRY.
        zdmo_cl_manage_custom_ids=>get_instance(  )->get_users_from_ids(
                                                                            EXPORTING
                                                                               filter_string = filter_string_by_partnerid
                                                                            IMPORTING
                                                                               items_per_page  = itemsperpage
                                                                               start_index    = startindex
                                                                               total_results  = totalresults
                                                                               user_resources = DATA(users_by_partner_id)
                                                                            ).
      CATCH cx_http_dest_provider_error cx_web_http_client_error INTO DATA(get_users_from_ids_exception).
        "handle exception
        out->write( |Exception occured when reading users| ).
        out->write( get_users_from_ids_exception->get_text(  ) ).
    ENDTRY.

    IF users_by_partner_id IS INITIAL.
      out->write( |No users found via filter string: { filter_string_by_partnerid }| ).
    ELSE.
      out->write( |Searched via filter string: { filter_string_by_partnerid }| ).
      LOOP AT users_by_partner_id INTO DATA(user_by_partner_id).
        out->write( |External Id: { user_by_partner_id-email }| ).
        out->write( |External Id: { user_by_partner_id-externalid }| ).
      ENDLOOP.
    ENDIF.

    out->write( |----------------------------------| ).

    user_data = VALUE #(       username =    |SHUGO{ num }|
                               displayname = |Hugo Test{ num }|
                               familyname =  |Test{ num }|
                               givenname =   'Hugo'
                               email =       |Hugo.Test{ num }@Test.de|
                               partner_id =  '1234'  ).

    out->write( |Trying to create { user_data-displayname } | ).

    TRY.
        DATA(status_code_user_creation) = zdmo_cl_manage_custom_ids=>get_instance(  )->create_user_in_ids( user_Data ).
      CATCH cx_web_http_client_error cx_http_dest_provider_error INTO DATA(user_creation_exception).
        "handle exception
        out->write( |Exception occured when creating user| ).
        out->write( user_creation_exception->get_text(  ) ).
    ENDTRY.
    CASE status_code_user_creation.
      WHEN 201. " The user is created successfully..
        out->write( |Status: { status_code_user_creation }  User created successfully.| ).
      WHEN 400.
        out->write( |Status: { status_code_user_creation }  Wrong format or structure of the provided request body. |  ).
      WHEN 409.
        out->write( |Status: { status_code_user_creation } The created user does not fulfill the uniqueness criteria for userName or emails.|  ).
      WHEN 500.
        out->write( |Status: { status_code_user_creation } Unkown error. User creation|  ).
      WHEN OTHERS.
        out->write( |unexcpected status code user creation: { status_code_user_creation }| ).
    ENDCASE.

    out->write( |Get user by username :{ user_data-username }| ).

    DATA(user_by_external_id) = zdmo_cl_manage_custom_ids=>get_instance(  )->get_user_from_ids_by_extid( user_data-username ).
    DATA(user_resource_to_change) = user_by_external_id.

    out->write( |Trying to change { user_resource_to_change-displayname } via PUT| ).

    "set changed values
    user_resource_to_change-familyname =  |Test{ num }_{ num + 1 }|.
    user_resource_to_change-displayname = |Hugo Test{ num }_{ num + 1 }|.

    "first try PUT
    TRY.
        DATA(status_code_user_put) = zdmo_cl_manage_custom_ids=>get_instance(  )->change_user_in_ids( user_resource_to_change ).

      CATCH cx_web_http_client_error cx_http_dest_provider_error INTO DATA(user_update_exception).
        "handle exception
        out->write( |Exception occured when changing user| ).
        out->write( user_update_exception->get_text(  ) ).
    ENDTRY.

    CASE status_code_user_put.
      WHEN 200. " The user is updated successfully..
        out->write( |Status: { status_code_user_put }  The user is updated successfully.| ).
      WHEN 400.
        out->write( |Status: { status_code_user_put }  A property value is not valid. |  ).
      WHEN 404.
        out->write( |Status: { status_code_user_put }  The user with the provided ID does not exist.|  ).
      WHEN 409.
        out->write( |Status: { status_code_user_put }  The updated user does not fulfill the uniqueness criteria for certain fields.|  ).
      WHEN 500.
        out->write( |Status: { status_code_user_put }  Unkown error. User update|  ).
      WHEN OTHERS.
        out->write( |unexcpected status code user change via PUT: { status_code_user_put }| ).
    ENDCASE.

    out->write( |Trying to change { user_resource_to_change-displayname } via PATCH| ).

    "change email address as well
    user_resource_to_change-email = |Hugo.Test{ num }_{ num + 1 }@Test.de|.

    "then try PATCH
    TRY.
        DATA(status_code_user_patch) = zdmo_cl_manage_custom_ids=>get_instance(  )->patch_user_in_ids( user_resource_to_change ).

      CATCH cx_web_http_client_error cx_http_dest_provider_error INTO DATA(user_patch_exception).
        "handle exception
        out->write( |Exception occured when changing user| ).
        out->write( user_patch_exception->get_text(  ) ).
    ENDTRY.

    CASE status_code_user_patch.
      WHEN 204. " The user is updated successfully..
        out->write( |Status: { status_code_user_patch }  The user is patched successfully.| ).
      WHEN 400.
        out->write( |Status: { status_code_user_patch }  The provided identifier is not valid. |  ).
      WHEN 404.
        out->write( |Status: { status_code_user_patch }  The user with the provided ID does not exist.|  ).
      WHEN 409.
        out->write( |Status: { status_code_user_patch }  The updated user does not fulfill the uniqueness criteria for certain fields.|  ).
      WHEN 500.
        out->write( |Status: { status_code_user_patch } Unkown error. User patch|  ).
      WHEN OTHERS.
        out->write( |unexcpected status code user change via PATCH: { status_code_user_patch }| ).
    ENDCASE.

    DATA(filter_string) = |filter=userName eq "{ user_by_external_id-externalid }"|.

    zdmo_cl_manage_custom_ids=>get_instance(  )->get_users_from_ids(
      EXPORTING
        filter_string  = filter_string
      IMPORTING
        items_per_page   = itemsperpage
        start_index     = startindex
        total_results   = totalresults
        user_resources = DATA(user_resources)
    ).

    IF user_resources IS INITIAL.
      out->write( |No users found via filter string: { filter_string }| ).
    ELSE.
      out->write( |Searched via filter string: { filter_string }| ).
      LOOP AT user_resources INTO DATA(user_resource).
        out->write( |Givenname: { user_resource-givenname }| ).
        out->write( |Familyname: { user_resource-familyname }| ).
        out->write( |DisplayName: { user_resource-displayname }| ).
        out->write( |EMail: { user_resource-email }| ).
        out->write( |Id: { user_resource-id }| ).
        out->write( |Partner_Id: { user_resource-partner_id }| ).
        out->write( |Username: { user_resource-username }| ).
        out->write( |External Id: { user_resource-externalid }| ).
        out->write( |----------------------------------| ).
      ENDLOOP.
    ENDIF.

    zdmo_cl_manage_custom_ids=>get_instance(  )->get_groups_from_ids(
      EXPORTING
        filter_string   = |filter=DisplayName eq { demo_role }|
      IMPORTING
        items_per_page    = itemsperpage
        start_index      = startindex
        total_results    = totalresults
        group_resources = DATA(group_resources)
    ).

    LOOP AT group_resources INTO DATA(group_resource).
      out->write( |DisplayName: { group_resource-displayname }| ).
      out->write( |id: { group_resource-id }| ).
      out->write( |----------------------------------| ).
    ENDLOOP.

    DATA(ressource_partner_diamant) = get_group_from_ids_by_displayn(  group_display_name ).

    out->write( |Tryping to add { user_data-displayname } as a member to { group_display_name }| ).

    "Add user to group BR_SAP_PARTNER_DIAMANT
    TRY.
        DATA(status_code) = assign_user_to_group_in_ids(
          EXPORTING
            email             = user_data-email
            group_displayname = demo_role
        ).
        CASE status_code.
          WHEN 204. " The group is updated successfully.
            out->write( |Status: { status_code }  The group is updated successfully.| ).
          WHEN 400.
            out->write( |Status: { status_code } The provided identifier is not valid.|  ).
          WHEN 404.
            out->write( |Status: { status_code } The group with the provided ID does not exist.|  ).
          WHEN 500.
            out->write( |Status: { status_code } Unkown error.|  ).
          WHEN OTHERS.
            out->write( |unexcpected status code: { status_code }| ).
        ENDCASE.

      CATCH cx_web_http_client_error cx_http_dest_provider_error INTO DATA(assign_exception).
        "handle exception
        out->write( |Exception occured when assigning group| ).
        out->write( assign_exception->get_text(  ) ).
    ENDTRY.


    "test job api call
    DATA(status_id_job_api_call) = start_ids_synch( source_system_id = source_system_id_default ).
    DATA(status_code_id_job_api_call) = status_id_job_api_call-code.
    out->write( |status of job api call: { status_id_job_api_call-code } reason { status_id_job_api_call-reason  } | ).

    CASE status_code_id_job_api_call.
      WHEN 200.
        out->write( |Status: { status_code_id_job_api_call } Job has been triggered successfully  | ).
      WHEN 409.
        out->write( |Status: { status_code_id_job_api_call } Job is already running |  ).
      WHEN 423.
        out->write( |Status: { status_code_id_job_api_call } Job cannot be triggered as it has been started before a predefined minimum time interval (30 minutes) |  ).
      WHEN OTHERS.
        out->write( |unexcpected status code from calling job api: { status_code_id_job_api_call }| ).
    ENDCASE.

  ENDMETHOD.


  METHOD get_formatted_json_string.

    "cloud
    DATA(json_xstring) = cl_abap_conv_codepage=>create_out( )->convert( json_string_in ).
    "on_premise
    "DATA(json_xstring) = cl_abap_codepage=>convert_to( json_string_in ).

    "Check and pretty print JSON
    DATA(reader) = cl_sxml_string_reader=>create( json_xstring ).
    DATA(writer) = CAST if_sxml_writer(
                          cl_sxml_string_writer=>create( type = if_sxml=>co_xt_json ) ).
    writer->set_option( option = if_sxml_writer=>co_opt_linebreaks ).
    writer->set_option( option = if_sxml_writer=>co_opt_indent ).
    reader->next_node( ).
    reader->skip_node( writer ).

    "cloud
    DATA(json_formatted_string) = cl_abap_conv_codepage=>create_in( )->convert( CAST cl_sxml_string_writer( writer )->get_output( ) ).
    "on premise
    "DATA(json_formatted_string) = cl_abap_codepage=>convert_from( CAST cl_sxml_string_writer( writer )->get_output( ) ).

    json_string_out = escape( val = json_formatted_string format = cl_abap_format=>e_xml_text  ).

  ENDMETHOD.


  METHOD get_users_from_ids.

    DATA: lo_http_client TYPE REF TO if_web_http_client.

    lo_http_client = create_http_client(  ).
    set_scim_json_header_fields( lo_http_client ).
    set_uri_path_users( lo_http_client  ).
    lo_http_client->get_http_request( )->set_query( filter_string ).

    "Execute HTTP GET-Request and store Response
    DATA(lo_http_response) = lo_http_client->execute( if_web_http_client=>get ).
    DATA(ls_status) = lo_http_response->get_status( ).
    DATA(response_body) = lo_http_response->get_text( ).

    IF ls_status-code = 200. "found
      DATA(user_json_visitor) = NEW zdmo_cl_user_json_visitor(  ).
      DATA(json_data) = xco_cp_json=>data->from_string( response_body ).
      json_data->traverse( user_json_visitor ).
      user_resources = user_json_visitor->resources.
      items_per_page = user_json_visitor->itemsperpage.
      start_index  = user_json_visitor->startindex.
      total_results  = user_json_visitor->totalresults.
    ENDIF.

  ENDMETHOD.


  METHOD set_scim_json_header_fields.
    http_client->get_http_request( )->set_header_fields( VALUE #( ( name = if_web_http_header=>content_type value = 'application/scim+json' )
                                                                     ( name = if_web_http_header=>accept       value = 'application/scim+json' )
                                                                     ( name = user_agent_key_name value = user_agent_key_value )
                                                                   ) ).
  ENDMETHOD.


  METHOD set_uri_path_users.
    IF id IS INITIAL.
      http_client->get_http_request( )->set_uri_path( '/scim/Users' ).
    ELSE.
      http_client->get_http_request( )->set_uri_path( |/scim/Users/{ id }| ).
    ENDIF.
  ENDMETHOD.


  METHOD set_uri_path_groups.
    IF id IS INITIAL.
      http_client->get_http_request( )->set_uri_path( '/scim/Groups' ).
    ELSE.
      http_client->get_http_request( )->set_uri_path( |/scim/Groups/{ id }| ).
    ENDIF.
  ENDMETHOD.


  METHOD create_http_client.

    DATA lr_communication_scenario_id TYPE if_com_scenario_factory=>ty_query-cscn_id_range.
*    DATA communication_scenario  TYPE if_com_management=>ty_cscn_id.
    DATA outbound_service_id  TYPE if_com_management=>ty_cscn_outb_srv_id.
    DATA communication_system_id  TYPE if_com_management=>ty_cs_id.

*    communication_scenario = mc_communication_scenario.

    " find communication arrangement by scenario
    lr_communication_scenario_id = VALUE #( ( sign = 'I' option = 'EQ' low = communication_scenario ) ).
    DATA(lo_factory) = cl_com_arrangement_factory=>create_instance( ).
    lo_factory->query_ca(
      EXPORTING
        is_query           = VALUE #( cscn_id_range = lr_communication_scenario_id )
      IMPORTING
        et_com_arrangement = DATA(lt_communication_arrangement) ).

    IF lt_communication_arrangement IS NOT INITIAL.
      " take the first one
      communication_system_id = lt_communication_arrangement[ 1 ]->get_comm_system_id( ).
    ENDIF.

    DATA(lo_dest) = cl_http_destination_provider=>create_by_comm_arrangement(
             comm_scenario  = communication_scenario
             service_id     = outbound_service_id
             comm_system_id = communication_system_id
             ).

    DATA(destination) = cl_http_destination_provider=>create_by_comm_arrangement( communication_scenario ).

    result = cl_web_http_client_manager=>create_by_http_destination( lo_dest ).

  ENDMETHOD.


  METHOD set_filter_string.
*    io_http_client->get_http_request( )->set_query( fil ).
  ENDMETHOD.

  METHOD get_groups_from_ids.
    DATA: lo_http_client TYPE REF TO if_web_http_client.

    lo_http_client = create_http_client(  ).
    set_scim_json_header_fields( lo_http_client ).
    set_uri_path_groups( lo_http_client  ).

    "add filter string
    lo_http_client->get_http_request( )->set_query( filter_string ).

    " Execute HTTP GET-Request and store Response
    DATA(lo_http_response) = lo_http_client->execute( if_web_http_client=>get ).

    DATA(ls_status) = lo_http_response->get_status( ).
    DATA(response_body) = lo_http_response->get_text( ).

    IF ls_status-code = 200. "found
      DATA(group_json_visitor) = NEW zdmo_cl_group_json_visitor(  ).
      DATA(json_data) = xco_cp_json=>data->from_string( response_body ).
      json_data->traverse( group_json_visitor ).
      group_resources = group_json_visitor->resources.
      items_per_page = group_json_visitor->itemsperpage.
      start_index  = group_json_visitor->startindex.
      total_results  = group_json_visitor->totalresults.
    ENDIF.

  ENDMETHOD.


  METHOD create_user_in_ids.
    DATA: lo_http_client TYPE REF TO if_web_http_client,
          lv_payload     TYPE string.

    lo_http_client = create_http_client(  ).
    set_scim_json_header_fields( lo_http_client ).
    set_uri_path_users( lo_http_client  ).

    lv_payload = get_payload_create_ids_user( user_data ).
    lo_http_client->get_http_request(  )->append_text( lv_payload ).

    " Execute HTTP POST-Request and store Response
    DATA(lo_http_response) = lo_http_client->execute( if_web_http_client=>post ).
    DATA(ls_status) = lo_http_response->get_status( ).
    DATA(response_body) = lo_http_response->get_text( ).

    status_code = ls_status-code.

  ENDMETHOD.


  METHOD change_user_in_ids.
    DATA: lo_http_client TYPE REF TO if_web_http_client,
          lv_payload     TYPE string.

    lo_http_client = create_http_client(  ).
    set_scim_json_header_fields( lo_http_client ).
    set_uri_path_users(
      http_client = lo_http_client
      id             = user_data-id
    ).

    lv_payload = get_payload_change_ids_user( user_data ).
    lo_http_client->get_http_request(  )->append_text( lv_payload ).

    " Execute HTTP PATCH-Request and store Response
    DATA(lo_http_response) = lo_http_client->execute( if_web_http_client=>put ).
    DATA(ls_status) = lo_http_response->get_status( ).
    DATA(response_body) = lo_http_response->get_text( ).

    status_code = ls_status-code.
  ENDMETHOD.

  METHOD patch_user_in_ids.
    DATA: lo_http_client TYPE REF TO if_web_http_client,
          lv_payload     TYPE string.

    lo_http_client = create_http_client(  ).
    set_scim_json_header_fields( lo_http_client ).
    set_uri_path_users(
      http_client = lo_http_client
      id             = user_data-id
    ).

    lv_payload = get_payload_patch_ids_user( user_data ).
    lo_http_client->get_http_request(  )->append_text( lv_payload ).

    " Execute HTTP PATCH-Request and store Response
    DATA(lo_http_response) = lo_http_client->execute( if_web_http_client=>patch ).
    DATA(ls_status) = lo_http_response->get_status( ).
    DATA(response_body) = lo_http_response->get_text( ).

    status_code = ls_status-code.
  ENDMETHOD.

  METHOD get_payload_assign_to_ids_grp.
    scim_payload = '{' && |\r\n|  &&
                '  "schemas": [' && |\r\n|  &&
                '    "urn:ietf:params:scim:api:messages:2.0:PatchOp"' && |\r\n|  &&
                '  ],' && |\r\n|  &&
                '  "Operations": [' && |\r\n|  &&
                '    {' && |\r\n|  &&
                '      "op": "add",' && |\r\n|  &&
                '      "path": "members",' && |\r\n|  &&
                '      "value": [' && |\r\n|  &&
                '        {' && |\r\n|  &&
                |          "display": "{ user-displayname }",| && |\r\n|  &&
                |          "value": "{ user-id }"| && |\r\n|  &&
                '        }' && |\r\n|  &&
                '      ]' && |\r\n|  &&
                '    }' && |\r\n|  &&
                '  ]' && |\r\n|  &&
                '}'.
  ENDMETHOD.


  METHOD get_payload_create_ids_user.
    scim_payload = '{' && |\r\n|  &&
               '  "schemas": [' && |\r\n|  &&
               '    "urn:ietf:params:scim:schemas:core:2.0:User",' && |\r\n|  &&
               '    "urn:ietf:params:scim:schemas:extension:enterprise:2.0:User",' && |\r\n|  &&
               '    "urn:ietf:params:scim:schemas:extension:sap:2.0:User"' && |\r\n|  &&
               '  ],' && |\r\n|  &&
               |  "userName": "{ user-username }",| && |\r\n|  &&
               |  "displayName": "{ user-displayname }",| && |\r\n|  &&
               |  "externalId": "{ user-username }", | && |\r\n|  &&
*              "For workshops one might want to set a password
*              |  "password": "{ password_workshop_user }",| && |\r\n|  &&
               '  "name": {' && |\r\n|  &&
               |    "givenName": "{ user-givenname }",| && |\r\n|  &&
               |    "familyName": "{ user-familyname }" | && |\r\n|  &&
               '  },' && |\r\n|  &&
               '  "emails": [' && |\r\n|  &&
               '    {' && |\r\n|  &&
               |      "value": "{ user-email }"| && |\r\n|  &&
               '    }' && |\r\n|  &&
               '  ],' && |\r\n|  &&

               '"urn:ietf:params:scim:schemas:extension:enterprise:2.0:User": {' && |\r\n|  &&
                |   "division": "{ user-partner_id }", | && |\r\n|  &&
                |   "employeeNumber": "{ user-username }" | && |\r\n|  &&
               '},' && |\r\n|  &&

               ' "urn:ietf:params:scim:schemas:extension:sap:2.0:User": {' && |\r\n|  &&
*                       '  "active": true,' && |\r\n|  &&
*                       '  "passwordStatus": "enabled",' && |\r\n|  &&
               '  "sendMail": true ,' && |\r\n|  &&
               '  "mailVerified": false ' && |\r\n|  &&
*                     |  "validFrom": "2022-08-05T14:59:34.996Z", | &&
*                     |  "validTo": "2022-08-05T14:59:34.996Z" | &&
                '}' && |\r\n|  &&
                '}' && |\r\n|  &&

''.
  ENDMETHOD.


  METHOD assign_user_to_group_in_ids.

    DATA: http_client  TYPE REF TO if_web_http_client,
          scim_payload TYPE string.

    "retrieve user and group details
    DATA(user_resource) = get_user_from_ids_by_email( email ).
    DATA(group_resource) = get_group_from_ids_by_displayn( group_displayname ).

    "create http client
    http_client = create_http_client(  ).
    set_scim_json_header_fields( http_client ).

    set_uri_path_groups(
      http_client = http_client
      id             = group_resource-id
    ).

    scim_payload = get_payload_assign_to_ids_grp( user_resource ).
    http_client->get_http_request(  )->append_text( scim_payload ).

    " Execute HTTP PATCH-Request and store Response

    DATA(http_response) = http_client->execute( if_web_http_client=>patch ).
    DATA(ls_status) = http_response->get_status( ).
    DATA(response_body) = http_response->get_text( ).

    status_code = ls_status-code.

  ENDMETHOD.


  METHOD start_ids_synch.
    DATA job_start_api_relative_url TYPE string.
    DATA: http_client TYPE REF TO if_web_http_client.

    job_start_api_relative_url = |/ips/service/publicapi/v1/startJob/{ source_system_id }/jobs/READ|.

    http_client = create_http_client(  ).
    http_client->get_http_request( )->set_uri_path( job_start_api_relative_url ).

    set_appl_json_header_fields( http_client ).

    " Execute HTTP POST-Request and store Response
    DATA(http_response) = http_client->execute( if_web_http_client=>post ).
    DATA(response_body) = http_response->get_text( ).

    http_status = http_response->get_status( ).

  ENDMETHOD.


  METHOD get_group_from_ids_by_displayn.
    "urn:sap:cloud:scim:schemas:extension:custom:2.0:Group:name eq "test"
    get_groups_from_ids(
      EXPORTING
        filter_string   = |filter=displayName eq "{ display_name }"|
      IMPORTING
        total_results    = DATA(totalresults)
        group_resources = DATA(group_resources)
    ).
    IF totalresults = 1.
      group_resource = group_resources[ 1 ].
    ENDIF.
  ENDMETHOD.

  METHOD get_user_from_ids_by_extid.
    get_users_from_ids(
      EXPORTING
        filter_string  = |filter=externalid eq "{ external_id }"|
      IMPORTING
        total_results   = DATA(totalresults)
        user_resources = DATA(user_resources)
    ).
    IF totalresults = 1.
      user_resource = user_resources[ 1 ].
    ENDIF.
  ENDMETHOD.


  METHOD get_user_from_ids_by_email.
    get_users_from_ids(
      EXPORTING
        filter_string  = |filter=emails.value eq "{ email }"|
      IMPORTING
        total_results   = DATA(totalresults)
        user_resources = DATA(user_resources)
    ).
    IF totalresults = 1.
      user_resource = user_resources[ 1 ].
    ENDIF.
  ENDMETHOD.

  METHOD get_payload_change_ids_user.
    scim_payload = '{' && |\r\n|  &&
                 '  "schemas": [' && |\r\n|  &&
                 '    "urn:ietf:params:scim:schemas:core:2.0:User",' && |\r\n|  &&
                 '    "urn:ietf:params:scim:schemas:extension:enterprise:2.0:User",' && |\r\n|  &&
                 '    "urn:ietf:params:scim:schemas:extension:sap:2.0:User"' && |\r\n|  &&
                 '  ],' && |\r\n|  &&
                 |  "userName": "{ user-username }",| && |\r\n|  &&
                 |  "displayName": "{ user-displayname }",| && |\r\n|  &&
                 |  "externalId": "{ user-username }", | && |\r\n|  &&
*                       |  "password": "{ password_workshop_user }",| && |\r\n|  &&
                 '  "name": {' && |\r\n|  &&
                 |    "givenName": "{ user-givenname }",| && |\r\n|  &&
                 |    "familyName": "{ user-familyname }" | && |\r\n|  &&
                 '  },' && |\r\n|  &&
                 '  "emails": [' && |\r\n|  &&
                 '    {' && |\r\n|  &&
                 |      "value": "{ user-email }"| && |\r\n|  &&
                 '    }' && |\r\n|  &&
                 '  ],' && |\r\n|  &&

                 '"urn:ietf:params:scim:schemas:extension:enterprise:2.0:User": {' && |\r\n|  &&
                  |   "division": "{ user-partner_id }", | && |\r\n|  &&
                  |   "employeeNumber": "{ user-username }" | && |\r\n|  &&
                 '},' && |\r\n|  &&

                 ' "urn:ietf:params:scim:schemas:extension:sap:2.0:User": {' && |\r\n|  &&
*                       '  "active": true,' && |\r\n|  &&
*                       '  "passwordStatus": "enabled",' && |\r\n|  &&
                 '  "sendMail": false ,' && |\r\n|  &&
                 '  "mailVerified": true ' && |\r\n|  &&
*                     |  "validFrom": "2022-08-05T14:59:34.996Z", | &&
*                     |  "validTo": "2022-08-05T14:59:34.996Z" | &&
                  '}' && |\r\n|  &&
                  '}' && |\r\n|  &&

  ''.

  ENDMETHOD.





  METHOD get_payload_patch_ids_user.
    scim_payload = '{' && |\r\n|  &&
                '  "schemas": [' && |\r\n|  &&
                '    "urn:ietf:params:scim:api:messages:2.0:PatchOp"' && |\r\n|  &&
                '  ],' && |\r\n|  &&
                '  "Operations": [' && |\r\n|  &&
                '    {' && |\r\n|  &&
                '      "op": "replace",' && |\r\n|  &&
                '      "path": "name.givenName",' && |\r\n|  &&
                |      "value": "{ user-givenName }" |  && |\r\n|  &&
                '    }' && |\r\n|  &&
                ',' && |\r\n|  &&
                '    {' && |\r\n|  &&
                '      "op": "replace",' && |\r\n|  &&
                '      "path": "name.familyName",' && |\r\n|  &&
                |      "value": "{ user-familyName }" |  && |\r\n|  &&
                '    }' && |\r\n|  &&
                ',' && |\r\n|  &&
                '    {' && |\r\n|  &&
                '      "op": "replace",' && |\r\n|  &&
                '      "path": "displayName",' && |\r\n|  &&
                |      "value": "{ user-displayname }" |  && |\r\n|  &&
                '    }' && |\r\n|  &&
                ',' && |\r\n|  &&
                '    {' && |\r\n|  &&
                '      "op": "replace",' && |\r\n|  &&
                '      "path": "emails[primary eq true]",' && |\r\n|  &&
                |      "value": [ | && |\r\n|  &&
                '         {' && |\r\n|  &&
                |            "value": "{ user-email }", |   && |\r\n|  &&
                |            "primary": true| &&    |\r\n|  &&
                '         }' && |\r\n|  &&
                |      ] |  && |\r\n|  &&
                '    }' && |\r\n|  &&
                '  ]' && |\r\n|  &&
                '}'.
  ENDMETHOD.


  METHOD set_appl_json_header_fields.

    http_client->get_http_request( )->set_header_fields( VALUE #( ( name = if_web_http_header=>content_type value = 'application/json' )
                                                                  ( name = if_web_http_header=>accept       value = 'application/json' )
                                                                  ( name = user_agent_key_name              value = user_agent_key_value )
                                                                    ) ).

  ENDMETHOD.

ENDCLASS.
