import { LightningElement,wire } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import getWork from '@salesforce/apex/WorkHandler.getWork';
import Work_Object from '@salesforce/schema/agf__ADM_Work__c';
import Subject_Field from '@salesforce/schema/agf__ADM_Work__c.agf__Subject__c';
import Status_Field from '@salesforce/schema/agf__ADM_Work__c.agf__Status__c';
import Product_Tag from '@salesforce/schema/agf__ADM_Work__c.agf__Product_Tag__c';
import Team from '@salesforce/schema/agf__ADM_Work__c.agf__Scrum_Team__c';


const columns = [
    { label: 'Work-Id', fieldName: 'Name', type: 'string' },
    { label: 'Subject', fieldName: 'agf__Subject__c', type: 'string' },
    { label: 'Status', fieldName: 'agf__Status__c', type: 'string' },
    { label: 'Product Tag', fieldName: 'agf__Product_Tag_Name__c', type: 'string' },
    { label: 'Team', fieldName: 'agf__Scrum_Team_Name__c', type: 'string' },

];

export default class MS_CreateWorkItems extends LightningElement {
    objectName = Work_Object;
    fieldList = [Subject_Field, Status_Field, Team, Product_Tag];
    columns = columns;
    data = [];
    isModalOpen = false;

    

    @wire(getWork)
    wiredData({ error, data }) {
        if (data) {
            this.data = data;
        } else if (error) {
            console.error('Error retrieving work records:', error);
        }
    }

    openModal() {
        this.isModalOpen = true;
    }

    closeModal() {
        this.isModalOpen = false;
    }

    createRecord() {
        const fields = {};
        this.fieldList.forEach(field => {
            fields[field.fieldApiName] = ''; // Initialize each field with an empty value
        });

        const recordInput = { apiName: this.objectName.objectApiName, fields };
        createRecord(recordInput)
            .then(result => {
                console.log('Record created:', result);
                // Refresh the data after creating a new record
                return getWork();
            })
            .then(data => {
                this.data = data;
                this.closeModal();
            })
            .catch(error => {
                console.error('Error creating work record:', error);
                this.closeModal(); // Close modal even if an error occurs
            });
    }

    handleSuccess(event) {
        console.log('Record Id:', event.detail.id);
        this.closeModal(); // Close modal after successful record creation
    }
}