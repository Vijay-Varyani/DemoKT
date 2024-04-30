public class MS_SendEmail {
    public static String generateEmailBody(List<Lead> leads, List<String> emailContentsNew) {
        String htmlBody = '<!DOCTYPE html>'
            + '<html>'
            + '<head>'
            + '<style>'
            + 'table {'
            + 'border-collapse: collapse;'
            + 'width: 100%;'
            + '}'
            + 'th, td {'
            + 'border: 1px solid #dddddd;'
            + 'text-align: left;'
            + 'padding: 8px;'
            + '}'
            + 'tr:nth-child(even) {'
            + 'background-color: #f2f2f2;'
            + '}'
            + '</style>'
            + '</head>'
            + '<body>'
            + '<table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'100%\' style=\'background-color: rgb(244,248,249)\'>'
            + '<tbody>'
            + '<tr>'
            + '<td>'
            + '<table align=\'center\' border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'600\'>'
            + '<tbody>'
            +'<tr>'
            + '<td align="center" style="padding-right: 0px; padding-left: 0px">'
            + '<img width="100" style="display: block; margin: 0 auto; border: 0; max-width: 100%" title="MZ Enterprise" src="https://mzasset.s3.amazonaws.com/mindZvuelogo_color+(1).png" alt="MZ Enterprise" height="auto">'
            + '</td>'
            + '</tr>'
            + '<tr>'
            + '<td style=\'background-color: rgb(255, 255, 255); color: rgb(0, 0, 0);padding-left: 10px;padding-right: 10px;'
            + 'padding-top: 5px;  padding-bottom: 5px; font-family: Poppins, sans-serif\'>'
            + '<div>'
            + 'Dear Sales Team, <br> The following leads that are still in the New status and have not been picked up yet. These leads have been in the Queue for more than 24 hours and require your attention. <br><br>'
            + '<table border=\'1\' cellpadding=\'5\' cellspacing=\'0\' width=\'100%\'>'
            + '<thead>'
            + '<tr>'
            + '<th>Lead Name</th>'
            + '<th>Lead Company</th>'
            + '<th>Record Type</th>'
            + '<th>Lead Source</th>'
            + '<th>Last Modified Date</th>'
            + '</tr>'
            + '</thead>'
            + '<tbody>';
        // Add each lead's information within a table row and columns
        for(Lead lead : leads) {
            String recordTypeName = [SELECT Name FROM RecordType WHERE Id = :lead.RecordTypeId LIMIT 1].Name;
            if (lead.Status == 'New') {
                system.debug('Record Type ='+lead.RecordTypeId);
                htmlBody += '<tr>'
                   // + '<td><a href="https://mindzvuellc.my.salesforce.com/' + lead.Id + '">' + lead.Name + '</a></td>'
                   + '<td><a href="https://mindzvuellc--podev2.sandbox.lightning.force.com/' + lead.Id + '">' + lead.Name + '</a></td>'
                    + '<td>' + lead.Company + '</td>'
                    + '<td>' + recordTypeName + '</td>'
                    + '<td>' + (lead.LeadSource != null ? lead.LeadSource : '') + '</td>'
                    + '<td>' + lead.LastModifiedDate.format('dd MMMM yyyy') + '</td>'
                    + '</tr>';
            }
        }
        
        htmlBody += '</tbody>'
            + '</table>'
            + '</div>'
            + '</td>'
            + '</tr>'
            + '<tr>'
            + '<td align=\'center\' style=\'text-align: center; vertical-align: top; padding-top: 10px; border: 0px; width:100%;font-family: Poppins, sans-serif;color:#375DAA;\'>'
            + 'Connect with Us'
            + '</td>'
            + '</tr>'
               + '<tr style=\'text-align: center; display:ruby-text; \'>'
            + '<td style="padding: 0 5px 0 5px; border: 0px;">'
        + '<a href="https://www.linkedin.com/company/mindzvue/" target="_blank">'
    + '<img style="display:block ; height: auto; border: 0;height:20px;" title="LinkedIn"'
        + 'src="https://mzasset.s3.amazonaws.com/linkedingraylogo.png" alt="LinkedIn" height="auto">'
        + '</a>'
        + '</td>'
        + '<td style="padding: 0 5px 0 5px; border: 0px;">'
        + '<a href="https://www.facebook.com/mindzvue" target="_blank">'
        + '<img style="display:block ; height: auto; border: 0;height:20px;" title="Facebook" '
        + 'src="https://mzasset.s3.amazonaws.com/facebookgraylogo.png" alt="Facebook" height="auto">'
        + '</a>'
        + '</td>'
        + '<td style="padding: 0 5px 0 5px; border: 0px;">'
        + '<a href="https://twitter.com/mindzvue" target="_blank">'
        + '<img style="display:block ; height: auto; border: 0;height:20px;" title="Twitter" '
        + 'src="https://mzasset.s3.amazonaws.com/twittergraylogo.png" alt="Twitter" height="auto">'
        + '</a>'
        + '</td>'
        + '<td style="padding: 0 5px 0 5px; border: 0px;">'
        + '<a href="https://instagram.com/mindzvue" target="_blank">'
        + '<img style="display:block ; height: auto; border: 0;height:20px;" title="Instagram" '
        + 'src="https://mzasset.s3.amazonaws.com/instagraylogo.png" alt="Instagram" height="auto">'
        + '</a>'
        + '</td>'
        + '</tr>'
            //+ '</tbody>'
           // + '</table>'
            //+ '</td>'
            + '</tr>'
            + '<tr>'
            + '<td align=\'center\' style=\'text-align: center; vertical-align: top;padding-bottom: 15px; border: 0px;width:100%;font-family: Poppins, sans-serif;font-size:12px;color: rgb(148,162,173)\'>'
            + '© 2024 mindZvue, All Rights Reserved.'
            + '</td>'
            + '</tr>'
            + '</tbody>'
            + '</table>'
            + '</td>'
            + '</tr>'
            + '</tbody>'
            + '</table>'
            + '</body>'
            + '</html>';
        
        
        return htmlBody;
    }
    
    public static String generateAssignedEmailBody(List<Lead> leads,List<String> emailContentsfor3days) {             
        String htmlBody = '<!DOCTYPE html>'
            + '<html>'
            + '<head>'
            + '<style>'
            + 'table {'
            + 'border-collapse: collapse;'
            + 'width: 100%;'
            + '}'
            + 'th, td {'
            + 'border: 1px solid #dddddd;'
            + 'text-align: left;'
            + 'padding: 8px;'
            + '}'
            + 'tr:nth-child(even) {'
            + 'background-color: #f2f2f2;'
            + '}'
            + '</style>'
            + '</head>'
            + '<body>'
            + '<table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'100%\' style=\'background-color: rgb(244,248,249)\'>'
            + '<tbody>'
            + '<tr>'
            + '<td>'
            + '<table align=\'center\' border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'600\'>'
            + '<tbody>'
            +'<tr>'
            + '<td align="center" style="padding-right: 0px; padding-left: 0px">'
            + '<img width="100" style="display: block; margin: 0 auto; border: 0; max-width: 100%" title="MZ Enterprise" src="https://mzasset.s3.amazonaws.com/mindZvuelogo_color+(1).png" alt="MZ Enterprise" height="auto">'
            + '</td>'
            + '</tr>'
            + '<tr>'
            + '<td style=\'background-color: rgb(255, 255, 255); color: rgb(0, 0, 0);padding-left: 10px;padding-right: 10px;'
            + 'padding-top: 5px;  padding-bottom: 5px; font-family: Poppins, sans-serif\'>'
            + '<div>';
        //String leadOwnerName = [SELECT Name FROM User WHERE Id = :leads[0].OwnerId LIMIT 1].Name;
        String leadOwnerName;
        List<User> userList = [SELECT Name FROM User WHERE Id = :leads[0].OwnerId LIMIT 1];
        
        if (!userList.isEmpty()) {
            leadOwnerName = userList[0].Name;
            htmlBody += 'Hi ' + leadOwnerName + ', <br>';
            
        } else {
            // Handle the case where no User record matches the provided Id
            leadOwnerName = 'Unknown'; // Or any other default value you prefer
            htmlBody += 'Hi ' + leadOwnerName + ', <br>';
            
        }
        //   htmlBody += 'Hi ' + leadOwnerName + ', <br>';
        
        
        
        htmlBody += 'We would like to notify you that there has been no recent activity observed for the following leads: <br><br>';
        
        
        htmlBody += '<table border=\'1\' cellpadding=\'5\' cellspacing=\'0\' width=\'100%\'>'
            + '<thead>'
            + '<tr>'
            + '<th>Lead Name</th>'
            + '<th>Lead Company</th>'
            + '<th>Record Type</th>'
            + '<th>Lead Status</th>'
            + '<th>Lead Source</th>'
            + '<th>Last Modified Date</th>'
            + '</tr>'
            + '</thead>'
            + '<tbody>';
        
        // Add each lead's information within a table row and columns
        for(Lead lead : leads) {
            String recordTypeName = [SELECT Name FROM RecordType WHERE Id = :lead.RecordTypeId LIMIT 1].Name;
            if ( Math.abs(Date.today().daysBetween(lead.BatchClassTest__c.date())) == 3) {
                if (lead.Status == 'Assigned' || lead.Status == 'Engaged' || lead.Status == 'Contacted') {
                    htmlBody += '<tr>'
                      //  + '<td><a href="https://mindzvuellc.my.salesforce.com/' + lead.Id + '">' + lead.Name + '</a></td>'
                        + '<td><a href="https://mindzvuellc--podev2.sandbox.lightning.force.com/' + lead.Id + '">' + lead.Name + '</a></td>'
                        + '<td>' + lead.Company + '</td>'
                        + '<td>' + recordTypeName + '</td>'
                        + '<td>' + lead.Status + '</td>'
                        + '<td>' + (lead.LeadSource != null ? lead.LeadSource : '') + '</td>'
                        + '<td>' + lead.LastModifiedDate.format('dd MMM yyyy') + '</td>'
                        + '</tr>';
                }
            }
        }
        
        htmlBody += '</tbody>'
            + '</table>';
        htmlBody += '</div>'
            + '</td>'
            + '</tr>'
            + '<tr>'
            + '<td align=\'center\' style=\'text-align: center; vertical-align: top; padding-top: 10px; border: 0px; width:100%;font-family: Poppins, sans-serif;color:#375DAA;\'>'
            + 'Connect with Us'
            + '</td>'
            + '</tr>'
               + '<tr style=\'text-align: center; display:ruby-text; \'>'
            + '<td align=\'center\' style=\'padding-top: 10px; padding-bottom: 10px; text-align: center; padding-right: 0px; padding-left: 0px;\'>'
            + '<table align=\'center\' border=\'0\' cellpadding=\'0\' cellspacing=\'0\'>'
            + '<tbody>'
            + '<tr>'
            + '<td style=\'padding: 0 5px 0 5px\'>'
            + '<a href=\'https://www.linkedin.com/company/mindzvue/\' target=\'_blank\'>'
            + '<img style=\'display: block; height: auto; border: 0;height:20px;\' title=\'LinkedIn\' src=\'https://mzasset.s3.amazonaws.com/linkedingraylogo.png\' alt=\'LinkedIn\' height=\'auto\'>'
            + '</a>'
            + '</td>'
            + '<td style=\'padding: 0 5px 0 5px\'>'
            + '<a href=\'https://www.facebook.com/mindzvue\' target=\'_blank\'>'
            + '<img style=\'display: block; height: auto; border: 0;height:20px;\' title=\'Facebook\' src=\'https://mzasset.s3.amazonaws.com/facebookgraylogo.png\' alt=\'Facebook\' height=\'auto\'>'
            + '</a>'
            + '</td>'
            + '<td style=\'padding: 0 5px 0 5px\'>'
            + '<a href=\'https://twitter.com/mindzvue\' target=\'_blank\'>'
            + '<img style=\'display: block; height: auto; border: 0;height:20px;\' title=\'Twitter\' src=\'https://mzasset.s3.amazonaws.com/twittergraylogo.png\' alt=\'Twitter\' height=\'auto\'>'
            + '</a>'
            + '</td>'
            + '<td style=\'padding: 0 5px 0 5px\'>'
            + '<a href=\'https://instagram.com/mindzvue\' target=\'_blank\'>'
            + '<img style=\'display: block; height: auto; border: 0;height:20px;\' title=\'Instagram\' src=\'https://mzasset.s3.amazonaws.com/instagraylogo.png\' alt=\'Instagram\' height=\'auto\'>'
            + '</a>'
            + '</td>'
            + '</tr>'
            + '</tbody>'
            + '</table>'
            + '</td>'
            + '</tr>'
            + '<tr>'
            + '<td align=\'center\' style=\'text-align: center; vertical-align: top;padding-bottom: 15px; border: 0px;width:100%;font-family: Poppins, sans-serif;font-size:12px;color: rgb(148,162,173)\'>'
            + '© 2024 mindZvue, All Rights Reserved.'
            + '</td>'
            + '</tr>'
            + '</tbody>'
            + '</table>'
            + '</td>'
            + '</tr>'
            + '</tbody>'
            + '</table>'
            + '</body>'
            + '</html>';
        system.debug('before return in 3 day email generation -- ' + htmlBody );
        return htmlBody;
    }
    
    
    public static String generateEmailBodyfor9days(List<Lead> leads, List<String> emailContentsfor9days) {
        String htmlBody = '<!DOCTYPE html>'
            + '<html>'
            + '<head>'
            + '<style>'
            + 'table {'
            + 'border-collapse: collapse;'
            + 'width: 100%;'
            + '}'
            + 'th, td {'
            + 'border: 1px solid #dddddd;'
            + 'text-align: left;'
            + 'padding: 8px;'
            + '}'
            + 'tr:nth-child(even) {'
            + 'background-color: #f2f2f2;'
            + '}'
            + '</style>'
            + '</head>'
            + '<body>'
            + '<table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'100%\' style=\'background-color: rgb(244,248,249)\'>'
            + '<tbody>'
            + '<tr>'
            + '<td>'
            + '<table align=\'center\' border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'600\'>'
            + '<tbody>'
            +'<tr>'
            + '<td align="center" style="padding-right: 0px; padding-left: 0px">'
            + '<img width="100" style="display: block; margin: 0 auto; border: 0; max-width: 100%" title="MZ Enterprise" src="https://mzasset.s3.amazonaws.com/mindZvuelogo_color+(1).png" alt="MZ Enterprise" height="auto">'
            + '</td>'
            + '</tr>'
            + '<tr>'
            + '<td style=\'background-color: rgb(255, 255, 255); color: rgb(0, 0, 0);padding-left: 10px;padding-right: 10px;'
            + 'padding-top: 5px;  padding-bottom: 5px; font-family: Poppins, sans-serif\'>'
            + '<div>'
            + 'Dear Sales Team, <br> We would like to notify you that there has been no recent activity observed for the following leads: <br><br>'
            + '<table border=\'1\' cellpadding=\'5\' cellspacing=\'0\' width=\'100%\'>'
            + '<thead>'
            + '<tr>'
            + '<th>Lead Name</th>'
            + '<th>Lead Company</th>'
            + '<th>Record Type</th>'
            + '<th>Lead Status</th>'
            + '<th>Lead Source</th>'
            + '<th>Last Modified Date</th>'
            + '</tr>'
            + '</thead>'
            + '<tbody>';
        // Add each lead's information within a table row and columns
        for(Lead lead : leads) {
            String recordTypeName = [SELECT Name FROM RecordType WHERE Id = :lead.RecordTypeId LIMIT 1].Name;
            if ( Math.abs(Date.today().daysBetween(lead.BatchClassTest__c.date())) == 9) {
                if (lead.Status == 'Assigned' || lead.Status == 'Engaged' || lead.Status == 'Contacted') {              
                    system.debug('Record Type ='+lead.RecordTypeId);
                    
                    htmlBody += '<tr>'
                       // + '<td><a href="https://mindzvuellc.my.salesforce.com/' + lead.Id + '">' + lead.Name + '</a></td>'
                        + '<td><a href="https://mindzvuellc--podev2.sandbox.lightning.force.com/' + lead.Id + '">' + lead.Name + '</a></td>'
                        + '<td>' + lead.Company + '</td>'
                        + '<td>' + recordTypeName + '</td>'
                        + '<td>' + lead.Status + '</td>'
                        + '<td>' + (lead.LeadSource != null ? lead.LeadSource : '') + '</td>'
                        + '<td>' + lead.LastModifiedDate.format('dd MMM yyyy') + '</td>'
                        + '</tr>';                                                                                   
                }
            }
        }
        
        htmlBody += '</tbody>'
            + '</table>'
            + '</div>'
            + '</td>'
            + '</tr>'
            + '<tr>'
            + '<td align=\'center\' style=\'text-align: center; vertical-align: top; padding-top: 10px; border: 0px; width:100%;font-family: Poppins, sans-serif;color:#375DAA;\'>'
            + 'Connect with Us'
            + '</td>'
            + '</tr>'
               + '<tr style=\'text-align: center; display:ruby-text; \'>'
            + '<td align=\'center\' style=\'padding-top: 10px; padding-bottom: 10px; text-align: center; padding-right: 0px; padding-left: 0px;\'>'
            + '<table align=\'center\' border=\'0\' cellpadding=\'0\' cellspacing=\'0\'>'
            + '<tbody>'
            + '<tr>'
            + '<td style=\'padding: 0 5px 0 5px\'>'
            + '<a href=\'https://www.linkedin.com/company/mindzvue/\' target=\'_blank\'>'
            + '<img style=\'display: block; height: auto; border: 0;height:20px;\' title=\'LinkedIn\' src=\'https://mzasset.s3.amazonaws.com/linkedingraylogo.png\' alt=\'LinkedIn\' height=\'auto\'>'
            + '</a>'
            + '</td>'
            + '<td style=\'padding: 0 5px 0 5px\'>'
            + '<a href=\'https://www.facebook.com/mindzvue\' target=\'_blank\'>'
            + '<img style=\'display: block; height: auto; border: 0;height:20px;\' title=\'Facebook\' src=\'https://mzasset.s3.amazonaws.com/facebookgraylogo.png\' alt=\'Facebook\' height=\'auto\'>'
            + '</a>'
            + '</td>'
            + '<td style=\'padding: 0 5px 0 5px\'>'
            + '<a href=\'https://twitter.com/mindzvue\' target=\'_blank\'>'
            + '<img style=\'display: block; height: auto; border: 0;height:20px;\' title=\'Twitter\' src=\'https://mzasset.s3.amazonaws.com/twittergraylogo.png\' alt=\'Twitter\' height=\'auto\'>'
            + '</a>'
            + '</td>'
            + '<td style=\'padding: 0 5px 0 5px\'>'
            + '<a href=\'https://instagram.com/mindzvue\' target=\'_blank\'>'
            + '<img style=\'display: block; height: auto; border: 0;height:20px;\' title=\'Instagram\' src=\'https://mzasset.s3.amazonaws.com/instagraylogo.png\' alt=\'Instagram\' height=\'auto\'>'
            + '</a>'
            + '</td>'
            + '</tr>'
            + '</tbody>'
            + '</table>'
            + '</td>'
            + '</tr>'
            + '<tr>'
            + '<td align=\'center\' style=\'text-align: center; vertical-align: top;padding-bottom: 15px; border: 0px;width:100%;font-family: Poppins, sans-serif;font-size:12px;color: rgb(148,162,173)\'>'
            + '© 2024 mindZvue, All Rights Reserved.'
            + '</td>'
            + '</tr>'
            + '</tbody>'
            + '</table>'
            + '</td>'
            + '</tr>'
            + '</tbody>'
            + '</table>'
            + '</body>'
            + '</html>';
        
        return htmlBody;
    }
}