public with sharing class JobApplicationHomeController {
    public class SummaryData {
        @AuraEnabled public Integer totalApplications;
        @AuraEnabled public Integer appliedCount;
        @AuraEnabled public Integer interviewCount;
        @AuraEnabled public Integer offerCount;
        @AuraEnabled public Integer rejectedCount;
    }

    @AuraEnabled(cacheable=true)
    public static SummaryData getSummary() {
        SummaryData summary = new SummaryData();
        summary.totalApplications = 0;
        summary.appliedCount = 0;
        summary.interviewCount = 0;
        summary.offerCount = 0;
        summary.rejectedCount = 0;

        for (AggregateResult row : [
            SELECT Status__c status, COUNT(Id) total
            FROM Job_Application__c
            GROUP BY Status__c
        ]) {
            String status = (String) row.get('status');
            Integer total = (Integer) row.get('total');
            summary.totalApplications += total;

            if (status == 'Applied') {
                summary.appliedCount = total;
            } else if (status == 'Interview') {
                summary.interviewCount = total;
            } else if (status == 'Offer') {
                summary.offerCount = total;
            } else if (status == 'Rejected') {
                summary.rejectedCount = total;
            }
        }

        return summary;
    }

    @AuraEnabled(cacheable=true)
    public static List<Job_Application__c> getRecentApplications() {
        return [
            SELECT Id, Name, Company_Name__c, Role__c, Status__c, Date_Applied__c
            FROM Job_Application__c
            ORDER BY LastModifiedDate DESC
            LIMIT 8
        ];
    }
}
