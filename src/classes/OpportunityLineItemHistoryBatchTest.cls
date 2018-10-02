/**
 * Created by Vladyslav Lyfar on 02.10.2018.
 */

@isTest
public class OpportunityLineItemHistoryBatchTest {

    @isTest
    static void TestHistoryCustomProductBatchUpdate() {
        //prepare data
        Pricebook2 customPricebook = TestOpportunityLineItemDataFactory.generateNewPriceBook('CustomPricebook');
        List<Product2> products = TestOpportunityLineItemDataFactory.generateProducts(1);
        Opportunity opportunity = TestOpportunityLineItemDataFactory.generateNewOpportunity(customPricebook);
        PricebookEntry pricebookEntry = TestOpportunityLineItemDataFactory.generateNewPricebookEntry(products.get(0), customPricebook);
        List<OpportunityLineItem> opportunityLineItems
                = TestOpportunityLineItemDataFactory.generateOpportunityLineItems(opportunity, pricebookEntry, 100);

        //test magic
        Test.startTest();

        OpportunityLineItemHistoryBatch opportunityLineItemHistoryBatch = new OpportunityLineItemHistoryBatch();
        Id batchId = Database.executeBatch(opportunityLineItemHistoryBatch);

        Test.stopTest();

        //compare results
        System.assertEquals(100, [
                SELECT Count()
                FROM OpportunityLineItem
                WHERE Product__c = :products.get(0).Id AND Product2Id = :products.get(0).Id
        ]);
    }
    
}