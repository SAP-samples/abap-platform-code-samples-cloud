CLASS zdmo_cl_group_json_visitor DEFINITION
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

    TYPES: BEGIN OF t_group_member,
             value TYPE string,
           END OF t_group_member.

    TYPES : t_group_member_tab TYPE STANDARD TABLE
                  OF t_group_member
                  WITH NON-UNIQUE KEY value.


    TYPES: BEGIN OF t_group,
             id          TYPE string,
             displayName TYPE string,
             name        TYPE string,
             members     TYPE t_group_member_tab,
           END OF t_group.

    DATA Resources TYPE STANDARD TABLE OF t_group.
    DATA Resource TYPE t_group.

    DATA: totalResults TYPE i,
          itemsPerPage TYPE i,
          startIndex   TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.



    DATA : last_visited_member TYPE string,
           object_number       TYPE i,
           array_level         TYPE i,
           in_Resources        TYPE abap_bool,
           in_emails           TYPE abap_bool,
           in_groups           TYPE abap_bool,
           in_name             TYPE abap_bool,
           in_members          TYPE abap_bool,
           email               TYPE t_email,
           emails              TYPE STANDARD TABLE OF t_email,
           object_stack        TYPE string_table,
           array_stack         TYPE string_table,
           member              TYPE t_group_member,
           members             TYPE t_group_member_tab.


ENDCLASS.



CLASS zdmo_cl_group_json_visitor IMPLEMENTATION.

  METHOD if_xco_json_tree_visitor~enter_array.
    array_level += 1.
    APPEND last_visited_member TO array_stack.
    CASE last_visited_member.
      WHEN 'Resources'.
        in_Resources = abap_true.
      WHEN 'members'.
        in_members = abap_true.
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.


  METHOD if_xco_json_tree_visitor~enter_object.
    object_number += 1.
    APPEND last_visited_member TO object_stack.
    CASE last_visited_member.
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.


  METHOD if_xco_json_tree_visitor~leave_array.
    DATA(array_being_left) = array_stack[ array_level ].
    DELETE array_stack INDEX array_level.
    array_level -= 1.
    IF in_members = abap_true.
      in_members = abap_false.
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
      resource-members = members.
      APPEND resource TO Resources.
      CLEAR resource.
      CLEAR email.
      CLEAR members.
    ENDIF.

  ENDMETHOD.


  METHOD if_xco_json_tree_visitor~on_end.
  ENDMETHOD.


  METHOD if_xco_json_tree_visitor~on_start.
    CLEAR object_number.
  ENDMETHOD.


  METHOD if_xco_json_tree_visitor~visit_boolean.
    CHECK iv_value IS NOT INITIAL.
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
        WHEN 'displayName'.
          resource-displayName = iv_value.
        WHEN OTHERS.
      ENDCASE.
    ENDIF.

    IF in_members = abap_true.
      CASE last_visited_member.
        WHEN 'value'.
          member-value = iv_value.
          APPEND member TO members.
        WHEN OTHERS.
      ENDCASE.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
