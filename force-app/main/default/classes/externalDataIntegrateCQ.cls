public with sharing class externalDataIntegrateCQ {
     @AuraEnabled
    public Static List<SQX_Part__c> getCQPart(){
        Http http=new Http();
		HttpRequest request=new HttpRequest();
		request.setEndpoint('https://cqparts-3d06.restdb.io/rest/cqpart');
		request.setHeader('Content-Type', 'application/json');
		request.setHeader('x-api-key' , 'b96d75ce0f9f342d10af6710ef8ea7ed0ad06');
		request.setMethod('GET');
		HttpResponse response=http.send(request);
		String body=response.getbody();
		system.debug('Body---> ' +response.getbody());
        //JsonParse obj = JsonParse.parse(body);
        
        List<JSONParserClass> parsed=JSONParserClass.parse(body);
        
        
       List<SQX_Part__c> cqpartList= new List<SQX_Part__c>();
      List<Account> accList = [SELECT ID,name FROM Account WHERE Name LIKE '%Volume%'];
       Map<ID,String> accountnameMap=new Map<ID,String>();
       accountnameMap.put(accList.id,accList.name);
       
        for(JSONParserClass parsedList:parsed){
            SQX_Part__c cqpart=new SQX_Part__c();
        cqpart.Name= parsedList.Part_Name ;
        cqpart.Active__c=true;
        cqpart.Part_Number__c=parsedList.x_id;
        
            cqpartList.add(cqpart);
        }
        
        insert cqpartList;
        system.debug('Parts-->' +cqpartList);
        return cqpartList;
}
}