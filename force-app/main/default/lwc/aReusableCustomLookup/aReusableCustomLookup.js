import searchRecords from '@salesforce/apex/SearchController.searchRecords';
import { LightningElement, api, track } from 'lwc';


export default class AReusableCustomLookup extends LightningElement {
    //public property
    //these public property will be used when using this component inside other component for the lookup functionality
    //objectName is the name of the Object which is parent either master-detail or lookup
    //fieldName is the field of parent object in which text needs to be searched
    //iconName - icon to display in the list and after selection of the record
    //label -  to show the label for the lookup
    //parentIdField - the apiname of lookup/master-detail in the child object this field is useful to identify which parent

    @api objectName = 'Course__c';
    @api fieldName = 'Name';
    @api iconName = 'standard:event';
    @api label = 'Event';
    @api parentIdField = 'Course__c';

    //private property
    @track records;
    @track selectedRecord;

    handleSearch(event){
        var searchVal = event.detail.value;

        searchRecords ({
            objName : this.objectName,
            fieldName : this.fieldName,
            searchKey : searchVal
        })
        .then(data => {
            if (data) {
                let parsedResponse = JSON.parse(data);
                let searchRecordList = parsedResponse[0];
                for(let i=0; i<searchRecordList.length; i++) {
                    let record = searchRecordList[i];
                    record.Name = record[this.fieldName];
                }
                this.records = searchRecordList;
            }
        })
        .catch(error => {
            window.console.log('ERR:', JSON.stringify(error));
        });
    }

    handleSelect(event) {
        var selectedVal = event.detail.selRec;
        this.selectedRecord = selectedVal;

        let finalRecService = new CustomEvent('select', {
            detail: {
                selectedRecordId : this.selectedRecord.Id,
                parentfield : this.parentIdField  
            }
        });
        this.dispatchEvent(finalRecService);
    }
    handleRemove(){
        this.selectedRecord = undefined;
        this.records = undefined;

        let finalRecService = new CustomEvent('select', {
            detail : {
                selectedRecordId : undefined,
                parentfield : this.parentIdField
            }
        });
        this.dispatchEvent(finalRecService);
    }



}