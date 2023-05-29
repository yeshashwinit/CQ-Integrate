import { LightningElement, api } from 'lwc';
import getCQPart from '@salesforce/apex/externalDataIntegrateCQ.getCQPart';

export default class CQButtonIntegrate extends LightningElement {
    cqPart;
    error;
    //@api recordId;

    handleGetCQParts(){
    
    getCQPart().then(result => {
        console.log("Record ID" +result);

        this.cqPart = result;
        
        console.log('this.cqPart->'+ this.cqPart);
        
         })
        
         .catch(error => {
        
        console.log('error'+ error);
    })
    }
}