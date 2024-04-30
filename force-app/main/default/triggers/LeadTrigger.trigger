trigger LeadTrigger on Lead (Before Insert,After Insert,Before Update,After Update,Before Delete, After Delete,After Undelete) {
    if(Trigger.isInsert && Trigger.isBefore){
        MS_LeadTriggerHandler.UpdateLeadRecordType(Trigger.new);
    }
    if(Trigger.isInsert && Trigger.isAfter){
        MS_LeadTriggerHandler.updateOwnerforRecordType(Trigger.new);
    } 
}