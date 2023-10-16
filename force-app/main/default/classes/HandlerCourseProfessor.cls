public with sharing class HandlerCourseProfessor {
    public static void validateCourseProfessor(list<course_professor__c> courseProf) {
        set<Id> profIds=new Set<Id>();
        Set<Id> courseIds = new Set<Id>();

        //This is a junction object and we are trying to prevent duplicate data.
        Map<String, course_professor__c> courseProfMap= new Map<String, course_professor__c>();

        //Create a string by merging the course and prof Ids from triggering record
        for (course_professor__c cp : courseProf) {
            profIds.add(cp.prof__c);
            courseIds.add(cp.course__c);

            String myKey = String.valueOf(cp.prof__c)+String.valueOf(cp.course__c);
            courseProfMap.put(myKey,cp);
            
        }
        System.debug('profIds: '+profIds);
        System.debug('courseIds'+ courseIds);
        //Check the previous records if the string matches with the new one (compare strings created by merging course and prof Ids )

        for (course_professor__c cp : [SELECT Id, prof__c, course__c
        FROM course_professor__c
        WHERE  prof__c IN:profIds
        AND course__c IN:courseIds]) {
            String systemKey=String.valueOf(cp.prof__c)+String.valueOf(cp.course__c);
            course_professor__c toBeFailed=courseProfMap.get(systemKey);
            
            //Then throw an error if record is duplicate

            if (toBeFailed!=null) {
                toBeFailed.addError('This is a duplicate record');
            }

            
        }

    }
}