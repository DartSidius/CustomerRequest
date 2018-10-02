/**
 * Created by Vladyslav Lyfar on 28.09.2018.
 */

public class OpportunityLineItemTriggerHandler {

    OpportunityProductChangeService opportunityProductChangeService;

    public OpportunityLineItemTriggerHandler() {
        this.opportunityProductChangeService = new OpportunityProductChangeService();
    }

    public void onBeforeInsert(List<OpportunityLineItem> newOpportunityLineItems) {
        this.opportunityProductChangeService.insertCustomProductField(newOpportunityLineItems);
    }

    public void onAfterUpdate(List<OpportunityLineItem> newOpportunityLineItems, Map<Id, OpportunityLineItem> oldOpportunityLineItemsMap) {
        this.opportunityProductChangeService.updateStandardProductField(newOpportunityLineItems, oldOpportunityLineItemsMap);
    }
}