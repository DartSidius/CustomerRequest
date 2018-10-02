/**
 * Created by Vladyslav Lyfar on 28.09.2018.
 */

public class OpportunityLineItemHistoryBatch implements Database.Batchable<sObject> {

    OpportunityProductChangeService opportunityProductChangeService;

    public OpportunityLineItemHistoryBatch() {
        this.opportunityProductChangeService = new OpportunityProductChangeService();
    }

    public void execute(Database.BatchableContext bc, List<OpportunityLineItem> scope) {
        this.opportunityProductChangeService.updateHistoryCustomProductsValue(scope);
    }

    public void finish(Database.BatchableContext bc) {}

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Product2Id, Product__c FROM OpportunityLineItem WHERE Product__c = NULL');
    }
}