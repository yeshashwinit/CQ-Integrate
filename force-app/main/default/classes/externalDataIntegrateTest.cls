@isTest
private class externalDataIntegrateTest {
    @isTest
    static void DataIntegrateTest(){
        Test.setMock(HttpCalloutMock.class, new CQIntegrateDataMock());
        //insert new yas92__SQX_Part__c(Name='Population Sensor', yas92__Active__c=true,yas92__Part_Number__c='619683d69402c24f000237e9');
        List<SQX_Part__c> CQParts=externalDataIntegrateCQ.getCQPart();
        Integer expected=CQParts.size();
        system.assertEquals(5, expected);
    }

}