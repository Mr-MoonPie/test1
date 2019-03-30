copado__Org__c dev1 = [select Id, Name, copado__Environment__c, copado__Environment__r.Name from copado__Org__c where Name='Dev1' limit 1];
copado__Project__c p = [select Id from copado__Project__c where Name='E Bike Application' and Module_External_Id__c='EBike-Project' limit 1];

copado__User_Story__c u1 = new copado__User_Story__c(Module_External_Id__c='Ebike-Module6-US1');
u1.copado__User_Story_Title__c = 'Module 9: Deployment of UI components.';
u1.copado__Project__c = p.Id;
u1.copado__Status__c = 'Approved';
u1.copado__Functional_Specifications__c = '';
u1.copado__Org_Credential__c = dev1.Id;
u1.copado__Environment__c = dev1.copado__Environment__c;
upsert u1 Module_External_Id__c;

copado__Test_Script__c ts = new copado__Test_Script__c();
ts.copado__Introduction__c = '....';
ts.copado__Org__c = dev1.copado__Environment__r.Name;
ts.copado__Prerequisites__c = 'Make sure that some sample data has been loaded from Module 8.';
ts.copado__Status__c = 'Ready for testing';
ts.copado__Test_Description__c = 'In this test we will....';
ts.copado__Test_Title__c = '....';
ts.copado__User_Story__c = u1.Id;
insert ts;

List<copado__Test_Script_Step__c> testScriptSteps = new List<copado__Test_Script_Step__c>();
copado__Test_Script_Step__c tss1 = new copado__Test_Script_Step__c(copado__Test_Script__c=ts.Id);
tss1.copado__Action_Description__c = 'a';
tss1.copado__Expected_Result__c = 'a';
tss1.copado__Guidance_notes__c = 'a';
tss1.copado__Order__c = 1;
testScriptSteps.add(tss1);

copado__Test_Script_Step__c tss2 = new copado__Test_Script_Step__c(copado__Test_Script__c=ts.Id);
tss2.copado__Action_Description__c = 'b';
tss2.copado__Expected_Result__c = 'b';
tss2.copado__Guidance_notes__c = 'b';
tss2.copado__Order__c = 2;
testScriptSteps.add(tss2);

insert testScriptSteps;

copado__Test_Run__c tr = new copado__Test_Run__c(copado__User_Story__c=u1.Id);
tr.copado__Environment__c= dev1.copado__Environment__r.Name;
tr.copado__Project__c = p.Id;
tr.copado__Test_Phase__c = 'Developer';
tr.copado__Test_Script__c = ts.Id;
tr.copado__Tester__c = UserInfo.getUserId();
tr.copado__Type__c = 'User Interface';
insert tr;