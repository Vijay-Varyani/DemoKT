public class MS_AssignLeadController {
	@AuraEnabled
    public static List<Lead> assignLeadToLoggedInUser(String recordId){
        try {
            List<Lead> listOfMarketingLeads = [SELECT Id, OwnerId, Status FROM Lead WHERE Id =: recordId ];
            Id userId =UserInfo.getUserId();
            List<Lead> listToBeUpdated = new List<Lead>();
            if(listOfMarketingLeads.size() > 0){
                for (Lead ml : listOfMarketingLeads) {
                    if(ml.Status == 'New'){
                        ml.OwnerId = userId;
                        ml.Status = 'Assigned';
                    }else if(ml.Status != 'New'){
                        ml.OwnerId = userId;

                    }
                    listToBeUpdated.add(ml);
                }
                update listToBeUpdated;
            }
           return listToBeUpdated;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}