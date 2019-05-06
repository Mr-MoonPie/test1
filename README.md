# EBike-Copado-Trail
Branch: SetupScripts

This branch houses the metadata setup the will be used by Copado to initialize a user's Platform Trial org for each Module.  Deployment records will be pre-created for the Ebike Application that will automatically pull information from the git repository into the Salesforce org (either the Platform Trial Org or a specified sandbox).
The "Apex-Data" files contain apex anonymous code blocks that create records, e.g. Project, User Stories etc...
The "Apex-Metadata" files contain the apex anonymous code blocks that are used to create Deployment and Continuous Integration records (Copado setup).

## Branches in this git repository
This repository contains multiple branches.  The branches are used to store different configurations for different modules in the trail.  The Continuous Integration records created by Copado will then retrieve the information for a specific module and deploy that metadata into the Platform Trial org, or the pre-configured sandbox.

## The README.md file
The README.md file will be different for each branch and will contain useful information about the metadata currently held in the branch.

## Branch Contents
This branch contains the following metadata files
- classes/CopadoTrailHelper
- classes/TestCopadoTrailHelper
- objects/copado__Deployment__c
- objects/copado__Git_Repository__c
- objects/copado__Project__c
- objects/copado__User_Story__c
- profiles/Admin
- profiles/System Admin

The CopadoTrailHelper and corresponding test class are used to trim the metadata index and remove metadata components based on a particular namespace (by searching for the text in the api name).  This has been designed purely for demonstration purposes to reduce scrolling and aid the user during the intial stages of the trail.  This can be deleted by the user manually by going into the module's deployment record and removing the Deployment step called, "Remove Copado from index".
This configuration is also be stored in the Module's Apex-Metadata scripts if it needs to be permanently removed.  Refreshing the Metadata index manually from within Copado will restore the full index.
