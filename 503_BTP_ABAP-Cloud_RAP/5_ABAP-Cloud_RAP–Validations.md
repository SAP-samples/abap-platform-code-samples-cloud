[Previous Lesson](./4_ABAP-Cloud_RAP–Salesorder_Creation.md)
# Validations

## Introduction

In the previous exercises, you have defined and implemented determinations during the creation of new instances of BO entity _ShoppingCart_ and your application used an OData API call to create a sales order asynchronously side-by-side.

Since the content (e.g. the field `OrderQuantity`) can be invalid which would prevent the creation of a sales order we would to check the data quality upfront.   

In the present exercise, you're going to define and implement three back-end validations, `validateOrderedItem`, `validateRequestedDeliveryDate` and `validateOrderQuantity`, to respectively check the following:
- The value for the field `OrderedItem` must not be initial, since this field has been marked as mandatory. The value itself is checked against the value help.
- The value for the field `RequestedDeliveryDate` shall not be intial and shall not lie in the past.
- The value for the field `OrderQuantity` shall also not be initial.

These validations are only performed in the back-end (not on the UI) and are triggered independently of the caller, i.e. Fiori UIs or EML APIs.

> ℹ **Frontend validation & Backend validations**
> Validations are used to ensure the data consistency.
> As the name suggests, **frontend validations** are performed on the UI. They are used to improve the user experience by providing faster feedback and avoiding unnecessary roundtrips. In the RAP context, front-end validations are defined using CDS annotation or UI logic.  
> On the other hand, **backend validations** are performed on the back-end. They are defined in the BO behavior definitons and implemented in the respective behavior pools.
> Frontend validations can be easily bypassed - e.g. by using EML APIs in the RAP context. Therefore, **backend validations are a MUST** to ensure the data consistency.

### About Validations

A validation is an optional part of the business object behavior that checks the consistency of business object instances based on trigger conditions.

A validation is implicitly invoked by the business object’s framework if the trigger condition of the validation is fulfilled. Trigger conditions can be `MODIFY` operations and modified fields. The trigger condition is evaluated at the trigger time, a predefined point during the BO runtime. An invoked validation can reject inconsistent instance data from being saved by passing the keys of failed instances to the corresponding table in the `FAILED` structure. Additionally, a validation can return messages to the consumer by passing them to the corresponding table in the `REPORTED` structure.

> **Further reading**: [Validations](https://help.sap.com/viewer/923180ddb98240829d935862025004d6/Cloud/en-US/171e26c36cca42699976887b4c8a83bf.html)

## Exercise 5.1: Define the Validations

> In this exercise you will define the validations **`validateOrderedItem`**, **`validateRequestedDeliveryDate`** and **`validateOrderQuantity`**.
  
1. Open your behavior definition **`ZR_AC000000U##`**   using this ADT [Link](adt://TDI/sap/bc/adt/bo/behaviordefinitions/zr_AC000000U##).    

2. Because empty values will not be accepted for the fields **`OrderedItem`**, **`RequestedDeliveryDate`**, and **`OrderQuantity`**, specify them as _mandatory_ field 
   by adding the following code snippet after the determination as shown on the screenshot below.
 
```ABAP  
    // mark mandatory fields
    field ( mandatory )
    OrderQuantity,
    OrderedItem,
    RequestedDeliveryDate;
```    

   Your source code should look like this:   

   ![mandatory fields bdef](./Images/05-000-mandatory-fields-bdef-r.png)

3. Define the validations **`validateOrderedItem`**, **`validateRequestedDeliveryDate`** and **`validateOrderQuantity`**.

   For that, add the following code snippet after the determination as shown on the screenshot below.

 ```ABAP
      validation validateOrderedItem on save { create; field OrderedItem; }
      validation validateRequestedDeliveryDate on save { create; field RequestedDeliveryDate; }
      validation validateOrderQuantity on save { create; field OrderQuantity; }
 ```   

4. In order to have draft instances being checked by validations and determinations being executed before they become active, they have to be specified for the **`draft determine action prepare`** in the behavior definition.
  
   Replace the code line **`draft determine action Prepare;`** with the following code snippet as shown on the screenshot below

```ABAP
    draft determine action Prepare
    {
     validation validateOrderedItem;
     validation validateRequestedDeliveryDate;
     validation validateOrderQuantity;
    }
```

   Your source code should look like this: 

   ![validations bdef](./Images/05-010-add-validations-bdef-r.png)

   **Short explanation**:
   - Validations are always invoked during the save and specified with the keyword `on save`.
   - `validateOrderedItem` is a validation with trigger operation `create` and trigger field `OrderedItem`.
   - `validateRequestedDeliveryDate` is a validation with trigger operation `create` and trigger field `RequestedDeliveryDate`.
   - `validateOrderQuantity` is a validation with trigger operation `create` and trigger field `OrderQuantity`

   **ℹ Hint**:
   > In case a validation should be invoked at every change of the BO entity instance, then the trigger conditions `create`and `update`
   > must be specified: e.g. `validation validateRequestedDeliveryDate on save { create; update; }`

5. Save ![inline](./Images/ADT_save.png) and activate ![inline](./Images/ADT_activate.png) the changes.

6. Add the appropriate **`FOR VALIDATE ON SAVE`** methods to the local handler class of the behavior pool of the _ShoppingCart_ BO entity via quick fix.  

   For that, set the cursor on one of the validation names and press **Ctrl+1** to open the **Quick Assist** view and select the entry _**`Add all 3 missing methods of entity zr_AC000000U## ...`**_.

   ![quick fix validations](./Images/05-020-add-validations-bdef-r-quick-fix.png)

   As a result, the **`FOR VALIDATE ON SAVE`** methods **`validateOrderedItem`**, **`validateRequestedDeliveryDate`** and **`validateOrderQuantity`** will be added to the local handler class `lcl_handler` of the behavior pool of the _ShoppingCart_ BO entity ![inline](./Images/ADT_class.png)`ZBP_R_AC000000U##`.

   ![quick fix validations result](./Images/05-030-add-validations-bdef-r-quick-fix-result.png)

7. Save ![inline](./Images/ADT_save.png) and activate ![inline](./Images/ADT_activate.png) the changes.

> Hint:  
> If you get an error message in the behavior implementation `The entity "ZR_AC000000U##" does not have a validation "VALIDATEORDERQUANTITY".` try to activate the behvavior definition once again.  

## Exercise 5.2: Implement the Validations  

> Implement the validations, e.g. the validation `validateOrderedItem` which checks if the respective field `OrderedItem` that is entered by the consumer is valid and not initial.  
> An appropriate message should be raised and displayed on the UI for each invalid value.  
> ![side-by-side](./Images/side_by_side_small_2.png)  **Side-by-side extension**:  
> Please note that the validation `validateOrderedItem` performs an OData call to the SAP S/4HANA Cloud backend system. We have provided an implementation for such an API for your convenience. You can later replace it using your own implementation *(Unit 5)*.  


1. First, check the interface of the new methods in the declaration part of the local handler class `lcl_handler` of the behavior pool of the _ShoppingCart_ BO entity ![class icon](./Images/ADT_class.png)**`ZBP_R_AC000000U##`**.

   For that, set the cursor on the method name, e.g. **`validateOrderedItem`**, press **F2** to open the **ABAP Element Info** view, and examine the full method interface.

   ![examine method interface f2](./Images/05-040-add-validations-f2.png) 

   **Short explanation**:  
   - The addition **`FOR VALIDATE ON SAVE`** indicates that the method provides the implementation of a validation executed on save. Validations are always executed on save.
   - Method signature for the validation method:
     - `IMPORTING`parameter **`keys`** - an internal table containing the keys of the instances on which the validation should be performed.
     - Implicit `CHANGING` parameters (aka _implicit response parameters_):  
       - **`failed`**   - table with information for identifying the data set where an error occurred
       - **`reported`** - table with data for instance-specific messages

   You can go ahead and implement the validation method.

2. Now implement the three methods in the implementation part of the class.
  
    The logic consists of the following main steps:
    1. Read the ShoppingCart instance(s) of the transferred keys (**`keys`**) using the EML statement **`READ ENTITIES`**.
    2. The addition **`FIELDS`** is used to specify the fields to be read. E.g. only **`OrderedItem`** is relevant for the  validation `validateOrderedItem`.  
       The addition `ALL FIELDS` can be used to read all fields.
    3. The addition **`IN LOCAL MODE`** is used to exclude feature controls and authorization checks.
    4. Read all the transfered (distinct, non-initial) customer IDs and check if they exist.  
    5. Prepare/raise messages for all transferred _ShoppingCart_ instances with initial and non-existing `OrderedItem`  
       and set the changing parameter **`reported`**

### Exercise 5.2.1: Implement the validations manually

<details>   
<summary>Click to expand</summary>  

   Replace the current method implementations with following code snippets.

    - **`validateOrderedItem`**
    - **`validateRequestedDeliveryDate`**
    - **`validateOrderQuantity`**

   You can use the **F1 Help** to get detailed information on the different ABAP and EML statements.  


3. Save ![inline](./Images/ADT_save.png) and activate ![inline](./Images/ADT_activate.png) the changes.


#### ![inline](./Images/source-code_grey_small.png) Code snippet **`validateOrderedItem`**

<hr>

<details>

<summary>Click to expand the source code</summary>

```ABAP
  METHOD validateOrderedItem.
  
    "For your convinience there is a central class ZAX_AC_EXCEPTIONS that is beeing used here.

    READ ENTITIES OF zr_AC000000U## IN LOCAL MODE
       ENTITY ShoppingCart
         FIELDS (  OrderedItem )
         WITH CORRESPONDING #( keys )
       RESULT DATA(entities).

    LOOP AT entities INTO DATA(entity).
      APPEND VALUE #(  %tky               = entity-%tky
                       %state_area        = 'VALIDATE_ORDERED_ITEM' ) TO reported-shoppingcart.
      IF entity-OrderedItem IS INITIAL.
        APPEND VALUE #( %tky = entity-%tky ) TO failed-shoppingcart.

        APPEND VALUE #( %tky               = entity-%tky
                        %state_area        = 'VALIDATE_ORDERED_ITEM'
                        %msg               = NEW zcx_ac_exceptions(
                                                 textid   = zcx_ac_exceptions=>enter_order_item
                                                 severity = if_abap_behv_message=>severity-error )
                        %element-ordereditem = if_abap_behv=>mk-on ) TO reported-shoppingcart.
      ENDIF.

      "For your convinience there are GLOBAL defined types available:
      DATA product_api TYPE REF TO zcl_AC_PRODUCT_API.
      DATA business_data TYPE zcl_AC_PRODUCT_API=>t_business_data_external.
      
      "... later on, you will be replacing them with your own types.
      "DATA product_api TYPE REF TO zcl_AC000000U##_PRODUCT_API.
      "DATA business_data TYPE zcl_AC000000U##_PRODUCT_API=>t_business_data_external.
      
      DATA filter_conditions  TYPE if_rap_query_filter=>tt_name_range_pairs .
      DATA ranges_table TYPE if_rap_query_filter=>tt_range_option .

      product_api = NEW #(  ).

      ranges_table = VALUE #(
                              (  sign = 'I' option = 'EQ' low = entity-OrderedItem )
                            ).

      filter_conditions = VALUE #( ( name = 'PRODUCT'  range = ranges_table ) ).

      TRY.
          product_api->get_products(
            EXPORTING
              it_filter_cond    = filter_conditions
              top               =  50
              skip              =  0
            IMPORTING
              et_business_data  = business_data
            ) .

          IF business_data IS INITIAL.
            APPEND VALUE #( %tky               = entity-%tky
                            %state_area        = 'VALIDATE_ORDERED_ITEM'
                            %msg               = NEW zcx_ac_exceptions(
                                                     textid   = zcx_ac_exceptions=>product_unkown
                                                     severity = if_abap_behv_message=>severity-error )
                            %element-ordereditem = if_abap_behv=>mk-on ) TO reported-shoppingcart.
          ENDIF.

        CATCH cx_root INTO DATA(exception).
          ASSERT 1 = 2.
*          out->write( cl_message_helper=>get_latest_t100_exception( exception )->if_message~get_longtext( ) ).
      ENDTRY.
    ENDLOOP.
  ENDMETHOD.
```

</details>

<hr>

#### ![inline](./Images/source-code_grey_small.png) Code snippet **`validateRequestedDeliveryDate`**

<hr>

<details>

<summary>Click to expand the source code</summary>

```ABAP
  
 METHOD validateRequestedDeliveryDate.

    "For your convinience there is a central class ZAX_AC_EXCEPTIONS that is beeing used here.
    
    READ ENTITIES OF zr_AC000000U## IN LOCAL MODE
       ENTITY ShoppingCart
         FIELDS (  RequestedDeliveryDate )
         WITH CORRESPONDING #( keys )
       RESULT DATA(entities).

    LOOP AT entities INTO DATA(entity).
      APPEND VALUE #(  %tky               = entity-%tky
                       %state_area        = 'VALIDATE_DATES' ) TO reported-shoppingcart.

      APPEND VALUE #(  %tky               = entity-%tky
                       %state_area        = 'OUTDATED_DATES' ) TO reported-shoppingcart.

      IF entity-RequestedDeliveryDate IS INITIAL.
        APPEND VALUE #( %tky = entity-%tky ) TO failed-shoppingcart.

        APPEND VALUE #( %tky               = entity-%tky
                        %state_area        = 'VALIDATE_DATES'
                         %msg              = NEW zcx_ac_exceptions(
                                                 textid   = zcx_ac_exceptions=>enter_requested_delivery_date
                                                 severity = if_abap_behv_message=>severity-error )
                        %element-requesteddeliverydate = if_abap_behv=>mk-on ) TO reported-shoppingcart.

      ELSEIF entity-RequestedDeliveryDate < cl_abap_context_info=>get_system_date( ).
        APPEND VALUE #( %tky               = entity-%tky ) TO failed-shoppingcart.

        APPEND VALUE #( %tky               = entity-%tky
                        %state_area        = 'OUTDATED_DATES'
                         %msg              = NEW zcx_ac_exceptions(
                                                                textid     = zcx_ac_exceptions=>out_dated_req_delivery_date
                                                                severity   = if_abap_behv_message=>severity-error )
                        %element-requesteddeliverydate = if_abap_behv=>mk-on ) TO reported-shoppingcart.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
```

</details>

<hr>

#### ![inline](./Images/source-code_grey_small.png)  Code snippet **`validateOrderQuantity`**

<hr>

<details>

<summary>Click to expand the source code</summary>

```ABAP
 METHOD validateOrderQuantity.

    "For your convinience there is a central class ZAX_AC_EXCEPTIONS that is beeing used here.
  
    READ ENTITIES OF zr_AC000000U## IN LOCAL MODE
       ENTITY ShoppingCart
         FIELDS (  OrderQuantity )
         WITH CORRESPONDING #( keys )
       RESULT DATA(entities).

    LOOP AT entities INTO DATA(entity).
      APPEND VALUE #(  %tky               = entity-%tky
                       %state_area        = 'VALIDATE_ORDER_QUANTITY' ) TO reported-shoppingcart.

      IF entity-OrderQuantity IS INITIAL.
        APPEND VALUE #( %tky = entity-%tky ) TO failed-shoppingcart.

        APPEND VALUE #( %tky               = entity-%tky
                        %state_area        = 'VALIDATE_ORDER_QUANTITY'
                         %msg              = NEW zcx_ac_exceptions(
                                                 textid   = zcx_ac_exceptions=>enter_order_quantity
                                                 severity = if_abap_behv_message=>severity-error )
                        %element-requesteddeliverydate = if_abap_behv=>mk-on ) TO reported-shoppingcart.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.         
```

</details>

<hr>

</details>


### Exercise 5.2.2: Implement the validations using Joule 💎   

<details>   
<summary>Click to expand</summary>  

1. Now implement the method **`validateOrderQuantity`** in the implementation part of the local handler class.   
Place the cursor behind the statement `METHOD validateOrderQuantity.` and press **Ctrl+1** to start the quick assistant.

2. In the popup select **Predict RAP business logic**.  

3. Enter the following prompt:  
   **`Check that the field is not initial`**   
   in the dialogue box of the instant action and press **Run**.    

4. Check that the generated code looks like the following.   

 ```ABAP
 METHOD validateOrderQuantity.

  READ ENTITIES OF zr_AC000000U## IN LOCAL MODE
    ENTITY ShoppingCart
      FIELDS ( OrderQuantity )
      WITH CORRESPONDING #( keys )
    RESULT DATA(entities).

  LOOP AT entities INTO DATA(entity).
    IF entity-OrderQuantity IS INITIAL.
      APPEND VALUE #( %tky = entity-%tky ) TO failed-ShoppingCart.
      APPEND VALUE #(
          %tky        = entity-%tky
          %state_area = 'Validation'
          %msg        = new_message_with_text(
            text     = 'Order Quantity must not be initial'
            severity = if_abap_behv_message=>severity-error
          )
      ) TO reported-ShoppingCart.
    ENDIF.
  ENDLOOP.

  ENDMETHOD.
 ```

5. Next implement the method `validateRequestedDeliveryDate` in the implementation part of the local handler class.   
Place the cursor behind the statement `METHOD validateRequestedDeliveryDate.` and press **Ctrl+1** to start the quick assistant.

6. Enter the following prompt 
   
   ```
   Check that the field is not initial and that the date entered in the field is in the future. 
   Do not use the outdated sy-datum statement.
   ```
  
   and press **Run**. 

7. Check that the generated code looks like follows:

```ABAP    
  METHOD validateRequestedDeliveryDate.

    READ ENTITIES OF zr_AC000000U## IN LOCAL MODE
      ENTITY ShoppingCart
        FIELDS ( RequestedDeliveryDate )
        WITH CORRESPONDING #( keys )
      RESULT DATA(entities).

    LOOP AT entities INTO DATA(entity).
      " Check if the RequestedDeliveryDate is initial
      IF entity-RequestedDeliveryDate IS INITIAL.
        APPEND VALUE #( %tky = entity-%tky ) TO failed-ShoppingCart.
        APPEND VALUE #(
            %tky        = entity-%tky
            %state_area = 'Validation'
            %msg        = new_message_with_text(
              text     = 'Requested Delivery Date must not be initial'
              severity = if_abap_behv_message=>severity-error
            )
        ) TO reported-ShoppingCart.
      ELSE.
        " Check if the RequestedDeliveryDate is in the future
        IF entity-RequestedDeliveryDate <= cl_abap_context_info=>get_system_date( ).
          APPEND VALUE #( %tky = entity-%tky ) TO failed-ShoppingCart.
          APPEND VALUE #(
              %tky        = entity-%tky
              %state_area = 'Validation'
              %msg        = new_message_with_text(
                text     = 'Requested Delivery Date must be in the future'
                severity = if_abap_behv_message=>severity-error
              )
          ) TO reported-ShoppingCart.
        ENDIF.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.
```

8. Next implement the method `validateOrderedItem` in the implementation part of the local handler class.   
Place the cursor behind the statement `METHOD validateOrderedItem.` and press **Ctrl+1** to start the quick assistant.

9. Enter the following prompt 
   
   ```
   Check that the field is not initial.
   Create a new instance of class zcl_ac_product_api.
   Use the method product_exists to check if the product exists.
   ```
  
   and press **Run**. 

10. Check that the generated code looks like follows:

```ABAP    
  METHOD validateOrderedItem.


    READ ENTITIES OF zr_AC000000U## IN LOCAL MODE
      ENTITY ShoppingCart
        FIELDS ( OrderedItem )
        WITH CORRESPONDING #( keys )
      RESULT DATA(entities).

    LOOP AT entities INTO DATA(entity).
      " Check if the OrderedItem is initial
      IF entity-OrderedItem IS INITIAL.
        APPEND VALUE #( %tky = entity-%tky ) TO failed-ShoppingCart.
        APPEND VALUE #(
            %tky        = entity-%tky
            %state_area = 'Validation'
            %msg        = new_message_with_text(
              text     = 'Ordered Item must not be initial'
              severity = if_abap_behv_message=>severity-error
            )
        ) TO reported-ShoppingCart.
      ELSE.
        " Create an instance of the product API class
        DATA(lo_product_api) = NEW zcl_ac_product_api( ).

        " Check if the product exists using the product_exists method
        IF NOT lo_product_api->product_exists( entity-OrderedItem ).
          APPEND VALUE #( %tky = entity-%tky ) TO failed-ShoppingCart.
          APPEND VALUE #(
              %tky        = entity-%tky
              %state_area = 'Validation'
              %msg        = new_message_with_text(
                text     = 'Ordered Item does not exist'
                severity = if_abap_behv_message=>severity-error
              )
          ) TO reported-ShoppingCart.
        ENDIF.
      ENDIF.
    ENDLOOP.


  ENDMETHOD.
```

 </details>



## Exercise 5.3: Preview and Test the enhanced Online Shop App

> Now the SAP Fiori elements app can be tested.    

You can either refresh your application in the browser using **F5** if the browser is still open - or go to your service binding **`ZUI_AC000000U##_O4`** and start the Fiori elements App preview for the **`ShoppingCart`** entity set.

1. Click **Create** to create a new entry.

2. Select `TG11` as OrderdItem, enter an quantity and a requested delivery date **that lies in the past**. 

   The draft will be updated.

3. Now click **Create**. You should get following error messages displayed:  
   **Requested delivery date is in the past** .

    ![Preview](./Images/05-050-test-validation-ui.png)

## Summary 

Now that you have... 

- defined validations in the behavior definition, 
- implemented them in the behavior pool, and
- previewed and tested the enhanced Fiori elements app,

you can continue with the next exercise.

[Next Lesson](./6_ABAP-Cloud_RAP–DynamicFeatureControl.md)

