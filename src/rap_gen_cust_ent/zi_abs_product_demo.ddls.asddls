@ObjectModel.query.implementedBy: 'ABAP:ZCL_CE_ABS_PRODUCT_DEMO'
@UI: {
  headerInfo: {
    typeName: 'Product', 
    typeNamePlural: 'Products', 
    title: {
      type: #STANDARD, 
      label: 'Product', 
      value: 'PRODUCT'
    }
  }
}
define root custom entity ZI_ABS_PRODUCT_DEMO
{
  @UI.facet: [ {
    id: 'idCollection', 
    type: #COLLECTION, 
    label: 'Product', 
    position: 10 
  }, {
    id: 'idIdentification', 
    parentId: 'idCollection', 
    type: #IDENTIFICATION_REFERENCE, 
    label: 'General Information', 
    position: 10 
  } ]
  @UI.lineItem: [ {
    position: 10 , 
    importance: #HIGH, 
    label: 'PRODUCT'
  } ]
  @UI.identification: [ {
    position: 10 , 
    label: 'PRODUCT'
  } ]
  @UI.selectionField: [ {
    position: 10 
  } ]
  key PRODUCT : abap.char( 10 );
  @UI.lineItem: [ {
    position: 20 , 
    importance: #HIGH, 
    label: 'PRODUCTTYPE'
  } ]
  @UI.identification: [ {
    position: 20 , 
    label: 'PRODUCTTYPE'
  } ]
  PRODUCTTYPE : abap.char( 2 );
  @UI.lineItem: [ {
    position: 30 , 
    importance: #HIGH, 
    label: 'PRODUCTCATEGORY'
  } ]
  @UI.identification: [ {
    position: 30 , 
    label: 'PRODUCTCATEGORY'
  } ]
  PRODUCTCATEGORY : abap.char( 40 );
  @UI.lineItem: [ {
    position: 40 , 
    importance: #HIGH, 
    label: 'CREATEDBYUSER'
  } ]
  @UI.identification: [ {
    position: 40 , 
    label: 'CREATEDBYUSER'
  } ]
  CREATEDBYUSER : abap.char( 10 );
  @UI.lineItem: [ {
    position: 50 , 
    importance: #HIGH
  } ]
  @UI.identification: [ {
    position: 50 
  } ]
  CREATIONDATETIME : tzntstmpl;
  @UI.lineItem: [ {
    position: 60 , 
    importance: #HIGH, 
    label: 'LASTCHANGEDBYUSER'
  } ]
  @UI.identification: [ {
    position: 60 , 
    label: 'LASTCHANGEDBYUSER'
  } ]
  LASTCHANGEDBYUSER : abap.char( 10 );
  @UI.lineItem: [ {
    position: 70 , 
    importance: #HIGH
  } ]
  @UI.identification: [ {
    position: 70 
  } ]
  LASTCHANGEDDATETIME : tzntstmpl;
  @Semantics.amount.currencyCode: 'CURRENCY'
  @UI.lineItem: [ {
    position: 80 , 
    importance: #HIGH, 
    label: 'PRICE'
  } ]
  @UI.identification: [ {
    position: 80 , 
    label: 'PRICE'
  } ]
  PRICE : abap.curr( 16, 2 );
  @UI.hidden: true
  CURRENCY : abap.cuky( 5 );
  @Semantics.quantity.unitOfMeasure: 'DIMENSIONUNIT'
  @UI.lineItem: [ {
    position: 100 , 
    importance: #HIGH, 
    label: 'HEIGHT'
  } ]
  @UI.identification: [ {
    position: 100 , 
    label: 'HEIGHT'
  } ]
  HEIGHT : abap.dec( 13, 3 );
  @Semantics.quantity.unitOfMeasure: 'DIMENSIONUNIT'
  @UI.lineItem: [ {
    position: 110 , 
    importance: #HIGH, 
    label: 'WIDTH'
  } ]
  @UI.identification: [ {
    position: 110 , 
    label: 'WIDTH'
  } ]
  WIDTH : abap.dec( 13, 3 );
  @Semantics.quantity.unitOfMeasure: 'DIMENSIONUNIT'
  @UI.lineItem: [ {
    position: 120 , 
    importance: #HIGH, 
    label: 'DEPTH'
  } ]
  @UI.identification: [ {
    position: 120 , 
    label: 'DEPTH'
  } ]
  DEPTH : abap.dec( 13, 3 );
  @UI.hidden: true
  DIMENSIONUNIT : abap.unit( 3 );
  @UI.lineItem: [ {
    position: 140 , 
    importance: #HIGH, 
    label: 'PRODUCTPICTUREURL'
  } ]
  @UI.identification: [ {
    position: 140 , 
    label: 'PRODUCTPICTUREURL'
  } ]
  PRODUCTPICTUREURL : abap.char( 255 );
  @UI.lineItem: [ {
    position: 150 , 
    importance: #HIGH, 
    label: 'PRODUCTVALUEADDEDTAX'
  } ]
  @UI.identification: [ {
    position: 150 , 
    label: 'PRODUCTVALUEADDEDTAX'
  } ]
  PRODUCTVALUEADDEDTAX : abap.int1( 3 );
  @UI.lineItem: [ {
    position: 160 , 
    importance: #HIGH, 
    label: 'SUPPLIER'
  } ]
  @UI.identification: [ {
    position: 160 , 
    label: 'SUPPLIER'
  } ]
  SUPPLIER : abap.char( 10 );
  @UI.lineItem: [ {
    position: 170 , 
    importance: #HIGH, 
    label: 'PRODUCTBASEUNIT'
  } ]
  @UI.identification: [ {
    position: 170 , 
    label: 'PRODUCTBASEUNIT'
  } ]
  PRODUCTBASEUNIT : abap.char( 3 );
  @Semantics.quantity.unitOfMeasure: 'WEIGHTUNIT'
  @UI.lineItem: [ {
    position: 180 , 
    importance: #HIGH, 
    label: 'WEIGHT'
  } ]
  @UI.identification: [ {
    position: 180 , 
    label: 'WEIGHT'
  } ]
  WEIGHT : abap.dec( 13, 3 );
  @UI.hidden: true
  WEIGHTUNIT : abap.unit( 3 );
  @UI.lineItem: [ {
    position: 200 , 
    importance: #HIGH, 
    label: 'ORIGINALLANGUAGE'
  } ]
  @UI.identification: [ {
    position: 200 , 
    label: 'ORIGINALLANGUAGE'
  } ]
  ORIGINALLANGUAGE : abap.char( 2 );
  
}
