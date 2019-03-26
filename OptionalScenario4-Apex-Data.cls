copado__Org__c hotfix = [select Id, Name, copado__Environment__c from copado__Org__c where Name='HotFix' limit 1];
copado__Project__c p = [select Id from copado__Project__c where Name='E Bike Application' and Module_External_Id__c='EBike-Project' limit 1];
/*
copado__User_Story__c u1 = new copado__User_Story__c(Module_External_Id__c='Ebike-Module6-US1');
u1.copado__User_Story_Title__c = 'Module 6: URGENT fix for production.';
u1.copado__Project__c = p.Id;
u1.copado__Status__c = 'Approved';
u1.copado__Functional_Specifications__c = '';
u1.copado__Org_Credential__c = hotfix.Id;
u1.copado__Environment__c = hotfix.copado__Environment__c;
upsert u1 Module_External_Id__c;*/