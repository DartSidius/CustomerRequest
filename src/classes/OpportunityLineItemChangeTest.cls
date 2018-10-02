/**
 * Created by Vladyslav Lyfar on 01.10.2018.
 */
@isTest
public class OpportunityLineItemChangeTest {

    @isTest
    static void TestOpportunityProductInsert() {

        //make an operation
        Test.startTest();

        Pricebook2 customPricebook = TestOpportunityLineItemDataFactory.generateNewPriceBook('CustomPricebook');
        List<Product2> products = TestOpportunityLineItemDataFactory.generateProducts(1);
        Opportunity opportunity = TestOpportunityLineItemDataFactory.generateNewOpportunity(customPricebook);
        PricebookEntry pricebookEntry = TestOpportunityLineItemDataFactory.generateNewPricebookEntry(products.get(0), customPricebook);
        List<OpportunityLineItem> opportunityLineItems
                = TestOpportunityLineItemDataFactory.generateOpportunityLineItems(opportunity, pricebookEntry, 100);

        Test.stopTest();

        //compare results
        System.assertEquals(100, [SELECT Count()
                        FROM OpportunityLineItem
                        WHERE OpportunityId = :opportunity.Id AND Product2Id = :products.get(0).Id AND Product__c = :products.get(0).Id]);
    }

    @isTest
    static void TestOpportunityProductUpdate() {

        //prepare data
        Pricebook2 customPricebook = TestOpportunityLineItemDataFactory.generateNewPriceBook('CustomPricebook');
        List<Product2> products = TestOpportunityLineItemDataFactory.generateProducts(2);
        Opportunity opportunity = TestOpportunityLineItemDataFactory.generateNewOpportunity(customPricebook);
        PricebookEntry pricebookEntry = TestOpportunityLineItemDataFactory.generateNewPricebookEntry(products.get(0), customPricebook);
        PricebookEntry pricebookEntry1 = TestOpportunityLineItemDataFactory.generateNewPricebookEntry(products.get(1), customPricebook);
        List<OpportunityLineItem> opportunityLineItems
                = TestOpportunityLineItemDataFactory.generateOpportunityLineItems(opportunity, pricebookEntry, 100);

        //make an operation
        Test.startTest();

        List<OpportunityLineItem> opportunityLineItemsToUpdate = [
                SELECT Product__c, Product2Id, PricebookEntryId
                FROM OpportunityLineItem
                WHERE OpportunityId = :opportunity.Id AND PricebookEntryId = :pricebookEntry.Id
        ];

        for(OpportunityLineItem opportunityLineItem : opportunityLineItemsToUpdate) {
            opportunityLineItem.Product__c = products.get(1).Id;
        }

        update opportunityLineItemsToUpdate;

        Test.stopTest();

        //compare results
        System.assertEquals(100, [
                        SELECT Count()
                        FROM OpportunityLineItem
                        WHERE OpportunityId = :opportunity.Id AND Product2Id = :products.get(1).Id
        ]);
    }
}