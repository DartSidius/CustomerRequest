/**
 * Created by Vladyslav Lyfar on 28.09.2018.
 */

trigger OpportunityProductChangeTrigger on OpportunityLineItem (before insert) {

    OpportunityProductChangeTriggerHandler opportunityProductChangeTriggerHandler = new OpportunityProductChangeTriggerHandler();

    if(Trigger.isBefore && Trigger.isInsert) {
        opportunityProductChangeTriggerHandler.beforeInsertProductToOpportunityProduct(Trigger.new);
    }

}