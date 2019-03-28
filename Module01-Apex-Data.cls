copado__Environment__c prod = [select Id, Name,  from copado__Environment__c where Name='Production' limit 1];
prod.copado__Run_all_tests__c = true;
prod.copado__Minimum_Apex_Test_Coverage__c = 0.85;
update prod;