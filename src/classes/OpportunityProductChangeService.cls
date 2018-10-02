/**
 * Created by Vladyslav Lyfar on 01.10.2018.
 */

public class OpportunityProductChangeService {

    public void insertCustomProductField(List<OpportunityLineItem> newOpportunityLineItems) {
        for (OpportunityLineItem opportunityLineItem : newOpportunityLineItems) {
            opportunityLineItem.Product__c = opportunityLineItem.Product2Id;
        }
    }

    public void updateStandardProductField(List<OpportunityLineItem> newOpportunityLineItems,
            Map<Id, OpportunityLineItem> oldOpportunityLineItemsMap) {
        List<OpportunityLineItem> opportunityLineItemsToCreate
                = this.getOpportunityLineItemsToCreate(newOpportunityLineItems, oldOpportunityLineItemsMap);
        insert opportunityLineItemsToCreate;

        List<OpportunityLineItem> opportunityLineItemsToDelete = this.getOpportunityLineItemsToDelete(oldOpportunityLineItemsMap);
        delete opportunityLineItemsToDelete;
    }

    public void updateHistoryCustomProductsValue(List<OpportunityLineItem> opportunityLineItems) {
        for(OpportunityLineItem opportunityLineItem : opportunityLineItems) {
            opportunityLineItem.Product__c = opportunityLineItem.Product2Id;
        }
        upsert opportunityLineItems;
    }

    private List<OpportunityLineItem> getOpportunityLineItemsToCreate(List<OpportunityLineItem> newOpportunityLineItems,
            Map<Id, OpportunityLineItem> oldOpportunityLineItemsMap) {
        List<OpportunityLineItem> result = new List<OpportunityLineItem>();
        Set<Id> newOpportunityProductsIds = this.getNewOpportunityProductsIds(newOpportunityLineItems, oldOpportunityLineItemsMap);
        if(newOpportunityProductsIds.isEmpty()) {
            return result;
        }
        Map<String, Id> pbeIdByComplexKey = this.getPbeIdByComplexKey(newOpportunityProductsIds);

        Map<Id, OpportunityLineItem> opportunityLineItemById = this.getOpportunityLineItemsByIds(newOpportunityLineItems);
        for (OpportunityLineItem opportunityLineItem : newOpportunityLineItems) {
            Id opportunityLineItemPricebookId = opportunityLineItemById.get(opportunityLineItem.Id).Opportunity.Pricebook2Id;
            Id newPbeId = pbeIdByComplexKey.get(opportunityLineItem.Product__c + '#' + opportunityLineItemPricebookId);
            result.add(this.createNewOpportunityLineItem(opportunityLineItem, newPbeId));
        }
        return result;
    }

    private Set<Id> getNewOpportunityProductsIds(List<OpportunityLineItem> newOpportunityLineItems,
            Map<Id, OpportunityLineItem> oldOpportunityLineItemsMap) {
        Set<Id> result = new Set<Id>();
        for (OpportunityLineItem opportunityLineItem : newOpportunityLineItems) {
            OpportunityLineItem oldOpportunityLineItem = oldOpportunityLineItemsMap.get(opportunityLineItem.Id);
            if(String.isNotEmpty(opportunityLineItem.Product__c) && oldOpportunityLineItem.Product__c != opportunityLineItem.Product__c) {
                result.add(opportunityLineItem.Product__c);
            }
        }
        return result;
    }

    private Map<String, Id> getPbeIdByComplexKey(Set<Id> newOpportunityProductsIds) {
        Map<String, Id> result  = new Map<String, Id>();
        for (PricebookEntry pricebookEntry : [SELECT Product2Id, Pricebook2Id, Id FROM PricebookEntry WHERE Product2Id IN :newOpportunityProductsIds]) {
            result.put(pricebookEntry.Product2Id + '#' + pricebookEntry.Pricebook2Id, pricebookEntry.Id);
        }
        return result;
    }

    private Map<Id, OpportunityLineItem> getOpportunityLineItemsByIds(List<OpportunityLineItem> newOpportunityLineItems) {
        return new Map<Id, OpportunityLineItem>([
                SELECT Opportunity.Pricebook2Id
                FROM OpportunityLineItem
                WHERE Id IN :newOpportunityLineItems
        ]);
    }

    private OpportunityLineItem createNewOpportunityLineItem(OpportunityLineItem opportunityLineItem, Id newPbeId) {
        OpportunityLineItem result = opportunityLineItem.clone(false, true, true, false);
        result.TotalPrice = null;
        result.PricebookEntryId = newPbeId;
        return result;
    }

    private List<OpportunityLineItem> getOpportunityLineItemsToDelete(Map<Id, OpportunityLineItem> oldOpportunityLineItemsMap) {
        return [
                SELECT Id
                FROM OpportunityLineItem
                WHERE Id IN :oldOpportunityLineItemsMap.keySet()
        ];
    }
}