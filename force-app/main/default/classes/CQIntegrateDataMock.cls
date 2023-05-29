@isTest
global class CQIntegrateDataMock implements httpCalloutMock{
    
 
    global httpResponse respond(HttpRequest request){
        HttpResponse response=new HttpResponse();
        response.setHeader('contentType', 'application/json');
        response.setHeader('x-api-key', 'b96d75ce0f9f342d10af6710ef8ea7ed0ad06');
        response.setBody('{"_id":"619683d69402c24f000237e9","Part Name":"Population Sensor","Total Quantity Shipped":350000},{"_id":"619643769402c24f000229ec","Part Name":"Drill Gauge","Total Quantity Shipped":125000},{"_id":"62998ecc6a50f02a0000b87d","Part Name":"Pressure Sensor","Total Quantity Shipped":100}');
        response.setStatusCode(200);
        return response;
    }
    

}