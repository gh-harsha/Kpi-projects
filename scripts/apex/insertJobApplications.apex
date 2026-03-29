List<Job_Application__c> sampleApplications = new List<Job_Application__c>{
    new Job_Application__c(
        Company_Name__c = 'Google',
        Role__c = 'Data Analyst',
        Status__c = 'Applied',
        Date_Applied__c = Date.today().addDays(-7),
        Notes__c = 'Applied through careers portal. Waiting for recruiter response.'
    ),
    new Job_Application__c(
        Company_Name__c = 'Amazon',
        Role__c = 'Business Analyst',
        Status__c = 'Interview',
        Date_Applied__c = Date.today().addDays(-14),
        Notes__c = 'Cleared recruiter call. Technical interview scheduled next week.'
    ),
    new Job_Application__c(
        Company_Name__c = 'Meta',
        Role__c = 'Data Scientist',
        Status__c = 'Rejected',
        Date_Applied__c = Date.today().addDays(-21),
        Notes__c = 'Received rejection email after final screening.'
    )
};

insert sampleApplications;
System.debug('Inserted sample job applications: ' + sampleApplications.size());
