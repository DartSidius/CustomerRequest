/**
 * Created by Vladyslav Lyfar on 28.09.2018.
 */

public class OpportunityProductChangeTriggerHandler {
    public void beforeInsertProductToOpportunityProduct(List<OpportunityLineItem> newOpportunityLineItems) {
        for(OpportunityLineItem opportunityLineItem : newOpportunityLineItems) {
            opportunityLineItem.Product__c = opportunityLineItem.Product2Id;
        }
    }
}