import { LightningElement, wire } from 'lwc';
import getSummary from '@salesforce/apex/JobApplicationHomeController.getSummary';
import getRecentApplications from '@salesforce/apex/JobApplicationHomeController.getRecentApplications';
import { refreshApex } from '@salesforce/apex';

const COLUMNS = [
    { label: 'Application #', fieldName: 'Name' },
    { label: 'Company', fieldName: 'Company_Name__c' },
    { label: 'Role', fieldName: 'Role__c' },
    { label: 'Status', fieldName: 'Status__c' },
    { label: 'Date Applied', fieldName: 'Date_Applied__c', type: 'date' }
];

export default class JobApplicationHome extends LightningElement {
    columns = COLUMNS;
    summary = {
        totalApplications: 0,
        appliedCount: 0,
        interviewCount: 0,
        offerCount: 0,
        rejectedCount: 0
    };
    recentApplications = [];
    summaryWireResult;
    recentWireResult;

    @wire(getSummary)
    wiredSummary(result) {
        this.summaryWireResult = result;
        if (result.data) {
            this.summary = result.data;
        }
    }

    @wire(getRecentApplications)
    wiredRecentApplications(result) {
        this.recentWireResult = result;
        if (result.data) {
            this.recentApplications = result.data;
        }
    }

    async handleRefresh() {
        await Promise.all([
            refreshApex(this.summaryWireResult),
            refreshApex(this.recentWireResult)
        ]);
    }
}
