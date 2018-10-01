/**
 * Created by Vladyslav Lyfar on 01.10.2018.
 */

public class OpportunityProductChangeService {
    public void beforeInsertProductToOpportunityProduct(List<OpportunityLineItem> newOpportunityLineItems) {
        for(OpportunityLineItem opportunityLineItem : newOpportunityLineItems) {
            opportunityLineItem.Product__c = opportunityLineItem.Product2Id;
        }
    }
}