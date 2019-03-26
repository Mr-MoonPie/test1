/**
 * This apex snippet will create a 1 deployment with CI records in order to configure the
 * CopadoOrg as well as the sandbox.
 * @author Philipp Rackwitz
 * @version 1.0
 */

String TRAIL_NAME ='EBike';
String MODULE_NAME = 'Module02';
String DEPLOYMENTNAME = TRAIL_NAME+' '+MODULE_NAME;
String GITREPOSITORY_NAME = 'E-Bike Copado Trail';
String GITREPOSITORY_URL = 'TBC';
String DESTINATION_ORG_NAME ='Dev1'; // Options: Dev1, Dev2, UAT, Production, Hotfix, Copado

Id orgCred_copadoOrg = [select Id from copado__Org__c where copado__Environment__r.Name='Copado' limit 1].Id;
Id orgCred_sandbox = [select Id from copado__Org__c where copado__Environment__r.Name=:DESTINATION_ORG_NAME limit 1].Id;


/**
 * The below private static helper methods are used below to create the records.
 */
private static Id checkTrailRepoExists() {
	List<copado__Git_Repository__c> repos = [select Id from copado__Git_Repository__c where Name=:GITREPOSITORY_NAME];
	if(repos.size()==0) {
		copado__Git_Repository__c repo = new copado__Git_Repository__c(Name=GITREPOSITORY_NAME);
		repo.copado__URI__c = GITREPOSITORY_URL;
		insert repo;
		return repo.Id;
	}
	else {
		return repos.get(0).Id;
	}
}
private static copado__Deployment__c insertDeployment(Id destOrgId) {
	copado__Deployment__c x = new copado__Deployment__c(Name=DEPLOYMENTNAME);
	x.copado__Send_Deployment_Complete_email__c = false;
	insert x;
	insertDestinationOrg(x.Id, destOrgId);
	return x;
}
private static void insertDestinationOrg(Id dId, Id destOrgId) {
	copado__Destination_Org__c x = new copado__Destination_Org__c();
	x.copado__Deployment__c = dId;
	x.copado__To_Org__c = destOrgId;
	insert x;
}
private static copado__Step__c createDeploymentStep(Id dId, Integer iorder, String stepType, String stepName) {
	copado__Step__c x = new copado__Step__c(Name=stepName);
	x.copado__Deployment__c = dId;
	x.copado__Order__c = iorder;
	x.copado__Type__c = stepType;
	x.copado__CheckOnly__c = false;
	return x;
}
private static Attachment insertAttachment(Id parentId, String name, String b) {
	Attachment x = new Attachment(ParentId=parentId, Name=name, body=Blob.valueOf(b));
	insert x;
	return x;
}
private static String createCacheRefreshString(String recordId, String apiKey) {
	String s = '{"type":"wait","method":"POST","url":"https://copado.herokuapp.com/json/v1/webhook/metadata/'+recordId+'?api_key='+apiKey+'","body":"","queryParameters":[["api_key","'+apiKey+'"]],"headers":[]}';
	return s;
}
private static String createRunCIjobString(String recordId, String apiKey) {
	String s = '{"type":"wait","method":"POST","url":"https://copado.herokuapp.com/json/v1/webhook/ci/'+recordId+'?api_key='+apiKey+'","body":"","queryParameters":[["api_key","'+apiKey+'"]],"headers":[]}';
	return s;
}
private static copado__Step__c createUrlCalloutStep(Id deployId, Integer stepOrder, String stepName, String datajson) {
	copado__Step__c s = createDeploymentStep(deployId, stepOrder, 'URL Callout', stepName);
	s.copado__DataJson__c = datajson;
	return s;
}
private static copado__Continuous_Integration__c createCIrecord(String branchName, Id destOrgId, Id gitRepoId) {
	copado__Continuous_Integration__c x = new copado__Continuous_Integration__c(Name=DEPLOYMENTNAME);
	x.copado__Active__c = true;
	x.copado__Git_Repository__c = gitRepoId;
	x.copado__Branch__c = branchName;
	x.copado__Run_All_Tests__c = false;
	x.copado__Check_Only__c = false;
	x.copado__Files_to_be_deployed__c = 'Deploy all Files';
	x.copado__Destination_Org_Credential__c = destOrgId;
	//insert x;
	return x;
}

//Execute Apex anonymous code DO NOT MODIFY THE BELOW CODE
List<copado__Continuous_Integration__c> cijobs = new List<copado__Continuous_Integration__c>();
List<copado__Step__c> steps = new List<copado__Step__c>();

User u = [select Id, Division from User where Id=:UserInfo.getUserId() limit 1];
Id gitRepoId = checkTrailRepoExists();


//Creating a Deployment record
copado__Deployment__c depl = insertDeployment(orgCred_copadoOrg);

//Creating CI records
copado__Continuous_Integration__c copadoOrgCiJob = createCIrecord(MODULE_NAME+'-CopadoOrg', orgCred_copadoOrg, gitRepoId);
copado__Continuous_Integration__c sandboxCIjob = createCIrecord(MODULE_NAME+'-EbikeApp', orgCred_sandbox, gitRepoId);
cijobs.add(copadoOrgCiJob);
cijobs.add(sandboxCIjob);
insert cijobs;

//Create URL callout deployment steps (Copado Org)
String copadoOrgCiJobURI = createRunCIjobString(cijobs[0].Id, u.Division);
steps.add(createUrlCalloutStep(depl.Id, 1, 'Configure CopadoOrg', copadoOrgCiJobURI));

//Create URL callout deployment steps (Sandbox)
String sandboxCIjobURI = createRunCIjobString(cijobs[1].Id, u.Division);
steps.add(createUrlCalloutStep(depl.Id, 2, 'Configure Sandbox', sandboxCIjobURI));

//Create URL callout deployment steps (Refresh cache)
String cacheRefreshString = createCacheRefreshString(orgCred_sandbox, u.Division);
steps.add(createUrlCalloutStep(depl.Id, 3, 'Refresh Sandbox cache', cacheRefreshString));

insert steps;