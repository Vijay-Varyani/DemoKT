trigger LicenseTrigger on sfLma__License__c (Before Insert,After Insert,Before Update,After Update,Before Delete, After Delete,After Undelete ) {
    if(trigger.isInsert && trigger.isBefore){
        MS_LicenseTriggerHandler.PopulateLeadEmailOnLicense(trigger.new);
    }
}