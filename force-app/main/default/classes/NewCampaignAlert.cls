public with sharing class NewCampaignAlert {
        
    
        @InvocableMethod(
            label       =   'Send Email to Donors In One List'
            description =   'This method is designed to be invoked from flow'
            category    =   'Campaign'
        )
        public static void sendEmailToDonors(List<Id> listCampaignId){
    
            id campaignId = listCampaignId[0];

            //Select person accounts to send email
            List<Account> listAcc = [SELECT id, PersonEmail, PersonContactId FROM Account WHERE PersonHasOptedOutOfEmail__c = false AND PersonEmail != null and isPersonAccount=true WITH SECURITY_ENFORCED];
            
            //Select email template
            EmailTemplate emailTemp = [SELECT Id, Subject, Body From EmailTemplate WHERE Name = 'New Campaign' WITH SECURITY_ENFORCED LIMIT 1];
    
            List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
            
            //Render method--> for using email template reactively

            //Watch out! Who Id only can be contact, lead, or user. For person account it is personContactId

            for (Account eachAcc : listAcc) {
                Messaging.SingleEmailMessage mail = Messaging.renderStoredEmailTemplate(emailTemp.id, eachAcc.personContactId, campaignId);
                mails.add(mail);
            }
    
            Messaging.sendEmail(mails);

            

            
        }
       

    }
    
