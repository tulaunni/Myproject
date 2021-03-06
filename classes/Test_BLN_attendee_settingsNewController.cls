@istest
public class Test_BLN_attendee_settingsNewController{

static testmethod void Testmethod_BLN_attendee_settingsNewController(){
  globalForTestClass globalTest= new globalForTestClass();
   Profile p = [select id from profile where name='System Administrator'];
            userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
         

            User u = new User(alias = 'TestAb', email='manasatest@gmail.com',
                           emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
                           timezonesidkey='America/Los_Angeles', username='testcodehh5689@noemail.com');
            Database.insert(u);
        
        
        
            system.runas(U){
            
            
            NAICS_Code__c naicsCodeInfo1= new NAICS_Code__c();
            naicsCodeInfo1= globalTest.createNaicsCode();
            
            NAICS_Code__c naicsCodeInfo2= new NAICS_Code__c();
            naicsCodeInfo2= globalTest.createNaicsCode();
            
            Currency__c currenyInfo= new Currency__c();
            currenyInfo= globalTest.createCurrency();      
            
            Country__c countryInfo= new Country__c();
            countryInfo= globalTest.createCountry(currenyInfo.Id);  
            
            State__c stateInfo= new State__c ();
            stateInfo= globalTest.createState(countryInfo.Id);     
            
            Company__c companyInfo= new Company__c();
            companyInfo= globalTest.createCompany(u.Companyname);
            
            Company_Ext__c companyExtInfo= new Company_Ext__c();
            companyExtInfo= globalTest.createCompanyExt(companyInfo.Id, naicsCodeInfo1.Id, naicsCodeInfo2.Id, countryInfo.Id, stateInfo.Id); 
                     
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 
            
            
            Reg_Setting__c regSettingsInfo1= new Reg_Setting__c();
            regSettingsInfo1= globalTest.createRegSettings(eventInfo.Id, NULL, NULL, NULL, NULL,'Regular', 'AS_Last_Name__c');
           
            PageReference pgRef = Page.BLN_Registration_Eventdex;
            Test.setCurrentPage(pgRef);
            
             
            Reg_Setting__c regSettingsInfo4= new Reg_Setting__c();
            regSettingsInfo4= globalTest.createRegSettings(eventInfo.Id, NULL, NULL, NULL, NULL,'Regular', 'AS_Last_Name__c');
            
            list<Reg_Setting__c> regsettinginfo3 = new list<Reg_Setting__c>();
            regsettinginfo3.add(regSettingsInfo1);
            
            User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser= globalTest.createGNUser(userForGN, countryInfo.Id, stateInfo.Id);
            
            GN_User__c  gnUserupd= [select id,Email__c from GN_User__c where id=:gnUser.id];
            gnUserupd.Email__c = 'manasatest@gmail.com';
            update gnUserupd;
            
           Tkt_profile__c  tktprof = new Tkt_profile__c();
           tktprof=globalTest.createTktprofile(userForGN);
           Tkt_profile__c  tktprofupd = new Tkt_profile__c();
           tktprofupd.Last_Name__c ='test';
           tktprofupd.id=tktprof.id;
           tktprofupd.TKT_Company__c='company';
           tktprofupd.Work_Phone__c = '123456';
           update tktprofupd;
             
           apexpages.currentpage().getparameters().put('id' , eventInfo.id);
           cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
            ApexPages.currentPage().setCookies(new Cookie[]{counter}); 
            
              
                Order__c insertOrder= new Order__c();
              
                    insertOrder.bln_tkt_profile__c=tktprof.id;
                    insertOrder.Events__c= eventInfo.Id;
                    insertOrder.Order_Total__c= 2;
                    insertOrder.Order_Status__c= 'Fully Paid';
                    insertOrder.Amount_Paid__c= 25.12;
                    insertOrder.Fee_Amount__c= 23.29;
                    insertOrder.Currency_Code__c= currenyInfo.Id;
                insert insertOrder ;
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.Id);
            
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id, trackInfo.Id);
           
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            BLN_Item__c item1= new BLN_Item__c();
            item1= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            Promotion__c Promotion= new Promotion__c();        
            Promotion =   globalTest.createPromotion(eventInfo.id,'testpormo', 'Basic Promo codes', 'Percent');
               Order_Item__c inOrderItem= new Order_Item__c();
              inOrderItem = globalTest.createOrderItem(item.id,insertOrder.id, Promotion.id, currenyInfo.Id);
              BLN_Reg_Main_Template__c tmpl=new BLN_Reg_Main_Template__c(BLN_Events__c=eventInfo.id,Data__c='<div class="row eventdexclass"></div>',structure_type__c='Registration Page',InUse__c=true,Theme_Name__c='Eventdex_Template_11'); 
              insert tmpl;
              Registration_Template__c rgtmpl = new Registration_Template__c(BLN_Events__c=eventInfo.id,Status__c='Active',Styles__c='#container{border:0px #ccc solid;background-color:#95f6ea;',Theme_Name__c='Aqua',Template_Image_URL__c='http://0158A0000008zWs');
              insert rgtmpl ;
              
               Reg_Setting__c RegSettings= new Reg_Setting__c();
               
                RegSettings.Event__c= eventInfo.id;
                RegSettings.Setting_Type__c= 'Registration Tab';
                RegSettings.Group_Name__c= 'Basic Information'; 
                RegSettings.Item__c= item.id;
                RegSettings.Item_Pool__c= ItemPool.id;
                RegSettings.Organizer__c= companyInfo.id;
                RegSettings.Included__c = true;
                RegSettings.Table_Name__c ='test';
                
                insert RegSettings;
              PGateway_Type__c pgway=new PGateway_Type__c(Name = 'Check',Onsite_Flag__c=true);
              insert pgway;
              Pay_Gateway__c pg=new Pay_Gateway__c(Company__c=companyInfo.id,PGateway_Type__c=pgway.id); 
              insert pg;
              Event_Pay_Gateway__c evpay=new Event_Pay_Gateway__c(Events__c=eventInfo.id,Pay_Gateway__c=pg.id,Registration_Type__c='Online');
              insert evpay;
              BLN_Template__c btempl=new BLN_Template__c(BLN_Reg_Main_Template__c=tmpl.id,BLN_Events__c=eventInfo.id,Template_Name__c='Eventdex_Template_11');
              insert btempl;
              BLN_Track__c BTRACK=NEW BLN_Track__c(Event__c=eventInfo.id,Name='TRACK1');
              insert BTRACK;
              Agenda__c agenda = new Agenda__c(Event__c=eventInfo.id,BLN_Ticket__c=ItemPool.id,Name='SEM1',Visibility__c='Public',BLN_Track__c=BTRACK.ID);
              insert agenda ;
              Currency__c cur=new Currency__c(Currency_Name__c='US Dollar',Name='USD',Currency_Symbol__c='INR');
              insert cur;
              Country__c scou=new Country__c(Currency__c=cur.id,Long_Name__c='United States Of America',Short_Name__c='US');
              insert scou;
              State__c state=new State__c(Long_Name__c='New Jersey',Short_Name__c='NJ',Country__c=scou.id);
              insert state;
              Company_Ext__c comext=new Company_Ext__c(Company__c=companyInfo.id,Blog_URL__c='http://1');
              insert comext;
              Role__c role=new Role__c(NAME='Company Admin');
              insert role;
              UC_Role__c ucr=new UC_Role__c(Company__c=companyInfo.id,Event__c=eventInfo.id,RoleId__c=role.id,GN_User__c=gnUser.id,User_Type__c='Personal');
              insert ucr;
              BLN_Address__c address=new BLN_Address__c(Address1__c='flat no 206',State__c=state.id,City__c='hyd',Country__c=scou.id);
              insert address;
              Ticket__c Ticket= new Ticket__c();        
              Ticket=globalTest.createTicket(eventInfo.id,item.Id,itemPool.Id,itemType.Id, insertOrder.id, tktprof.Id);
              BLN_attendee_settingsNewController attsettings=new BLN_attendee_settingsNewController ();
              Apexpages.currentPage().getParameters().put('pmValue',Ticket.id);
              attsettings.setApplyItems =string.valueof(item.id+','+item.id);
              ItemPool.Ticket_Settings__c ='Do not collect Attendee info';
              update ItemPool;
              attsettings.selectedInfoType='Do not collect Attendee info';
              list<BLN_Item__c> blnitem=new list<BLN_Item__c >();
              blnitem.add(item);
              attsettings.itemList=blnitem;
              attsettings.fetchSettings();
              attsettings.getSetting(Ticket.id);
              attsettings.Save();
              attsettings.cancelAct();
              try{
              attsettings.savedefAction();
              }catch(Exception e){}
              attsettings.saveBuyerAction();
              attsettings.SaveGpName();
              attsettings.settingrec('Regular',string.valueof(item.id));
              list<BLN_Item__c> blnitem1=new list<BLN_Item__c >();
              blnitem1.add(new BLN_Item__c(item_name__c='tet'));
              List<dataBase.saveResult> result=Database.insert(blnitem1, false);
              attsettings.resultOfrecs(result);
              ApexPages.currentPage().getParameters().put('idsettingsvalue',item.id+','+'Collect info from All Attendees'+'\\^'+item1.id+','+'Collect info from All Attendees') ;
             attsettings.Save();
              }
              }
}