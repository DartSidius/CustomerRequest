/**
 * Created by Vladyslav Lyfar on 01.10.2018.
 */
@isTest
public class OpportunityProductChangeTest {
    @isTest
    static void TestOpportunityProductInsert() {

        Test.startTest();

        List<OpportunityLineItem> opportunityProducts = new List<OpportunityLineItem>();

        Product2 product = new Product2(
            Name = 'Test Product'
        );

        insert product;

        Pricebook2 customPB = new Pricebook2(Name='Custom Pricebook', isActive=true);
        insert customPB;

        Id pricebookId = Test.getStandardPricebookId();

        // Insert a price book entry for the standard price book.
        PricebookEntry standardPrice = new PricebookEntry(
                Pricebook2Id = pricebookId, Product2Id = product.Id,
                UnitPrice = 10000, IsActive = true);
        insert standardPrice;

        PricebookEntry customPrice = new PricebookEntry(
                Pricebook2Id = customPB.Id, Product2Id = product.Id,
                UnitPrice = 12000, IsActive = true);
        insert customPrice;

        Opportunity opportunity = new Opportunity(
                Name = 'Test Opportunity',
                CloseDate = Date.today(),
                StageName = 'Prospecting',
                PriceBook2 = customPB
        );

        insert opportunity;

        Integer opportunityProductCounter = 0;

        for(Integer i = 0; i<100; i++) {
            opportunityProducts.add(new OpportunityLineItem(
                OpportunityId = opportunity.Id,
                Product2Id = product.Id,
                Quantity = 10,
                UnitPrice = 100,
                PricebookEntryId=customPrice.Id
            ));
        }
        insert opportunityProducts;

        Test.stopTest();

        for(OpportunityLineItem opportunityLineItem :
                [SELECT Product2Id, Product__c FROM OpportunityLineItem WHERE OpportunityId = :opportunity.Id AND Product2Id = :product.Id]) {
            if(opportunityLineItem.Product2Id == opportunityLineItem.Product__c) {
                opportunityProductCounter++;
            }
        }

        System.assertEquals(100, opportunityProductCounter);
    }
}