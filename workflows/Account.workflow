<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <flowActions>
        <fullName>Trigger_Contact_Update</fullName>
        <description>Pass account ID and BillingCountry to the triggered flow.</description>
        <flow>Update_Account_Contacts</flow>
        <flowInputs>
            <name>AccountId</name>
            <value>{!Id}</value>
        </flowInputs>
        <flowInputs>
            <name>BillingCountry</name>
            <value>{!BillingCountry}</value>
        </flowInputs>
        <label>Trigger Contact Update</label>
        <language>en_US</language>
        <protected>false</protected>
    </flowActions>
    <rules>
        <fullName>On Account Update</fullName>
        <actions>
            <name>Trigger_Contact_Update</name>
            <type>FlowAction</type>
        </actions>
        <active>true</active>
        <description>Triggered by an update to an account.</description>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
