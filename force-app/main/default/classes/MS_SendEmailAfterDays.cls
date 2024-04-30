global class MS_SendEmailAfterDays implements Database.Batchable<sObject> {  
    Id salesLeadQueueId = [SELECT Id FROM Group WHERE Type = 'Queue' AND DeveloperName = 'Sales_Leads_Queue' LIMIT 1].Id;
    List<String> userIds = new  List<String>();
    List<String> emailsFromQueue = new List<String>();
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        
        return Database.getQueryLocator([
            SELECT Id, Name, Status,LastModifiedDate,BatchClassTest__c,RecordTypeId,Email,CreatedDate,LeadSource, OwnerId,Company
            FROM Lead
            WHERE ( Status IN ('New','Assigned','Engaged','Contacted' ) AND BatchClassTest__c <= LAST_N_DAYS:1  ) Order By Status DESC
        ]);
    }
    
    global void execute(Database.BatchableContext bc, List<Lead> leads) {
        List<Task> tasksToCreate = new List<Task>();
        List<String> emailContentsNew = new List<String>();
        List<String> emailContentsfor3days = new List<String>();
        List<String> emailContentsfor9days = new List<String>();
        
        
        try {
            for (Lead lead : leads) {
                system.debug('Lead Staus='+lead.Status);
                
                Integer daysSinceModification = Date.today().daysBetween(lead.BatchClassTest__c.date());
                daysSinceModification = Math.abs(daysSinceModification); // Convert to positive value
                
                String taskSubject;
                String taskDescription;
                Boolean isNew = False;
                Boolean isThreeDays = False;
                if ((lead.Status == 'New' ) && (daysSinceModification >= 1 ) && (lead.OwnerId == salesLeadQueueId )) {
                    system.debug(' New Status='+lead.Status);
                    system.debug('Id='+lead.OwnerId);
                    
                    isNew = True;
                    
                    taskSubject = 'Leads Requiring Attention: ' + lead.Company + ' '  + lead.Name;
                    taskDescription = 'This automated task has been generated for a lead that has not been assigned to a Lead Owner and has remained in New status for ' + daysSinceModification + ' days.';
                    Task task = new Task();
                    task.Subject = taskSubject;
                    task.Status = 'New';
                    task.WhoId = lead.Id; // Set WhoId to the lead's Id
                    task.OwnerId = UserInfo.getUserId();
                    task.Description = taskDescription;
                    task.ActivityDate = Date.today().addDays(1);
                    tasksToCreate.add(task);
                    system.debug('Task='+tasksToCreate);
                    
                    
                } else if ((lead.Status == 'Assigned' || lead.Status =='Engaged' || lead.Status =='Contacted') && (daysSinceModification == 3)) {
                    system.debug('Lead Assigned status='+lead.Status);
                    isThreeDays = True;
                    system.debug('Three days=');
                    
                     taskSubject = 'Lead Inactive with No Progress: ' + lead.Company + ' '  + lead.Name;
                    
                    taskDescription = 'This automated task has been generated for an inactive lead where progress has not been made for the past ' + daysSinceModification + ' days.';
                    Task task = new Task();
                    task.Subject = taskSubject;
                    task.Status = 'New';
                    task.WhoId = lead.Id; // Set WhoId to the lead's Id
                    task.OwnerId = UserInfo.getUserId();
                    task.Description = taskDescription;
                    task.ActivityDate = Date.today().addDays(1);
                    tasksToCreate.add(task);
                    system.debug('Task='+tasksToCreate);
                    system.debug('Task 2='+tasksToCreate);
                    
                } else if ((lead.Status == 'Assigned' || lead.Status =='Engaged' || lead.Status =='Contacted') && (daysSinceModification == 9)) {
                    
                    taskSubject = '[Final Reminder] Lead Inactive with No Progress:' + lead.Company + ' '  + lead.Name;
                    taskDescription = 'This automated task has been generated for an inactive lead where progress has not been made for the past ' + daysSinceModification + ' days.';
                    
                    Task task = new Task();
                    task.Subject = taskSubject;
                    task.Status = 'New';
                    task.WhoId = lead.Id; // Set WhoId to the lead's Id
                    task.OwnerId = UserInfo.getUserId();
                    task.Description = taskDescription;
                    task.ActivityDate = Date.today().addDays(1);
                    tasksToCreate.add(task);
                    system.debug('Task 3='+tasksToCreate);
                }else {
                    Continue;
                    
                }
                

                // Populate email content
                if(isThreeDays){
                    system.debug('inside 3 days-- ' + lead.name + lead.Company);    
                }
                
                String htmlTextBody = '';
                
                htmlTextBody += 'Lead Status: ' + lead.Status + '<br />';
                htmlTextBody += 'Lead Name: <a href="https://mindzvuellc--podev2.sandbox.lightning.force.com/' + lead.Id + '">' + lead.Name + '</a></td>';
                htmlTextBody += 'Lead Company: ' + lead.Company + '<br />';
                htmlTextBody += 'Record Type: ' + lead.RecordTypeId + '<br />';
                htmlTextBody += 'Lead Source: ' + lead.LeadSource + '<br />';
                htmlTextBody += 'Last Modified Date: ' + lead.LastModifiedDate.format('dd MMMM yyyy') + '<br />';
                                
                
                if(isNew){
                    emailContentsNew.add(htmlTextBody);
                }else if(isThreeDays) {
                    emailContentsfor3days.add(htmlTextBody);  
                }else {
                    emailContentsfor9days.add(htmlTextBody);   
                }
            }
            
            
            // Insert tasks
            if (!tasksToCreate.isEmpty()) {
                insert tasksToCreate;
            }
        } catch(Exception e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
        
        // Generate email body
        Map<String,String> EmailSubvsBody = new  Map<String,String>();
        if (!emailContentsNew.isEmpty()) {
            EmailSubvsBody.put('Stagnant Lead Alert! Leads Requiring Attention', MS_SendEmail.generateEmailBody(leads, emailContentsNew));            
      
        }
        for(String Sub: EmailSubvsBody.keySet()){
            
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ddthelp@mindzvue.com'];
            
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            if ( owea.size() > 0 ) {
                message.setOrgWideEmailAddressId(owea.get(0).Id);
                message.toAddresses = new List<String>{ 'vvaryani@mindzcloud.com', 'tbasakhatre@mindzcloud.com' };
                    message.subject = Sub;                
                message.htmlbody = EmailSubvsBody.get(Sub);
                Messaging.sendEmail(new Messaging.SingleEmailMessage[]{message});
            }

        }
        
        if (!emailContentsfor3days.isEmpty()) {    
            EmailSubvsBody.put('Inactive Leads Alert! No Progress days', MS_SendEmail.generateAssignedEmailBody(leads, emailContentsfor3days));                  
        }
        for(String Sub: EmailSubvsBody.keySet()){
            
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ddthelp@mindzvue.com'];
            
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            if ( owea.size() > 0 ) {
                message.setOrgWideEmailAddressId(owea.get(0).Id);
                message.toAddresses = new List<String>{ 'vvaryani@mindzcloud.com', 'tbasakhatre@mindzcloud.com' };
                                        message.toAddresses = new List<String>{ 'vvaryani@mindzcloud.com', 'tbasakhatre@mindzcloud.com' };
                    message.subject = Sub;                
                message.htmlbody = EmailSubvsBody.get(Sub);
                Messaging.sendEmail(new Messaging.SingleEmailMessage[]{message});
            }

        }
        
        if (!emailContentsfor9days.isEmpty()) {
            EmailSubvsBody.put('Inactive Leads Alert! No Progress', MS_SendEmail.generateEmailBodyfor9days(leads, emailContentsfor9days));           
        }
        /*for(String Sub: EmailSubvsBody.keySet()){
            
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ddthelp@mindzvue.com'];
            
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            if ( owea.size() > 0 ) {
                message.setOrgWideEmailAddressId(owea.get(0).Id);
                message.toAddresses = new List<String>{ 'vvaryani@mindzcloud.com', 'tbasakhatre@mindzcloud.com' };
                    message.subject = Sub;                
                message.htmlbody = EmailSubvsBody.get(Sub);
                Messaging.sendEmail(new Messaging.SingleEmailMessage[]{message});
            }

        }*/
               
        
    }  
    
    global void finish(Database.BatchableContext bc) {
    }
     /*private void sendEmailNotification(String toAddress, String subject, String body) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[]{toAddress});
        mail.setSubject(subject);
        mail.setPlainTextBody(body);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
    }*/
       }