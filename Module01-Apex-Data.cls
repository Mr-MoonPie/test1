copado__Environment__c prod = [select Id, Name, copado__Run_all_tests__c, copado__Minimum_Apex_Test_Coverage__c from copado__Environment__c where Name='Production' limit 1];
prod.copado__Run_all_tests__c = true;
prod.copado__Minimum_Apex_Test_Coverage__c = 85;
update prod;

String GITREPOSITORY_NAME = 'E-Bike Copado Trail';
String GITREPOSITORY_URL = 'https://github.com/Mr-MoonPie/test1';
List<copado__Git_Repository__c> repos = [select Id from copado__Git_Repository__c where Name=:GITREPOSITORY_NAME and copado__URI__c=:GITREPOSITORY_URL];
if(repos.size()==0) {
	copado__Git_Repository__c repo = new copado__Git_Repository__c(Name=GITREPOSITORY_NAME);
	repo.copado__URI__c = GITREPOSITORY_URL;
	repo.Module_External_Id__c = GITREPOSITORY_URL;
	upsert repo Module_External_Id__c;
}

copado__Deployment_Flow__c f = [select Id from copado__Deployment_Flow__c where Name='Copado Playground' limit 1];
copado__Project__c p = new copado__Project__c(Name='E Bike Application', Module_External_Id__c='EBike-Project');
p.copado__Deployment_Flow__c = f.Id;
p.copado__Status__c = 'In progress';
p.copado__Description__c = 'This is the record for our project where we will create the EBike application.';
p.copado__Index_Metadata__c = true;
p.copado__Start_Date__c = Date.today();
p.copado__End_Date__c = Date.today().addDays(30);
upsert p Module_External_Id__c