@isTest

public class Test_BLN_ASC_AttendeeLoadMore {
    
    static testMethod void testMethod_Test_BLN_ASC_AttendeeLoadMore(){
        
        //User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        //U= globalTest.createUser();
        Profile p = [select id from profile where name='System Administrator'];
        userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
         

         User U = new User(alias = 'Test11', email='testcode3@noemail.com',
                           emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting11', Firstname='codeTesting12', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
                           timezonesidkey='America/Los_Angeles', username='testcode3@noemail.com');
        
        system.runas(U){
            //User userForGN= new User();
            //userForGN= globalTest.createUserForGNUser();
            User userInfo= new User();
            userInfo= globalTest.createUserForGNUser();
            
            Company__c companyInfo= new Company__c();
            
            companyInfo= globalTest.createCompany(u.Companyname);
            
            Currency__c currenyInfo= new Currency__c();
            currenyInfo= globalTest.createCurrency();             
            
            Country__c countryInfo= new Country__c();
            countryInfo= globalTest.createCountry(currenyInfo.Id);  
            
            State__c stateInfo= new State__c ();
            stateInfo= globalTest.createState(countryInfo.Id);
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser = globalTest.createGNUser(userInfo,countryInfo.Id, Stateinfo.Id);
            
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 
            
            //Order__c insertOrder1= new Order__c();
            //insertOrder1= globalTest.createOrder(gnUser.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userInfo);

            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id, userInfo.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.Id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.Id);
            
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id, trackInfo.Id);
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
            Order_Item__c orderItem= new Order_Item__c();
            orderItem= globalTest.createOrderItem(item.Id, insertOrder1.Id, null, currenyInfo.Id);
            Promotion__c promotion1= new Promotion__c();
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo1', 'Basic Promo codes', 'Percent');
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo2', 'Basic Promo codes', 'Amount');
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo3', 'Basic Promo codes', 'Quantity');
            
            Promotion__c promotion2= new Promotion__c();
            promotion2= globalTest.createPromotion(eventInfo.id, 'Multi-Items Discount Promo1', 'Multi-Items Discount', 'Percent');
            promotion2= globalTest.createPromotion(eventInfo.id, 'Multi-Items Discount Promo2', 'Multi-Items Discount', 'Amount');
            promotion2= globalTest.createPromotion(eventInfo.id, 'Multi-Items Discount Promo3', 'Multi-Items Discount', 'Quantity');
            
            Promotion__c promotion3= new Promotion__c();
            promotion3= globalTest.createPromotion(eventInfo.id, 'Buy Something Get Something Promo1', 'Buy Something Get Something', 'Percent');
            promotion3= globalTest.createPromotion(eventInfo.id, 'Buy Something Get Something Promo2', 'Buy Something Get Something', 'Amount');
            promotion3= globalTest.createPromotion(eventInfo.id, 'Buy Something Get Something Promo3', 'Buy Something Get Something', 'Quantity');
            
            Promotion__c promotion4= new Promotion__c();
            promotion4= globalTest.createPromotion(eventInfo.id, 'Spend More Save More Promo1', 'Spend More Save More', 'Percent');
            promotion4= globalTest.createPromotion(eventInfo.id, 'Spend More Save More Promo2', 'Spend More Save More', 'Amount');
            promotion4= globalTest.createPromotion(eventInfo.id, 'Spend More Save More Promo3', 'Spend More Save More', 'Quantity');
            
            Question__c que = new Question__c();
            que=globalTest.createQuestion(eventInfo.id);
            
            Item_Question__c itemQue = new Item_Question__c();
            itemQue =globalTest.createItemQuestion(eventInfo.id,item.Id,que.Id);
            
           BLN_Answer__c ans = new BLN_Answer__c();
            ans=globalTest.createAnswer(que.Id);
             
            User_Answer__c  usrAns = new User_Answer__c();
            usrAns=globalTest.createUserAnswer(gnUser.id,itemQue.Id, ans.Id);
            
            Hash_Tag__c hashT=new Hash_Tag__c();
            hashT=globalTest.createHashTag(eventInfo.id);
            
            //ItemPool_Tag_Junction__c itemPJ = new ItemPool_Tag_Junction__c ();
            //itemPJ=globalTest.createtagjunction(itemPool.Id, hashT.Id);
            
            Reg_Setting__c rSet= new Reg_Setting__c();
            rSet=globalTest.createRegSettings(eventInfo.id,itemPool.Id, item.id, companyInfo.id, hashT.id, 'thirumala', 'globalnest');
            
            //Ticket__c ticket= new Ticket__c();
            //ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, gnUser.Id);
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
        
            PGateway_Type__c pgt = new PGateway_Type__c(Name='cash');
            insert pgt;
            
            Pay_Gateway__c pw= new Pay_Gateway__c(Company__c=companyInfo.id,Paygateway_name__c='cash',Service_Fee__c='Include',PGateway_Type__c=pgt.id,PG_Email_Id__c='test@gmail.com',PP_Payment_Type__c='Parallel');
            insert pw;
            
            Payment__c pp= new Payment__c();
            pp.BLN_Pay_Gateway__c=pw.id;
            pp.credit_card_last_4digits__c='1245';
            pp.credit_card_type__c='visa';
            pp.Currency_Code__c=currenyInfo.id;
            pp.Order__c=insertOrder1.id;
            pp.Payment_Amount__c=100;
            pp.Payment_Mode__c='cash';
            insert pp;
            
            System.RestContext.request = new RestRequest();
            
            //RestRequest req = new RestRequest(); 
            String sfbaseURL = URL.getSalesforceBaseUrl().toExternalForm();
            RestContext.request.addParameter('Event_id',eventInfo.id);
            RestContext.request.addParameter('User_id',U.id);
            RestContext.request.addParameter('offset','5');
            RestContext.request.addParameter('limit','4');
            RestContext.request.requestURI =  sfbaseURL+'/services/apexrest/BLN_ASC_AttendeeLoadMore';  
            RestContext.request.httpMethod = 'POST';
            
            BLN_ASC_AttendeeLoadMore blnascatt = new BLN_ASC_AttendeeLoadMore();
            
               BLN_ASC_AttendeeLoadMore.maincontainer blnmainc = new BLN_ASC_AttendeeLoadMore.maincontainer();
               BLN_ASC_AttendeeLoadMore.TotalList blnascmore = new BLN_ASC_AttendeeLoadMore.TotalList();
               BLN_ASC_AttendeeLoadMore.Ordersonly blnascatto = new BLN_ASC_AttendeeLoadMore.Ordersonly();
                blnmainc.orderInn = insertOrder1;
                blnmainc.dt = system.today();
                blnmainc.ticketsInn = Null;
                blnmainc.cancelledTickets = Null;
                blnmainc.orderItemInn = Null;
                blnmainc.paymentInn = pp;
                blnmainc.orderPrice = 0.11;
                blnmainc.compListInner = Null;
                //blnmainc.ticketTags = Null;
                blnascatto.OrdersList_info = insertOrder1;
                blnascmore.isorder = true;
               
               BLN_ASC_AttendeeLoadMore.doPost(); 
            
            
            
        
        
    }

}
    
}