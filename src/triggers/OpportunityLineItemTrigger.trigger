/**
 * Created by Vladyslav Lyfar on 28.09.2018.
 */

trigger OpportunityLineItemTrigger on OpportunityLineItem (before insert, after update) {

   HandlerExecutionPool.executeHandler(OpportunityLineItemTriggerHandler.class);

}