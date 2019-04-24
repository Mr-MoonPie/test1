Map<String, copado__Org__c> orgCredentials = new Map<String, copado__Org__c>();
for(copado__Org__c o : [select Id, Name, copado__Environment__c from copado__Org__c where copado__Org_Type__c='Sandbox']){
	orgCredentials.put(o.Name, o);
}

List<copado__User_Story__c> stories = new List<copado__User_Story__c>();
copado__User_Story__c u1 = new copado__User_Story__c(Module_External_Id__c='Ebike-Module7-US1');
u1.copado__User_Story_Title__c = 'Module 7: Apex conflict change in Dev1';
u1.copado__Project__r = new copado__Project__c(Module_External_Id__c='EBike-Project');
u1.copado__Status__c = 'Approved';
u1.copado__Functional_Specifications__c = '';
u1.copado__Org_Credential__c = orgCredentials.get('Dev1').Id;
u1.copado__Environment__c = orgCredentials.get('Dev1').copado__Environment__c;
stories.add(u1);

copado__User_Story__c u2 = new copado__User_Story__c(Module_External_Id__c='Ebike-Module7-US2');
u2.copado__User_Story_Title__c = 'Module 7: Apex conflict change in Dev2';
u2.copado__Project__r = new copado__Project__c(Module_External_Id__c='EBike-Project');
u2.copado__Status__c = 'Approved';
u2.copado__Functional_Specifications__c = '';
u2.copado__Org_Credential__c = orgCredentials.get('Dev2').Id;
u2.copado__Environment__c = orgCredentials.get('Dev2').copado__Environment__c;
stories.add(u2);
upsert stories Module_External_Id__c;