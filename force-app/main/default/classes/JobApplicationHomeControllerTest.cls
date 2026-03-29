@IsTest
private class JobApplicationHomeControllerTest {
    @TestSetup
    static void createData() {
        insert new List<Job_Application__c>{
            new Job_Application__c(
                Company_Name__c = 'Google',
                Role__c = 'Data Analyst',
                Status__c = 'Applied',
                Date_Applied__c = Date.today().addDays(-10)
            ),
            new Job_Application__c(
                Company_Name__c = 'Amazon',
                Role__c = 'Business Analyst',
                Status__c = 'Interview',
                Date_Applied__c = Date.today().addDays(-8)
            ),
            new Job_Application__c(
                Company_Name__c = 'Meta',
                Role__c = 'Data Scientist',
                Status__c = 'Rejected',
                Date_Applied__c = Date.today().addDays(-6)
            ),
            new Job_Application__c(
                Company_Name__c = 'Microsoft',
                Role__c = 'Analytics Engineer',
                Status__c = 'Offer',
                Date_Applied__c = Date.today().addDays(-4)
            )
        };
    }

    @IsTest
    static void testGetSummary() {
        Test.startTest();
        JobApplicationHomeController.SummaryData summary = JobApplicationHomeController.getSummary();
        Test.stopTest();

        System.assertEquals(4, summary.totalApplications);
        System.assertEquals(1, summary.appliedCount);
        System.assertEquals(1, summary.interviewCount);
        System.assertEquals(1, summary.offerCount);
        System.assertEquals(1, summary.rejectedCount);
    }

    @IsTest
    static void testGetRecentApplications() {
        Test.startTest();
        List<Job_Application__c> records = JobApplicationHomeController.getRecentApplications();
        Test.stopTest();

        System.assert(records.size() > 0);
        System.assert(records.size() <= 8);
    }
}
