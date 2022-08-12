"! <p class="shorttext synchronized" lang="en">json visitor for scim users</p>
CLASS zdmo_cl_user_json_visitor DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_xco_json_tree_visitor .

    TYPES: BEGIN OF t_email,
             value   TYPE string,
             primary TYPE string,
           END OF t_email.

    TYPES: BEGIN OF t_name,
             familyName TYPE string,
             givenName  TYPE string,
           END OF t_name.

    "! <p class="shorttext synchronized" lang="en">user data</p>
    "!
    TYPES: BEGIN OF t_user,
             "! UUID of the user in the IDS
             id          TYPE string,
             "! will become the employeeID of the employee
             userName    TYPE string,
             "! Firstname concatenated with lastname
             displayName TYPE string,
             "! email address
             email       TYPE string,
             "! last name
             familyName  TYPE string,
             "! first name
             givenName   TYPE string,
             "! field to store information such as a business partner number.
             "! This will be mapped in the IDS to the field <strong>division</strong>
             "! And in the employee it will be mapped to the field <strong>department</strong>.
             partner_id  TYPE string,
             externalId  TYPE string,
           END OF t_user.

    "! <p class="shorttext synchronized" lang="en">table of user data</p>
    "!
    DATA Resources TYPE STANDARD TABLE OF t_user.

    "! <p class="shorttext synchronized" lang="en">user data</p>
    "!
    DATA Resource TYPE t_user.

    DATA: totalResults TYPE i,
          itemsPerPage TYPE i,
          startIndex   TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.

    CONSTANTS urn TYPE string VALUE 'urn:ietf:params:scim:schemas:extension:enterprise:2.0:User'.

    DATA : last_visited_member TYPE string,
           object_number       TYPE i,
           array_level         TYPE i,
           in_Resources        TYPE abap_bool,
           in_emails           TYPE abap_bool,
           in_groups           TYPE abap_bool,
           in_name             TYPE abap_bool,
           in_urn              TYPE abap_bool,
           email               TYPE t_email,
           emails              TYPE STANDARD TABLE OF t_email,
           object_stack        TYPE string_table,
           array_stack         TYPE string_table.


ENDCLASS.



CLASS zdmo_cl_user_json_visitor IMPLEMENTATION.


  METHOD if_xco_json_tree_visitor~enter_array.
    array_level += 1.
    APPEND last_visited_member TO array_stack.
    CASE last_visited_member.
      WHEN 'Resources'.
        in_Resources = abap_true.
      WHEN 'emails'.
        in_emails = abap_true.
      WHEN 'groups'.
        in_groups = abap_true.
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.


  METHOD if_xco_json_tree_visitor~enter_object.
    object_number += 1.
    APPEND last_visited_member TO object_stack.
    CASE last_visited_member.
      WHEN urn.
        in_urn = abap_true.
      WHEN 'name'.
        in_name = abap_true.
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.


  METHOD if_xco_json_tree_visitor~leave_array.
    DATA(array_being_left) = array_stack[ array_level ].
    DELETE array_stack INDEX array_level.
    array_level -= 1.
    IF in_emails = abap_true .
      in_emails = abap_false.
      EXIT.
    ENDIF.
    IF in_groups = abap_true.
      in_groups = abap_false.
      EXIT.
    ENDIF.
    IF in_resources = abap_true AND object_number = 1 AND array_level = 0.
      in_resources = abap_false.
    ENDIF.
  ENDMETHOD.


  METHOD if_xco_json_tree_visitor~leave_object.
    DATA(object_being_left) = object_stack[ object_number ].
    DELETE object_stack INDEX object_number.
    object_number -= 1.
    IF in_Resources = abap_true AND "object_being_left = 'Resources'.
      object_number = 1 AND array_level = 1.
      IF email-primary = abap_true.
        resource-email = email-value.
      ENDIF.
      APPEND resource TO Resources.
      CLEAR resource.
      CLEAR email.
    ENDIF.
    IF in_name = abap_true.
      in_name = abap_false.
    ENDIF.
    IF in_urn = abap_true.
      in_urn = abap_false.
    ENDIF.
  ENDMETHOD.


  METHOD if_xco_json_tree_visitor~on_end.
  ENDMETHOD.


  METHOD if_xco_json_tree_visitor~on_start.
    CLEAR object_number.
  ENDMETHOD.


  METHOD if_xco_json_tree_visitor~visit_boolean.
    CHECK iv_value IS NOT INITIAL.
    IF in_emails = abap_true  AND object_number = 3 AND array_level = 2.
      CASE last_visited_member.
        WHEN 'primary'.
          email-primary = iv_value.
        WHEN OTHERS.
      ENDCASE.
    ENDIF.

  ENDMETHOD.


  METHOD if_xco_json_tree_visitor~visit_member.
    last_visited_member = iv_name.
  ENDMETHOD.


  METHOD if_xco_json_tree_visitor~visit_null.
  ENDMETHOD.


  METHOD if_xco_json_tree_visitor~visit_number.
    DATA error_message TYPE string.
    CHECK iv_value IS NOT INITIAL.
    CASE last_visited_member.
      WHEN 'totalResults'.
        totalResults = iv_value.
      WHEN 'itemsPerPage'.
        itemsPerPage = iv_value.
      WHEN 'startIndex'.
        startIndex = iv_value.
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.


  METHOD if_xco_json_tree_visitor~visit_string.
    DATA error_message TYPE string.
    CHECK iv_value IS NOT INITIAL.
    IF in_Resources = abap_true AND object_number = 2 AND array_level = 1.
      CASE last_visited_member.
        WHEN 'id'.
          resource-id = iv_value.
        WHEN 'userName'.
          resource-userName = iv_value.
        WHEN 'externalId'.
          resource-externalId = iv_value.
        WHEN 'displayName'.
          resource-displayName = iv_value.
        WHEN OTHERS.
      ENDCASE.
    ENDIF.

    IF in_Resources = abap_true
    AND object_number = 3 AND array_level = 1
    .
      CASE last_visited_member.
        WHEN 'familyName'.
          resource-familyName = iv_value.
        WHEN 'givenName'.
          resource-givenName = iv_value.
        WHEN OTHERS.
      ENDCASE.
    ENDIF.

    IF in_urn = abap_true.
      CASE last_visited_member.
        WHEN 'division'.
          resource-partner_id = iv_value.
        WHEN OTHERS.
      ENDCASE.
    ENDIF.


    IF in_emails = abap_true AND object_number = 3 AND array_level = 2..
      CASE last_visited_member.
        WHEN 'value'.
          email-value = iv_value.
        WHEN OTHERS.
      ENDCASE.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
