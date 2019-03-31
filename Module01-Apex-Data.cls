copado__Environment__c prod = [select Id, Name, copado__Run_all_tests__c, copado__Minimum_Apex_Test_Coverage__c from copado__Environment__c where Name='Production' limit 1];
prod.copado__Run_all_tests__c = true;
prod.copado__Minimum_Apex_Test_Coverage__c = 85;
update prod;