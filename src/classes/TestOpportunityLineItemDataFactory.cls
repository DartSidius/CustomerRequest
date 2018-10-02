/**
 * Created by Vladyslav Lyfar on 02.10.2018.
 */

public class TestOpportunityLineItemDataFactory {

    public static Pricebook2 generateNewPricebook(String name) {
        Pricebook2 customPricebook = new Pricebook2(
                Name=name,
                isActive=true
        );
        insert customPricebook;
        return customPricebook;
    }

    public static List<Product2> generateProducts(Integer amount) {
        List<Product2> products = new List<Product2>();
        for(Integer i = 0; i<amount; i++) {
            products.add(new Product2(
                    Name = 'TestProduct' + i
            ));
        }
        insert products;
        return products;
    }

    public static List<OpportunityLineItem> generateOpportunityLineItems(Opportunity opportunity,
            PricebookEntry pricebookEntry, Integer amount) {
        List<OpportunityLineItem> opportunityLineItems = new List<OpportunityLineItem>();
        for(Integer i = 0; i<amount; i++) {
            opportunityLineItems.add(new OpportunityLineItem(
                    OpportunityId = opportunity.Id,
                    Quantity = 10,
                    UnitPrice = 100,
                    PricebookEntryId = pricebookEntry.Id
            ));
        }
        insert opportunityLineItems;
        return opportunityLineItems;
    }

    public static PricebookEntry generateNewPricebookEntry(Product2 product, Pricebook2 pricebook) {
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry standardPrice = new PricebookEntry(
                Pricebook2Id = pricebookId,
                Product2Id = product.Id,
                UnitPrice = 10000,
                IsActive = true);
        insert standardPrice;

        PricebookEntry customPrice = new PricebookEntry(
                Pricebook2Id = pricebook.Id,
                Product2Id = product.Id,
                UnitPrice = 12000,
                IsActive = true);

        insert customPrice;
        return customPrice;
    }

    public static Opportunity generateNewOpportunity(Pricebook2 pricebook) {
        Opportunity opportunity = new Opportunity(
                Name = 'Test Opportunity',
                CloseDate = Date.today(),
                StageName = 'Prospecting',
                PriceBook2 = pricebook
        );
        insert opportunity;
        return opportunity;
    }

}