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
       Map<String,Account> accountnameMap=new Map<String,Account>();
       for(Account acc:accList){
       accountnameMap.put(acc.name,acc);
       }
       
        for(JSONParserClass parsedList:parsed){
            SQX_Part__c cqpart=new SQX_Part__c();
        cqpart.Name= parsedList.Part_Name ;
        cqpart.Active__c=true;
        cqpart.Part_Number__c=parsedList.x_id;
        if(parsedList.Total_Quantity_Shipped<99){
            cqpart.Account__c= accountnameMap.get('Low Volume Acc').id;
        }
        else{
            cqpart.Account__c= accountnameMap.get('High Volume Acc').id;
        }
            cqpartList.add(cqpart);
        }
        
        upsert cqpartList Part_Number__c;
        system.debug('Parts-->' +cqpartList);
        return cqpartList;
}
}