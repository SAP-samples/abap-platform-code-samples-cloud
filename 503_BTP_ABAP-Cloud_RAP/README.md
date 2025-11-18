
< [Previous Unit](../502_BTP_ABAP-Cloud_GettingStarted/README.md)

< [Home](../README.md)


<!-- Dummy Update to trigger Content Portal -->

# RESTful Application Programming Model (RAP) - Components

The ABAP RESTful application programming model defines the architecture for end-to-end development of OData services (such as SAP Fiori apps) in the ABAP environment. It supports the development of all types of Fiori applications and the publishing of Web APIs. It is based on technologies and frameworks such as Core Data Services (CDS) for defining semantically rich data models and a service model infrastructure for creating OData services with bindings to an OData protocol and ABAP-based application services for custom logic and SAPUI5-based user interfaces.

<details>   
<summary>Read more ...</summary> 

In this unit, you will create an online shop application using the ABAP RESTful Application Programming Model. The required objects for RAP application include:

* database tables
* CDS entities
* CDS behavior definitions
* CDS mtadata extensions
* A service definition
* A service binding

## ABAP RESTful Application Programming Model - Objects

![RAP_programming_model](./Images/00_000_RAP_programming_model.png)

Developing a RAP application consists of the following main steps:

**Provide the Database Tables**

Developing a RAP application starts with providing the database tables. Depending on the development scenario, these can be existing tables, legacy tables, or tables created specifically for this application.

**Define the Data Model.**

The data model of the business object is defined with CDS views. Depending on whether it is a simple or a composite business object, one or more CDS views are required. In the case of a composite business object, this is also the place where you define the entity hierarchy.

**Define and Implement the Behavior (transactional Apps only)**

The behavior of a RAP application business object is defined in a repository object called Core Data Service (CDS) Behavior Definition. Usually, the behavior of a RAP business object also requires some additional logic implemented in a certain type of global ABAP class called a behavior pool. For a non-transactional application, for example, a list report, the behavior definition or implementation can be omitted.

**Project the RAP Business Object and provide service-specific Metadata**

The RAP business object projection consists of a data model projection and, if a behavior has been defined, a behavior projection. To define a projection, you create one or more CDS projection views, which is a type of CDS view, and a behavior projection, which is a type of behavior definition. For UI services, the projection view(s) should be enriched with UI-specific metadata. To support future extensibility of the application, we recommend placing the service-specific annotations in metadata extensions.

**Define the Service**

In RESTful applications, a service is defined by creating a service definition. The service definition references the projection views and specifies what should be exposed, that is, what is visible to the service consumer.

**Bind the Service and Test the Service**

A service binding is needed to specify how the service should be consumed (UI or Web API) and via which protocol (OData V2 or OData V4). For UI services, a preview is available.

</details>

# Exercises

- [1 - Generate transactional UI service](1_ABAP-Cloud_RAP–Generate_Transactional_UI_Service.md)
- [2 - Enhance generated data model](2_ABAP-Cloud_RAP–Enhance_Generated_Model.md)
- [3 - Add determinations](3_ABAP-Cloud_RAP–Determinations.md)
- [4 - Add the creation of sales orders in SAP S/4HANA Cloud](4_ABAP-Cloud_RAP–Salesorder_Creation.md)
- [5 - Add validations](5_ABAP-Cloud_RAP–Validations.md)  
- [6 - Add dynamic feature control](6_ABAP-Cloud_RAP–DynamicFeatureControl.md)

 
[Next Lesson](../504_BTP_ABAP-Cloud_BAS/README.md)

