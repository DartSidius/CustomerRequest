/**
 * Created by Vladyslav Lyfar on 28.09.2018.
 */

public class OpportunityProductChangeTriggerHandler {
    OpportunityProductChangeService opportunityProductChangeService;

    public OpportunityProductChangeTriggerHandler() {
        opportunityProductChangeService = new OpportunityProductChangeService();
    }

    public void onBeforeInsertProductToOpportunityProduct(List<OpportunityLineItem> newOpportunityLineItems) {
        opportunityProductChangeService.beforeInsertProductToOpportunityProduct(newOpportunityLineItems);
    }
}