/**
 * Created by Vladyslav Lyfar on 28.09.2018.
 */

trigger OpportunityLineItemTrigger on OpportunityLineItem (before insert, after update) {

    OpportunityLineItemTriggerHandler opportunityLineItemTriggerHandler = new OpportunityLineItemTriggerHandler();

    switch on Trigger.operationType {
        when BEFORE_INSERT {
            opportunityLineItemTriggerHandler.onBeforeInsert(Trigger.new);
        }
        when AFTER_UPDATE {
            opportunityLineItemTriggerHandler.onAfterUpdate(Trigger.new, Trigger.oldMap);
        }
    }

}