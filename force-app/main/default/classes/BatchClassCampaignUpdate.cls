    public class BatchClassCampaignUpdate implements Database.Batchable<SObject>{


        //Mark the campaign as 'Expired' if End Date is Yesterday
        public Database.QueryLocator start(Database.BatchableContext BC){
            return Database.getQueryLocator([select id, status 
                                            FROM Campaign 
                                            WHERE EndDate=YESTERDAY and Remaining__c>0 ]);
        }
        
        public void execute(Database.BatchableContext BC, List<Campaign> scope){
    
        
            for(Campaign s : scope){
            s.status='Expired';
            }
            update scope;
            }
        
        public void finish(Database.BatchableContext BC){
        }
    
        }
    
