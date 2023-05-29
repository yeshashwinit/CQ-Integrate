public class VATController {
    public Final List<VAT_Rate__mdt> VATs{get;set;}
    final Map<String,VAT_Rate__mdt> VATsByAPI{get;set;}
    public VATController(){
        VATs=new List<VAT_Rate__mdt>();
        VATsByAPI=new Map<String,VAT_Rate__mdt>();
        for(VAT_Rate__mdt vat : [Select QualifiedApiName, MasterLabel, Default__c, Rate__c from VAT_Rate__mdt]){
            VATs.add(vat);
            VATsByAPI.put(vat.QualifiedApiName, vat);
        }
    }
    public PageReference save(){
        // Create a metadata container.
        Metadata.DeployContainer container = new Metadata.DeployContainer();
        List<String> vatFullNames = new List<String>();
        for (String recordName : VATsByAPI.keySet()) {
            vatFullNames.add('VAT_Rate.' + recordName);
        }
        List<Metadata.Metadata> records = 
            Metadata.Operations.retrieve(Metadata.MetadataType.CustomMetadata, 
                                         vatFullNames);
        for (Metadata.Metadata record : records) {
            Metadata.CustomMetadata vatRecord = (Metadata.CustomMetadata) record;
            String vatRecordName = vatRecord.fullName.substringAfter('.');
            VAT_Rate__mdt vatToCopy = VATsByAPI.get(vatRecordName);
            for (Metadata.CustomMetadataValue vatRecValue : vatRecord.values) {
                vatRecValue.value = vatToCopy.get(vatRecValue.field);
            }
            // Add record to the container.
            container.addMetadata(vatRecord);
        }   
        // Deploy the container with the new components. 
        Id asyncResultId = Metadata.Operations.enqueueDeployment(container, null);
        return null;
    }

}