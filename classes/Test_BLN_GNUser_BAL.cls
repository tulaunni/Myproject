@isTest
public class Test_BLN_GNUser_BAL{

    static testmethod void Testmethod_BLN_GNUser_BAL(){
        
       // User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
       // U= globalTest.createUser();
        
          Profile p = [select id from profile where name='System Administrator'];
         userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
         
        
        User u = new User(alias = 'Test', email='testcodecd@noemail.com',
            emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
            localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
            timezonesidkey='America/Los_Angeles', username='testcodecd@noemail.com');
        Database.insert(u);
        
        
        system.runas(U){
        
        User userForGN= new User();
        userForGN= globalTest.createUserForGNUser();
        
        Company__c companyInfo= new Company__c();
        companyInfo= globalTest.createCompany(u.Companyname);
        
        Currency__c currenyInfo= new Currency__c();
        currenyInfo= globalTest.createCurrency();             
        
        Country__c countryInfo= new Country__c();
        countryInfo= globalTest.createCountry(currenyInfo.Id);  
        
        State__c stateInfo= new State__c ();
        stateInfo= globalTest.createState(countryInfo.Id);
        
        GN_User__c  gnUser= new GN_User__c();
        gnUser= globalTest.createGNUser(userForGN,countryInfo.Id, Stateinfo.Id);
        
        AttendeeSummary__c  att= new AttendeeSummary__c ();
        att.AS_Email__c='test567@salesforce.com';
        att.AS_FirstName__c='sName';
        att.AS_LastName__c='Sag';    
        att.AS_Company__c ='Globalnest';
        insert att;
   
        BLN_Event__c eventInfo= new  BLN_Event__c();
        eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 
        
        Order__c insertOrder1= new Order__c();
        Tkt_profile__c  tktprof = new Tkt_profile__c();
        tktprof =globalTest.createTktprofile(userForGN);
        insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
        
        Item_Type__c itemType= new Item_Type__c();
        itemType= globalTest.createItemType();
        itemType.name = 'Admissions';
        update itemType;
        
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
        
        NAICS_Code__c naicsCodeInfo1= new NAICS_Code__c();
        naicsCodeInfo1= globalTest.createNaicsCode();    
            
        Ticket__c ticket= new Ticket__c();
        ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
        
        Ticket__c ticket2= new Ticket__c();
        ticket2= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
        ticket2.Parent_ID__c = ticket.id;
        update ticket2;
        

            
            BLN_GNUser_BAL blngnuserbal = new BLN_GNUser_BAL();
            blngnuserbal.upsertGNUser('Boothleads');
            
            List<Tkt_profile__c> lsttktpro = new List<Tkt_profile__c>();
            lsttktpro.add(tktprof);
            blngnuserbal.inserTingAtt(lsttktpro);
            blngnuserbal.attValues(att,tktprof);
            
            
            SET<String> emails = new SET<String>();
            emails.add('test@test.com');
            BLN_GNUser_BAL.updateuser1(emails );
          
        }  
  
   }
  
}