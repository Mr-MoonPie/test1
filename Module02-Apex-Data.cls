copado__Deployment_Flow__c f = [select Id from copado__Deployment_Flow__c where Name='Copado Playground' limit 1];
Map<String, copado__Org__c> orgCredentials = new Map<String, copado__Org__c>();

for(copado__Org__c o : [select Id, Name, copado__Environment__c from copado__Org__c where copado__Org_Type__c='Sandbox']){
	orgCredentials.put(o.Name, o);
}

List<copado__User_Story__c> stories = new List<copado__User_Story__c>();

copado__Project__c p = new copado__Project__c(Name='E Bike Application', Module_External_Id__c='EBike-Project');
p.copado__Deployment_Flow__c = f.Id;
p.copado__Status__c = 'In progress';
p.copado__Description__c = 'This is the record for our project where we will create the EBike application.';
upsert p Module_External_Id__c;

copado__User_Story__c u1 = new copado__User_Story__c(Module_External_Id__c='Ebike-Module2-US1');
u1.copado__User_Story_Title__c = 'Module 2: Object Model for Bike app';
u1.copado__Project__c = p.Id;
u1.copado__Status__c = 'Approved';
u1.copado__Functional_Specifications__c = 'The object model will consist of an Order, Order Item, Product_Family__c and Product__c objects. We will also commit the Admin profile with this User Story to ensure that admins have permissions when we deploy this to other orgs.';
u1.copado__Org_Credential__c = orgCredentials.get('Dev1').Id;
u1.copado__Environment__c = orgCredentials.get('Dev1').copado__Environment__c;
stories.add(u1);

copado__User_Story__c u2 = new copado__User_Story__c(Module_External_Id__c='Ebike-Module2-US2');
u2.copado__User_Story_Title__c = 'Module 2: EBike application and tabs';
u2.copado__Project__c = p.Id;
u2.copado__Status__c = 'Approved';
u2.copado__Functional_Specifications__c = 'We will commit all the Custom Tabs and EBikes Custom Application in this User Story. As our Custom Application has a logo, we will also commit the ContentAsset called, “logo”.';
u2.copado__Org_Credential__c = orgCredentials.get('Dev1').Id;
u2.copado__Environment__c = orgCredentials.get('Dev1').copado__Environment__c;
stories.add(u2);
upsert stories Module_External_Id__c;