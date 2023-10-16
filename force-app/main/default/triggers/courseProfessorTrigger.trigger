trigger courseProfessorTrigger on course_professor__c (before insert, before update) {

    if (trigger.isBefore) {
      
      if (trigger.isInsert || trigger.isUpdate) {
        HandlerCourseProfessor.validateCourseProfessor(trigger.new);
      }
    }
}