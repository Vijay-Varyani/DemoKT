public class LeadUpdToAssignedEmailBody {
    public static String generateEmailBody(List<Lead> leads, List<String> emailContentsAssigned) {
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
            + '<tr>'
            + '<td align=\'center\' width=\'100%\' style=\'padding-right: 0px; padding-left: 0px\'>'
            + '<img width=\'100\' style=\'display: block; height: auto; border: 0; max-width: 100%\' title=\'MZ Enterprise\' src=\'https://mzasset.s3.amazonaws.com/mindZvuelogo_color+(1).png\' alt=\'MZ Enterprise\' height=\'auto\'>'
            + '</td>'
            + '</tr>'
            + '<tr>'
            + '<td style=\'background-color: rgb(255, 255, 255); color: rgb(0, 0, 0);padding-left: 10px;padding-right: 10px;'
            + 'padding-top: 5px;  padding-bottom: 5px; font-family: Poppins, sans-serif\'>'
            + '<div>'
            + 'Dear Leadership Team, <br>';

        // Check days condition to determine the message
       // if (daysCondition == 10) {
            htmlBody += 'We would like to notify you that there has been no recent activity observed for the following leads: <br><br>';
        //} else if (daysCondition == 9) {
            //htmlBody += 'We would like to notify you that there has been no recent activity observed for the following leads: <br><br>';
        //}

        htmlBody += '<table border=\'1\' cellpadding=\'5\' cellspacing=\'0\' width=\'100%\'>'
            + '<thead>'
            + '<tr>'
            + '<th>Lead Status</th>'
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
            if ( Math.abs(Date.today().daysBetween(lead.BatchClassTest__c.date())) == 10) {
                if (lead.Status == 'Assigned' || lead.Status == 'Engaged' || lead.Status == 'Contacted') {
                    htmlBody += '<tr>'
                        + '<td>' + lead.Status + '</td>'
                        + '<td>' + lead.Name + '</td>'
                        + '<td>' + lead.Company + '</td>'
                        + '<td>' + lead.RecordTypeId + '</td>'
                        + '<td>' + lead.LeadSource + '</td>'
                        + '<td>' + lead.LastModifiedDate + '</td>'
                        + '</tr>';
                }
            }
        }

        htmlBody += '</tbody>'
            + '</table>';
        
         htmlBody += '<br><br><table border=\'1\' cellpadding=\'5\' cellspacing=\'0\' width=\'100%\'>'
            + '<thead>'
            + '<tr>'
            + '<th>Lead Status</th>'
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
            if ( Math.abs(Date.today().daysBetween(lead.BatchClassTest__c.date())) == 9) {
                if (lead.Status == 'Assigned' || lead.Status == 'Engaged' || lead.Status == 'Contacted') {
                    htmlBody += '<tr>'
                        + '<td>' + lead.Status + '</td>'
                        + '<td>' + lead.Name + '</td>'
                        + '<td>' + lead.Company + '</td>'
                        + '<td>' + lead.RecordTypeId + '</td>'
                        + '<td>' + lead.LeadSource + '</td>'
                        + '<td>' + lead.LastModifiedDate + '</td>'
                        + '</tr>';
                }
            }
        }

        htmlBody += '</tbody>'
            + '</table>';
            //FOR Second Table          
           htmlBody += '</div>'
            + '</td>'
            + '</tr>'
            + '<tr>'
            + '<td align=\'center\' style=\'text-align: center; vertical-align: top; padding-top: 10px; border: 0px; width:100%;font-family: Poppins, sans-serif;color:#375DAA;\'>'
            + 'Connect with Us'
            + '</td>'
            + '</tr>'
            + '<tr>'
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