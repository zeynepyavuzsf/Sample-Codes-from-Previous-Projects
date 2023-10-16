public with sharing class AddressVerificationCallout {
    @InvocableMethod(label='Call address verification system' description='Make callout to address verification system')

    //This is going to be used for verifying the address in a flow.
    
public static void getAddressValidation(List<ID> locationIds) {

   run(locationIds[0]);
  
}
@future(callout=true)
public static void run(id locId) {
  try {
    Http http = new Http();
HttpRequest request = new HttpRequest();
request.setEndpoint('https://us-street.api######');
request.setMethod('GET');
HttpResponse response = http.send(request);
System.debug('resp: '+response.getBody());
Boolean issuccess=response.getStatusCode()==200;
update new LoctionEM__c(Id=locId, Verified__c=issuccess);
// If the request is successful, parse the JSON response.


} catch (Exception ex) {
   ErrorLogUtility.insertErrorLog('Call address verification system', ex.getMessage());
}
  
}
}