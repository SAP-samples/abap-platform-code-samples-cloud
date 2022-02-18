# ABAP Platform Code Samples for SAP BTP, ABAP environment
[![REUSE status](https://api.reuse.software/badge/github.com/SAP-samples/abap-platform-code-samples-cloud)](https://api.reuse.software/info/github.com/SAP-samples/abap-platform-code-samples-cloud)
## Description

In this repository you will find several packages that contain the sample code of various blog posts.

### How to generate RAP BOs with custom entities  
* Blog Post: [How to generate RAP BOs with custom entities ?](https://blogs.sap.com/2021/09/21/how-to-generate-rap-bos-with-custom-entities)  
* [Code on Github](../../tree/main/src/rap_gen_cust_ent)

### How to design managed RAP business objects with 3 or more levels of nodes
* [How to design managed RAP business objects with 3 or more levels of nodes](https://blogs.sap.com/2022/02/18/how-to-design-managed-rap-business-objects-with-3-or-more-levels-of-nodes/)  
* [Code on Github](../../tree/main/src/zrapcloud)  

## Requirements

This sample code can be deployed on a SAP BTP ABAP Environment system.   
You have to create a package `ZRAPCLOUD` beforehand in `ZLOCAL`. 
The code for each blog post is stored in a separate sub-package (for example `ZRAPCLOUD_RAP_GEN_CUST_ENT`) of the super package `ZRAPCLOUD`.  

## Download and Installation

You can download this code and import it into an ABAP environment system using the ABAP GitCLient. Please be sure to have a package `ZRAPCLOUD` in `ZLOCAL`created beforehand.

## Known Issues

When you try to import this repository into a ABAP environment trial systems it might happen that this import does not run smoothly if another user has already performed an import.

## How to obtain support

[Create an issue](https://github.com/SAP-samples/<repository-name>/issues) in this repository if you find a bug or have questions about the content.
 
For additional support, [ask a question in SAP Community](https://answers.sap.com/questions/ask.html).

## License
Copyright (c) 2021 SAP SE or an SAP affiliate company. All rights reserved. This project is licensed under the Apache Software License, version 2.0 except as noted otherwise in the [LICENSE](LICENSES/Apache-2.0.txt) file.
