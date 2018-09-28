/**
 * Created by Vladyslav Lyfar on 28.09.2018.
 */

public class FieldUpdateUtility {

    public static void updateNewFireldValue(List<OpportunityLineItem> opportunityLineItems) {
        for(OpportunityLineItem opportunityLineItem : opportunityLineItems) {
            if(opportunityLineItem.Product__c == null) {
                opportunityLineItem.Product__c = opportunityLineItem.Product2Id;
            }
        }
        upsert opportunityLineItems;
    }
}