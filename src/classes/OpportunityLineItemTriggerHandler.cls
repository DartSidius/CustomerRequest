/**
 * Created by Vladyslav Lyfar on 28.09.2018.
 */

public class OpportunityLineItemTriggerHandler extends Handler {

    OpportunityProductChangeService opportunityProductChangeService;

    public OpportunityLineItemTriggerHandler() {
        super(OpportunityLineItemTriggerHandler.class);
        this.opportunityProductChangeService = new OpportunityProductChangeService();
    }

    public override void onBeforeInsert(List<sObject> newOpportunityLineItems) {
        this.opportunityProductChangeService.insertCustomProductField(newOpportunityLineItems);
    }

    public override void onAfterUpdate(List<sObject> newOpportunityLineItems, Map<Id, sObject> oldOpportunityLineItemsMap) {
        this.opportunityProductChangeService.updateStandardProductField(newOpportunityLineItems, (Map<Id, OpportunityLineItem>) oldOpportunityLineItemsMap);
    }
}