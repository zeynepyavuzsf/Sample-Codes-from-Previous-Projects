public with sharing class SchedulerCampaignUpdate implements schedulable{
    public void execute(SchedulableContext Bc){

        BatchClassCampaignUpdate ab=new BatchClassCampaignUpdate();
        id batchid=database.executeBatch(ab,200);
    }
}