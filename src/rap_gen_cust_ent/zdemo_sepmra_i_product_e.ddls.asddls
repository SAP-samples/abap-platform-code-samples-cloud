/********** GENERATED on 09/21/2021 at 20:48:35 by CB0000000021**************/
 @OData.entitySet.name: 'SEPMRA_I_Product_E' 
 @OData.entityType.name: 'SEPMRA_I_Product_EType' 
 define root abstract entity ZDEMO_SEPMRA_I_PRODUCT_E { 
 key Product : abap.char( 10 ) ; 
 @OData.property.valueControl: 'ProductType_vc' 
 ProductType : abap.char( 2 ) ; 
 ProductType_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'ProductCategory_vc' 
 ProductCategory : abap.char( 40 ) ; 
 ProductCategory_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'CreatedByUser_vc' 
 CreatedByUser : abap.char( 10 ) ; 
 CreatedByUser_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'CreationDateTime_vc' 
 CreationDateTime : tzntstmpl ; 
 CreationDateTime_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'LastChangedByUser_vc' 
 LastChangedByUser : abap.char( 10 ) ; 
 LastChangedByUser_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'LastChangedDateTime_vc' 
 LastChangedDateTime : tzntstmpl ; 
 LastChangedDateTime_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'Price_vc' 
 @Semantics.amount.currencyCode: 'Currency' 
 Price : abap.curr( 16, 2 ) ; 
 Price_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'Currency_vc' 
 @Semantics.currencyCode: true 
 Currency : abap.cuky( 5 ) ; 
 Currency_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'Height_vc' 
 @Semantics.quantity.unitOfMeasure: 'DimensionUnit' 
 Height : abap.dec( 13, 3 ) ; 
 Height_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'Width_vc' 
 @Semantics.quantity.unitOfMeasure: 'DimensionUnit' 
 Width : abap.dec( 13, 3 ) ; 
 Width_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'Depth_vc' 
 @Semantics.quantity.unitOfMeasure: 'DimensionUnit' 
 Depth : abap.dec( 13, 3 ) ; 
 Depth_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'DimensionUnit_vc' 
 @Semantics.unitOfMeasure: true 
 DimensionUnit : abap.unit( 3 ) ; 
 DimensionUnit_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'ProductPictureURL_vc' 
 ProductPictureURL : abap.char( 255 ) ; 
 ProductPictureURL_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'ProductValueAddedTax_vc' 
 ProductValueAddedTax : abap.int1 ; 
 ProductValueAddedTax_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'Supplier_vc' 
 Supplier : abap.char( 10 ) ; 
 Supplier_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'ProductBaseUnit_vc' 
 ProductBaseUnit : abap.char( 3 ) ; 
 ProductBaseUnit_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'Weight_vc' 
 @Semantics.quantity.unitOfMeasure: 'WeightUnit' 
 Weight : abap.dec( 13, 3 ) ; 
 Weight_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'WeightUnit_vc' 
 @Semantics.unitOfMeasure: true 
 WeightUnit : abap.unit( 3 ) ; 
 WeightUnit_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'OriginalLanguage_vc' 
 OriginalLanguage : abap.char( 2 ) ; 
 OriginalLanguage_vc : rap_cp_odata_value_control ; 
 
 } 
