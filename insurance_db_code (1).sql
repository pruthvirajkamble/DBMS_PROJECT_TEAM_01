drop database insurance;
create database insurance;
use insurance;

-- -----------------------------------------------------
-- 1-Table CUSTOMER 
-- -----------------------------------------------------

CREATE TABLE T1_CUSTOMER(
  CUST_ID int NOT NULL,
  CUST_FNAME VARCHAR(10) NOT NULL,
  CUST_LNAME VARCHAR(10) NOT NULL,
  CUST_DOB DATE NOT NULL,
  CUST_GENDER CHAR(2) NULL,
  CUSTOMER_ADDRESS VARCHAR(20) NOT NULL,
  CUST_MOB_NUMBER BIGINT NOT NULL UNIQUE,
  CUST_EMAIL VARCHAR(30) NOT NULL UNIQUE,
  CUST_PASSPORT_NUMBER VARCHAR(20) NULL UNIQUE,
  CUST_MARITAL_STATUS CHAR(8) NULL,
  PRIMARY KEY (CUST_ID));

-- -----------------------------------------------------
-- 2-Table APPLICATION 
-- -----------------------------------------------------

CREATE TABLE T1_APPLICATION (
  APPLICATION_ID VARCHAR(20) NOT NULL,
  CUST_ID int NOT NULL,
  VEHICLE_ID INT NOT NULL,
  APPLICATION_STATUS CHAR(8) NULL,
  COVERAGE VARCHAR(50) NULL,
  PRIMARY KEY (APPLICATION_ID),
  CONSTRAINT R10201
  FOREIGN KEY  (CUST_ID)
  REFERENCES T1_CUSTOMER (CUST_ID));

  -- -----------------------------------------------------
-- 3-Table INSURANCE_POLICY
-- -----------------------------------------------------

CREATE TABLE T1_INSURANCE_POLICY (
  AGREEMENT_ID VARCHAR(20) NOT NULL,
  DEPARTMENT_NAME VARCHAR(20) NULL,
  POLICY_NUMBER VARCHAR(20) NULL,
  START_DATE DATE NULL,
  EXPIRY_DATE DATE NULL,
  TERM_CONDITON_DESCRIPTON VARCHAR(100) NULL,
  APPLICATION_ID VARCHAR(20) NOT NULL,
  PRIMARY KEY (AGREEMENT_ID, APPLICATION_ID),
  CONSTRAINT unique_fk UNIQUE (APPLICATION_ID),
  CONSTRAINT R10403
  FOREIGN KEY (APPLICATION_ID)
  REFERENCES T1_APPLICATION (APPLICATION_ID));

-- -----------------------------------------------------
-- 4-Table PREMIUM_PAYMENT
-- -----------------------------------------------------

CREATE TABLE T1_PREMIUM_PAYMENT (
  PREMIUM_PAYMENT_ID VARCHAR(20) NOT NULL,
  CUST_ID int NOT NULL,
  POLICY_NUMBER VARCHAR(20) NULL,
  PREMIUM_PAYMENT_SCHEDULE DATE NULL,
  PREMIUM_PAYMENT_AMOUNT INT NULL,
  RECEIPT_ID VARCHAR(20) NULL,
  PRIMARY KEY (PREMIUM_PAYMENT_ID, CUST_ID),
  CONSTRAINT R10501
  FOREIGN KEY (CUST_ID)
  REFERENCES T1_CUSTOMER (CUST_ID));

-- -----------------------------------------------------
-- 5-Table VEHICLE
-- -----------------------------------------------------

CREATE TABLE T1_VEHICLE (
  VEHICLE_ID INT NOT NULL,
  CUST_ID int NOT NULL,
  POLICY_NUMBER VARCHAR(20) NULL,
  DEPENDENT_NOK_ID VARCHAR(20) NULL,
  VEHICLE_REGISTRATION_NUMBER VARCHAR(20) NULL,
  VEHICLE_VALUE INT NULL,
  VEHICLE_TYPE VARCHAR(20) NULL,
  VEHICLE_SIZE INT NULL,
  VEHICLE_NUMBER_OF_SEAT INT NULL,
  VEHICLE_MANUFACTURER VARCHAR(20) NULL,
  VEHICLE_ENGINE_NUMBER INT NULL,
  VEHICLE_CHASIS_NUMBER INT NULL,
  VEHICLE_NUMBER VARCHAR(20) NULL,
  VEHICLE_MODEL_NUMBER VARCHAR(20) NULL,
  PRIMARY KEY (VEHICLE_ID),
  CONSTRAINT R10601
  FOREIGN KEY (CUST_ID)
  REFERENCES T1_CUSTOMER (CUST_ID));

-- -----------------------------------------------------
-- 6-Table CLAIM
-- -----------------------------------------------------

CREATE TABLE T1_CLAIM (
  CLAIM_ID INT NOT NULL,
  INCIDENT_REPORT_ID VARCHAR(20) NOT NULL,
  AGREEMENT_ID VARCHAR(20) NULL,
  CLAIM_AMOUNT INT NULL,
  DAMAGE_TYPE VARCHAR(20) NULL,
  DATE_OF_CLAIM DATE NULL,
  CLAIM_STATUS CHAR(10) NULL,
  PRIMARY KEY (CLAIM_ID),
  CONSTRAINT unique_fk3 UNIQUE (INCIDENT_REPORT_ID));

-- -----------------------------------------------------
-- 7-Table CLAIM_SETTLEMENT
-- -----------------------------------------------------

CREATE TABLE T1_CLAIM_SETTLEMENT (
  CLAIM_SETTLEMENT_ID INT NOT NULL,
  DATE_SETTLED DATE NULL,
  AMOUNT_PAID INT NULL,
  COVERAGE_ID VARCHAR(20) NULL,
  CLAIM_ID INT NOT NULL,
  PRIMARY KEY (CLAIM_SETTLEMENT_ID , CLAIM_ID),
  CONSTRAINT unique_fk5 UNIQUE(CLAIM_ID),
  CONSTRAINT R20807
  FOREIGN KEY (CLAIM_ID )
  REFERENCES T1_CLAIM (CLAIM_ID));
  
-- -----------------------------------------------------
-- 8-Table INSURANCE_COMPANY
-- -----------------------------------------------------

CREATE TABLE T1_INSURANCE_COMPANY (
  COMPANY_NAME VARCHAR(20) NOT NULL,
  COMPANY_ADDRESS VARCHAR(20) NULL,
  COMPANY_CONTACT_NUMBER bigINT NULL,
  COMPANY_FAX bigINT NULL,
  COMPANY_EMAIL VARCHAR(20) NULL,
  COMPANY_WEBSITE VARCHAR(20) NULL,
  COMPANY_LOCATION VARCHAR(20) NULL,
  COMPANY_OFFICE_NAME VARCHAR(20) NULL,
  PRIMARY KEY (COMPANY_NAME));

-- -----------------------------------------------------
-- 9-Table DEPARTMENT
-- -----------------------------------------------------

CREATE TABLE T1_DEPARTMENT (
  DEPARTMENT_NAME VARCHAR(20) NOT NULL,
  COMPANY_NAME VARCHAR(20) NOT NULL,
  OFFICE VARCHAR(20) NULL,
  CONTACT_INFORMATION VARCHAR(20) NULL,
  DEPARTMENT_STAFF VARCHAR(45) NULL,
  DEPARTMENT_LEADER VARCHAR(20) NULL,
  PRIMARY KEY (DEPARTMENT_NAME, COMPANY_NAME),
  CONSTRAINT R11109
  FOREIGN KEY (COMPANY_NAME)
  REFERENCES T1_INSURANCE_COMPANY (COMPANY_NAME));

-- -----------------------------------------------------
-- 10-Table OFFICE
-- -----------------------------------------------------

CREATE TABLE T1_OFFICE (
  OFFICE_NAME VARCHAR(20) NOT NULL,
  DEPARTMENT_NAME VARCHAR(20) NOT NULL,
  COMPANY_NAME VARCHAR(20) NOT NULL,
  OFFICE_LEADER VARCHAR(20) NULL,
  CONTACT_INFORMATION VARCHAR(20) NULL,
  ADDRESS VARCHAR(20) NULL,
  ADMIN_COST INT NULL,
  STAFF VARCHAR(50) NULL,
  PRIMARY KEY (OFFICE_NAME, DEPARTMENT_NAME, COMPANY_NAME),
  CONSTRAINT R21211
  FOREIGN KEY (DEPARTMENT_NAME , COMPANY_NAME)
  REFERENCES T1_DEPARTMENT (DEPARTMENT_NAME , COMPANY_NAME));

-- -----------------------------------------------------
-- 11-Table POLICY_RENEWABLE
-- -----------------------------------------------------

CREATE TABLE T1_POLICY_RENEWABLE (
  POLICY_RENEWABLE_ID VARCHAR(20) NOT NULL,
  AGREEMENT_ID VARCHAR(20) NOT NULL,
  APPLICATION_ID VARCHAR(20) NOT NULL,
  DATE_OF_RENEWAL DATE NULL,
  TYPE_OF_RENEWAL CHAR(15) NULL,
  PRIMARY KEY (POLICY_RENEWABLE_ID, AGREEMENT_ID, APPLICATION_ID),
  CONSTRAINT R31604
  FOREIGN KEY (AGREEMENT_ID  , APPLICATION_ID)
  REFERENCES T1_INSURANCE_POLICY (AGREEMENT_ID , APPLICATION_ID));

-- -----------------------------------------------------
-- 12-Table INCIDENT
-- -----------------------------------------------------

CREATE TABLE T1_INCIDENT (
  INCIDENT_ID VARCHAR(20) NOT NULL,
  INCIDENT_TYPE VARCHAR(30) NULL,
  INCIDENT_DATE DATE NULL,
  DESCRIPTION VARCHAR(100) NULL,
  PRIMARY KEY (INCIDENT_ID));

-- -----------------------------------------------------
-- 13-Table INCIDENT_REPORT
-- -----------------------------------------------------

CREATE TABLE T1_INCIDENT_REPORT (
  INCIDENT_REPORT_ID VARCHAR(20) NOT NULL,
  INCIDENT_ID VARCHAR(20) NOT NULL,
  CUST_ID int NOT NULL,
  INCIDENT_INSPECTOR VARCHAR(20) NULL,
  INCIDENT_COST INT NULL,
  INCIDENT_TYPE CHAR(10) NULL,
  INCIDENT_REPORT_DESCRIPTION VARCHAR(100) NULL,
  POLICY_NUMBER VARCHAR(20) NULL,
  PRIMARY KEY (INCIDENT_REPORT_ID),
  CONSTRAINT unique_fk4 UNIQUE(INCIDENT_ID),
  CONSTRAINT R11817
  FOREIGN KEY (INCIDENT_ID)
  REFERENCES T1_INCIDENT (INCIDENT_ID),
  CONSTRAINT R11801
  FOREIGN KEY (CUST_ID)
  REFERENCES T1_CUSTOMER (CUST_ID));

-- -----------------------------------------------------
-- 14-Table COVERAGE
-- -----------------------------------------------------

CREATE TABLE T1_COVERAGE (
  COVERAGE_ID VARCHAR(20) NOT NULL,
  COMPANY_NAME VARCHAR(20) NOT NULL,
  COVERAGE_AMOUNT INT NULL,
  COVERAGE_TYPE CHAR(10) NULL,
  COVERAGE_LEVEL CHAR(15) NULL,
  PRODUCT_ID VARCHAR(20) NULL,
  COVERAGE_DESCRIPTION VARCHAR(100) NULL,
  COVERAGE_TERMS VARCHAR(50) NULL,
  PRIMARY KEY (COVERAGE_ID, COMPANY_NAME),
  CONSTRAINT R11909
  FOREIGN KEY (COMPANY_NAME)
  REFERENCES T1_INSURANCE_COMPANY (COMPANY_NAME));

-- -----------------------------------------------------
-- 15-Table PRODUCT
-- -----------------------------------------------------

CREATE TABLE T1_PRODUCT (
  PRODUCT_NUMBER VARCHAR(20) NOT NULL,
  COMPANY_NAME VARCHAR(20) NOT NULL,
  PRODUCT_PRICE INT NULL,
  PRODUCT_TYPE CHAR(15) NULL,
  PRIMARY KEY (PRODUCT_NUMBER, COMPANY_NAME),
  CONSTRAINT R12009
  FOREIGN KEY (COMPANY_NAME)
  REFERENCES T1_INSURANCE_COMPANY (COMPANY_NAME));

-- -----------------------------------------------------
-- 16-Table INSURANCE_POLICY_COVERAGE
-- -----------------------------------------------------

CREATE TABLE T1_INSURANCE_POLICY_COVERAGE (
  AGREEMENT_ID VARCHAR(20) NOT NULL,
  COVERAGE_ID VARCHAR(20) NOT NULL,
  APPLICATION_ID VARCHAR(20) NOT NULL,
  COMPANY_NAME VARCHAR(20) NOT NULL,
  PRIMARY KEY (AGREEMENT_ID, COVERAGE_ID, APPLICATION_ID, COMPANY_NAME),
  CONSTRAINT R32204
  FOREIGN KEY (AGREEMENT_ID , APPLICATION_ID)
  REFERENCES T1_INSURANCE_POLICY (AGREEMENT_ID , APPLICATION_ID)
  ON UPDATE NO ACTION,
  CONSTRAINT R22219
  FOREIGN KEY (COVERAGE_ID , COMPANY_NAME)
  REFERENCES T1_COVERAGE (COVERAGE_ID , COMPANY_NAME));

Alter table T1_CLAIM add CONSTRAINT R104704
FOREIGN KEY (AGREEMENT_ID)
REFERENCES T1_INSURANCE_POLICY (AGREEMENT_ID);

Alter table T1_CLAIM add CONSTRAINT R20718
FOREIGN KEY (INCIDENT_REPORT_ID)
REFERENCES T1_INCIDENT_REPORT (INCIDENT_REPORT_ID);


--  data insertation into customer table 

 insert  into T1_customer values(1001 ,  'Kartik'   ,  'Bhamare' ,  '2002-09-30' ,  'M'  ,  'Nashik'   , 8344520943 ,  'kre.511@gmail.com'      , ""         , 'Single'  );
 insert  into T1_customer values(1002 ,  'Kartik'   ,  'Bhamare' ,  '2002-12-30' ,  'M'  ,  'Nashik'   , 8308520943 ,  'mare.111@gmail.com'     , NULL       , 'Single'  );
 insert  into T1_customer values(1003 ,  'Ragni'    ,  'Roy'     ,  '2001-12-30' ,  'F'  ,  'Pune'     , 9875896548 ,  'Roy.141@gmail.com'      , NULL       , 'Single'  );
 insert  into T1_customer values(1004 ,  'Kalpesh'  ,  'roy'     ,  '2002-07-20' ,  'M'  ,  'bhokar'   , 9881096336 ,  'kamare.001@gmail.com'   , NULL       , 'Single'  );
 insert  into T1_customer values(1005 ,  'bharat'   ,  'uma'     ,  '2002-06-10' ,  'F'  ,  'Nanded'   , 8308520944 ,  'namera.141@gmail.com'   , NULL       , 'married' );
 insert  into T1_customer values(1006 ,  'keshav'   ,  'dubey'   ,  '2002-05-30' ,  NULL ,  'latur'    , 9011429380 ,  'nasmera.111@gmail.com'  , NULL       , 'Single'  );
 insert  into T1_customer values(1007 ,  'daulat'   ,  'jha'     ,  '2002-04-10' ,  'M'  ,  'Nashik'   , 8308550943 ,  'nama.611@gmail.com'     , 'J8369844' , 'married' );
 insert  into T1_customer values(1008 ,  'harshita' ,  'guled'   ,  '2002-03-30' ,  'F'  ,  'delhi'    , 8308540943 ,  'rajha.141@gmail.com'    , NULL       , 'Single'  );
 insert  into T1_customer values(1009 ,  'neha'     ,  'porwal'  ,  '2002-02-10' ,  'F'  ,  'Nashik'   , 8308523943 ,  'rajbha.991@gmail.com'   , NULL       , 'married' );
 insert  into T1_customer values(1010 ,  'prithvi'  ,  'kamble'  ,  '2002-01-12' ,  'M'  ,  'kolhapur' , 8508520943 ,  'rajbha.@gmail.com'      , 'J8349854' , 'Single'  );
 insert  into T1_customer values(1011 ,  'roshan'   ,  'pooniya' ,  '2002-08-02' ,  'M'  ,  'Nashik'   , 8323520943 ,  'bdfeaje.111@gmail.com'  , NULL       , 'Single'  );
 insert  into T1_customer values(1012 ,  'devansh'  ,  'Borle'   ,  '2002-09-12' ,  NULL ,  'dharwad'  , 8388520943 ,  'derwg5e.111@gmail.com'  , NULL       , 'Single'  );
 insert  into T1_customer values(1013 ,  'ravi'     ,  'kumar'   ,  '2002-09-23' ,  'F'  ,  'Nashik'   , 8308520443 ,  'devraje.111@gmail.com'  , NULL       , 'married' );
 insert  into T1_customer values(1014 ,  'dev'      ,  'mehant'  ,  '2002-05-04' ,  'F'  ,  'hubli'    , 8308520643 ,  'devraje.4444@gmail.com' , 'J8569854' , 'Single'  );
 insert  into T1_customer values(1015 ,  'raj'      ,  'war'     ,  '2002-08-23' ,  'M'  ,  'mirzapur' , 8308590943 ,  'dev33je.111@gmail.com'  ,  NULL      , 'married' );

--  inset into application tables; 

 insert into T1_APPLICATION value('AP123456775' , 1001 , 5001 , 'RD32201' , null);
 insert into T1_APPLICATION value('AP14356765'  , 1002 , 5002 , 'RD32202' , null);
 insert into T1_APPLICATION value('AP1235456'   , 1004 , 5004 , 'RD32204' , null);
 insert into T1_APPLICATION value('AP123547'    , 1005 , 5005 , 'RD32205' , null);
 insert into T1_APPLICATION value('AP1234548'   , 1006 , 5006 , 'RD32206' , null);
 insert into T1_APPLICATION value('AP125439'    , 1007 , 5007 , 'RD32207' , null);
 insert into T1_APPLICATION value('AP125310'    , 1008 , 5008 , 'RD32208' , null);
 insert into T1_APPLICATION value('AP1231541'   , 1009 , 5009 , 'RD32209' , null);
 insert into T1_APPLICATION value('AP12354513'  , 1011 , 5001 , 'RD322011', null);
 insert into T1_APPLICATION value('AP12354514'  , 1012 , 5001 , 'RD322012', null);
 insert into T1_APPLICATION value('AP12354515'  , 1013 , 5001 , 'RD322013', null);
 insert into T1_APPLICATION value('AP1235416'   , 1014 , 5001 , 'RD322014', null);
 insert into T1_APPLICATION value('AP12354517'  , 1015 , 5001 , 'RD322015', null);
 
--  INSERT INTO PREMIUM_PAYMENT;

 insert into T1_premium_payment value('00001' , 1001 , '2000' , '2002-01-31' , '50000'   , 'ID101' );
 insert into T1_premium_payment value('00002' , 1002 , '2001' , '2002-01-30' , '60000'   , 'ID102' );
 insert into T1_premium_payment value('00004' , 1004 , '2003' , '2002-02-28' , '80000'   , 'ID104' );
 insert into T1_premium_payment value('00005' , 1005 , '2004' , '2002-02-27' , '590000'  , 'ID105' );
 insert into T1_premium_payment value('00006' , 1006 , '2005' , '2002-02-26' , '578000'  , 'ID106' );
 insert into T1_premium_payment value('00007' , 1007 , '2006' , '2002-02-25' , '777700'  , 'ID107' );
 insert into T1_premium_payment value('00008' , 1008 , '2007' , '2002-02-24' , '509000'  , 'ID108' );
 insert into T1_premium_payment value('00009' , 1009 , '2008' , '2002-02-23' , '900000'  , 'ID109' );
 insert into T1_premium_payment value('00010' , 1010 , '2009' , '2002-02-22' , '1540000' , 'ID110' );
 insert into T1_premium_payment value('00011' , 1011 , '2010' , '2002-02-20' , '580000'  , 'ID111' );
 insert into T1_premium_payment value('00012' , 1012 , '2011' , '2002-02-21' , '5072000' , 'ID112' );
 insert into T1_premium_payment value('00013' , 1013 , '2012' , '2002-02-19' , '5700000' , 'ID113' );
 insert into T1_premium_payment value('00014' , 1014 , '2013' , '2002-02-18' , '700000'  , 'ID114' );
 insert into T1_premium_payment value('00015' , 1015 , '2014' , '2002-02-17' , '3000000' , 'ID115' );

-- insert into insurance_policy

 insert into T1_insurance_policy values (  'AG1001' ,  'tool_design'         ,    '97asfd6'   ,   '2020-08-4 '  ,   '2023-1-8'  ,   'valid for three year'   ,   'AP123456775' );
 insert into T1_insurance_policy values (  'AG1002' ,  'marketing'           ,    '97asdasf'  ,   '2020-01-1 '  ,   '2023-1-1'  ,   'valid for three year'   ,   'AP14356765'  );
 insert into T1_insurance_policy values (  'AG1003' ,  'production'          ,    '97wfg'     ,   '2020-02-2 '  ,   '2023-2-2'  ,   'valid for three year'   ,   'AP1235456'   );
 insert into T1_insurance_policy values (  'AG1004' ,  'engineering'         ,    '97rbw6'    ,   '2020-08-3 '  ,   '2023-1-3'  ,   'valid fr three year'    ,   'AP123547'    );
 insert into T1_insurance_policy values (  'AG1005' ,  'human_resources'     ,    '9sdvsfd6'  ,   '2020-08-4 '  ,   '2023-1-4'  ,   'valid for three year'   ,   'AP1234548'   );
 insert into T1_insurance_policy values (  'AG1006' ,  'info_service'        ,    '97wbr6'    ,   '2020-08-5 '  ,   '2023-1-5'  ,    null                    ,   'AP125439'    );
 insert into T1_insurance_policy values (  'AG1007' ,  'design_head'         ,    '9wecd6'    ,   '2020-08-6 '  ,   '2023-1-6'  ,    null                    ,   'AP125310'    );
 insert into T1_insurance_policy values (  'AG1008' ,  'computer_science'    ,    '9etnbfd6'  ,   '2020-08-7 '  ,   '2023-1-7'  ,    null                    ,   'AP1231541'   );
 insert into T1_insurance_policy values (  'AG1009' ,  'network'             ,    '97mytu'    ,   '2020-08-8 '  ,   '2023-1-8'  ,    null                    ,   'AP12354513'  );
 insert into T1_insurance_policy values (  'AG1010' ,  'techgnology'         ,    '97w24t'    ,   '2020-08-9 '  ,   '2023-1-9'  ,    null                    ,   'AP12354514'  );
 insert into T1_insurance_policy values (  'AG1011' ,  'code'                ,    '24thy536'  ,   '2020-08-10'  ,   '2023-1-10' ,    null                    ,   'AP12354515'  );
 insert into T1_insurance_policy values (  'AG1012' ,  'web_development'     ,    'aswrough43',   '2020-08-11'  ,   '2023-1-12' ,    null                    ,   'AP1235416'   );
 insert into T1_insurance_policy values (  'AG1013' ,  'industry_specialist' ,    '43bre'     ,   '2020-08-13'  ,   '2023-1-13' ,    null                    ,   'AP12354517'  );

-- insert into insurance_company

INSERT INTO T1_INSURANCE_COMPANY VALUES( "BAJAJ INSURANCE"         ,  "KALPASAKI_ST,HYD"      ,9875671203 ,  4765490  ,  "BAJAJ@GMAIL.COM"    ,  "BAJAJ_LTD.CO.IN"     ,  "TELANGANA"      ,"BAJAJ_HYD"         );
INSERT INTO T1_INSURANCE_COMPANY VALUES( "AEGON INSURANCE"         ,  "MAMALLAB_RD,CHENNAI"   ,9786543621 ,  4578567  ,  "AEGON@GMAIL.COM"    ,  "AEGON_LTD.CO.IN"     ,  "TAMIL_NADU"     ,"AEGON_BANGALORE"   );
INSERT INTO T1_INSURANCE_COMPANY VALUES( "AVIVA INSURANCE"         ,  "MANGAL_CROSS,DELHI"    ,9872543621 ,  4503435  ,  "AVIVA@GMAIL.COM"    ,  "AVIA_LTD.CO.IN"      ,  "DELHI"          ,"AVIVA_DEL"         );
INSERT INTO T1_INSURANCE_COMPANY VALUES( "CANARA HSBC"             ,  "104 AREA,NAD"          ,8789543621 ,  5451232  ,  "CANARA@GMAIL.COM"   ,  'CANARA.CO.IN'        ,  "GUNTUR"         ,"CANARA_GUNTUR"     );
INSERT INTO T1_INSURANCE_COMPANY VALUES( "DHFL PRAMERICA"          ,  "MAMALLABURAM,ITI"      ,9001543621 ,  6563423  ,  "DHFL@GMAIL.COM"     ,  "DHFL.CO.IN"          ,  "ONGOLE"         ,"DHFL_ONGOLE"       );
INSERT INTO T1_INSURANCE_COMPANY VALUES( "EDELWEISS TOKIO"         ,  "GOPALAPATNAM,BHPV"     ,7895776556 ,  423123   ,  "EDELWEISS@GMAIL.COM",  "EDELWEISS.CO.IN"     ,  "VISAKHAPATNAM"  ,"ELWEISS_VSKP"      );
INSERT INTO T1_INSURANCE_COMPANY VALUES( "ICICI PRUDENTIAL"        ,  "TOKICHOKI_RD,HYD"      ,8621543621 ,  8653306  ,  "ICICI@GMAIL.COM"    ,   "ICICI.CO.IN"        ,  "HYDERABAD"      ,"ICICI_HYD"         );
INSERT INTO T1_INSURANCE_COMPANY VALUES( "IDBI INSURANCE"          ,  "BENCZ_RD,GUJARATH"     ,9786596842 ,  4534231  ,  "IDBI@GMAIL.COM"     ,   "IDBI_LTD.CO.IN"     ,  "RAJKOT"         ,"GUJARATH"          );
INSERT INTO T1_INSURANCE_COMPANY VALUES( "INDIAFIRST INSUR"        ,  "SHER_E_COLONY,PUNJAB"  ,9241596842 ,  3434232  ,  "INDIA@GMAIL.COM"    ,   "INDIA1ST_LTD.CO.IN" ,  "JALANDAR"       ,"PUNJAB"            );
INSERT INTO T1_INSURANCE_COMPANY VALUES( "KOTAK INSURANCE"         ,  "AKSHAY_RD,KARNATAKA"   ,7887234121 ,  42315634 ,  "KOTAK@GMAIL.COM"    ,   "KOTAK_LTD.CO.IN"    ,  "HUBLI"          ,"KARNATAKA"         );
INSERT INTO T1_INSURANCE_COMPANY VALUES( "EXIDE LIFE INSURANCE"    ,  "WALTAIR_RD,VIZAG"      ,8321544620 ,  8153306  ,  "EXIDE@GMAIL.COM"    ,  "EXIDE_LTD.CO.IN"     ,  "VIZAG"          ,"EXIDE_VIZAG"       );
INSERT INTO T1_INSURANCE_COMPANY VALUES( "BHARTI INSURANCE"        ,  "KAMAKSI_ST,VIZAG"      ,9432167120 ,  4012357  ,  "BHARTI@GMAIL.COM"   ,  "BHARTI_LTD.CO.IN"    ,  "ANDHRA"         ,"BHARTI_VIZAG"      );
INSERT INTO T1_INSURANCE_COMPANY VALUES( "BIRLA SUN INSURANCE"     ,  "MARRIPALEM"            ,9343543621 ,  4325432  ,  "BIRLA@GMAIL.COM"    ,   "BIRLASUN.CO.IN"     ,  "VISAKHAPATNAM"  ,"BIRLA_VSKP"        );
INSERT INTO T1_INSURANCE_COMPANY VALUES( "FUTURE GENERALI"         ,  "KULOOR_RD,MANGLOR"     ,9321743621 ,  7653236  ,  "FUTUREG@GMAIL.COM"  ,  "FUTURE_G_LTD.CO.IN"  ,  "MANGLORE"       ,"FUTURE_G_MANGLORE" );
INSERT INTO T1_INSURANCE_COMPANY VALUES( "HDFC STANDARD"           ,  "JEEDIMETLA,HYD"        ,8621540671 ,  9653536  ,  "HDFC@GMAIL.COM"     ,  "HDFC_LTD.CO.IN"      ,  "HYDERABAD"      ,"HDFC_HYDERABAD"    );

-- insert into department

INSERT INTO T1_DEPARTMENT VALUES(  "PRODUCTION_AND_SALES"   ,  "EDELWEISS TOKIO"        ,  "ELWEISS_VSKP"  ,9908556864  ,  "JOE,JACK,JOHN,JANU" , "JACK"  );
INSERT INTO T1_DEPARTMENT VALUES(  "2ND_RECRUITMENT_DEPT"   ,  "ICICI PRUDENTIAL"       ,  "ICICI_HYD"     ,9148934896  ,  "SAM,ANU,RAM,SEENU"  , "ANU"   );
INSERT INTO T1_DEPARTMENT VALUES(  "MARKETING_DEPT"         ,  "IDBI INSURANCE"         ,  "IDBI_HYDERABAD",8660645654  ,  "RANI,RAJ,SIMHA"     , "RAJ"   );
INSERT INTO T1_DEPARTMENT VALUES(  "TECHNICAL_DEPT"         ,  "DHFL PRAMERICA"         ,  "DHFL_ONGOLE"   ,8660654654  ,  "RANI,RAJA,SIMHA"    , "RAJA"  );
INSERT INTO T1_DEPARTMENT VALUES(  "PAYMENTS"               ,  "EDELWEISS TOKIO"        ,  "EDELWEISS_DEL" ,6362297167  ,  "BEN,BOB,CAL,SMITH"  , "SMITH" );
INSERT INTO T1_DEPARTMENT VALUES(  "REINSURANCE_DEPT"       ,  "ICICI PRUDENTIAL"       ,  "ICICI_CHENNAI" ,9108787821  ,  "DEAN,DEV,VARUN,SAI" , "SAI"   );
INSERT INTO T1_DEPARTMENT VALUES(  "HR_DEPT"                ,  "INDIAFIRST INSUR"       ,  "HYDERABAD"     ,8660865654  ,  "RANI,RAJA,SIMHA"    , "RAJA"  );
INSERT INTO T1_DEPARTMENT VALUES(  "AGENT_RECRUITMENT"      ,  "KOTAK INSURANCE"        ,  "KARNATAKA"     ,9148934756  ,  "CHAY,CHI,SRI,LAX"   , "CHAY"  );
INSERT INTO T1_DEPARTMENT VALUES(  "OFFICE_ADMIN_DEPT"      ,  "HDFC STANDARD"          ,  "HDFC_HYDERABAD",9660685654  ,  "RANI,RAJA,SIMHA"    , "SIMHA" );
INSERT INTO T1_DEPARTMENT VALUES(  "ADVT_DEPT"              ,  "EDELWEISS TOKIO"        ,  "KARNATAKA"     ,7640685654  ,  "RANI,RAJA,SIMHA"    , "RAJA"  );
INSERT INTO T1_DEPARTMENT VALUES(  "RECRUITMENT_DEPT"       ,  "DHFL PRAMERICA"         ,  "KARNATAKA"     ,9148934756  ,  "CHAY,CHI,SRI,LAX"   , "CHAY"  );
INSERT INTO T1_DEPARTMENT VALUES(  "ADMIN_DEPT"             ,  "DHFL PRAMERICA"         ,  "HYDERABAD"     ,8660685654  ,  "RANI,RAJA,SIMHA"    ,  "RAJA"  );

--  insert into office

INSERT INTO T1_OFFICE VALUES ("ELWEISS_VSKP"       , "PRODUCTION_AND_SALES"  , "EDELWEISS TOKIO"      , 'TRINADH'   , "EDELWEISS@GMAIL.COM"  , "GOPALAPATNAM,BHPV"    , '1900' , 'SAI SAMPATH'    );
INSERT INTO T1_OFFICE VALUES ("ICICI_HYD"          , "2ND_RECRUITMENT_DEPT"  , "ICICI PRUDENTIAL"     , 'RAGHAVAN'  , "ICICI@GMAIL.COM"      , "TOKICHOKI_RD,HYD"     , '1800' , 'SAI KEERTHI'    );
INSERT INTO T1_OFFICE VALUES ("IDBI_HYDERABAD"     , "MARKETING_DEPT"        , "IDBI INSURANCE"       , 'GOUTHAM'   , "IDBI@GMAIL.COM"       , "BENCZ_RD,GUJARATH"    , '2100' , 'RAGU PRASAD'    );
INSERT INTO T1_OFFICE VALUES ("DHFL_ONGOLE"        , "TECHNICAL_DEPT"        , "DHFL PRAMERICA"       , 'CHANDHAN'  , "DHFL@GMAIL.COM"       , "MAMALLABURAM,ITI"     , '1700' , 'SPANDANA YADAV' );
INSERT INTO T1_OFFICE VALUES ("EDELWEISS_DEL"      , "PAYMENTS"              , "EDELWEISS TOKIO"      , 'VINEETH'   , "AVIVA@GMAIL.COM"      , "MANGAL_CROSS,DELHI"   , '1900' , 'JAGADESH REDDY' );
INSERT INTO T1_OFFICE VALUES ("ICICI_CHENNAI"      , "REINSURANCE_DEPT"      , "ICICI PRUDENTIAL"     , 'KARTHICK'  , "AEGON@GMAIL.COM"      , "MAMALLAB_RD,CHENNAI"  , '2000' , 'VIJAY KRISHNA'  );
INSERT INTO T1_OFFICE VALUES ("HYDERABAD"          , "HR_DEPT"               , "INDIAFIRST INSUR"     , 'DEEPAK'    , "INDIA@GMAIL.COM"      , "SHER_E_COLONY,PUNJAB" , '2000' , 'VAMSI KRISHNA'  );
INSERT INTO T1_OFFICE VALUES ("KOTAK_KARNATAKA"    , "AGENT_RECRUITMENT"     , "KOTAK INSURANCE"      , 'SAMPATH'   , "KOTAK@GMAIL.COM"      , "AKSHAY_RD,KARNATAKA"  , '1700' , 'KALYANI KUMAR'  );
INSERT INTO T1_OFFICE VALUES ("HDFC_HYDERABAD"     , "OFFICE_ADMIN_DEPT"     , "HDFC STANDARD"        , 'AVINASH'   , "HDFC@GMAIL.COM"       , "JEEDIMETLA,HYD"       , '1900' , 'JASWANTH REDDY' );
INSERT INTO T1_OFFICE VALUES ("EDELWEISS_KARNATAKA", "ADVT_DEPT"             , "EDELWEISS TOKIO"      , 'LOKESH'    , "FUTUREG@GMAIL.COM"    , "KULOOR_RD,MANGLOR"    , '1500' , 'MANEESH KUMAR'  );
INSERT INTO T1_OFFICE VALUES ("DHFL_KARNATAKA"     , "RECRUITMENT_DEPT"      , "DHFL PRAMERICA"       , 'KALYANBABU', "BIRLA@GMAIL.COM"      , "MARRIPALEM"           , '2100' , 'LAXMI PRASANNA' );
INSERT INTO T1_OFFICE VALUES ("DHFL_HYDERABAD"     , "ADMIN_DEPT"            , "DHFL PRAMERICA"       , 'ADITYA'    , "EXIDE@GMAIL.COM"      , "WALTAIR_RD,VIZAG"     , '1400' , 'DEEPIKA REDDY'  );

--  insert into product

INSERT INTO T1_PRODUCT VALUES ( '4PN010' , "EXIDE LIFE INSURANCE"  , 20000  , ' SIDE WINDOWS'    );
INSERT INTO T1_PRODUCT VALUES ( '4PN011' , "FUTURE GENERALI"       , 56000  ,  'TAIL LIGHTS'     );
INSERT INTO T1_PRODUCT VALUES ( '4PN012' , "EXIDE LIFE INSURANCE"  , 10000  ,   'CHAINS'         );
INSERT INTO T1_PRODUCT VALUES ( '4PN013' , "IDBI INSURANCE"        , 76000  ,  'SUSPENSION'      );
INSERT INTO T1_PRODUCT VALUES ( '4PN014' , "INDIAFIRST INSUR"      , 50000  ,  'GAS PUMP'        );
INSERT INTO T1_PRODUCT VALUES ( '4PN015' , "KOTAK INSURANCE"       , 11000  ,  'BIKE SERVICE'    );
INSERT INTO T1_PRODUCT VALUES ( '4PN003' , "BAJAJ INSURANCE"       , 9500   ,  'REAR BUMP'       );
INSERT INTO T1_PRODUCT VALUES ( '4PN002' , "INDIAFIRST INSUR"       , 11000  ,  'PETROL PUMP'     );
INSERT INTO T1_PRODUCT VALUES ( '4PN004' , "BHARTI INSURANCE"      , 52000  ,  'THEFT'           );
INSERT INTO T1_PRODUCT VALUES ( '4PN005' , "BIRLA SUN INSURANCE"   , 56000  ,  'BUMPERHEADLIGHT' );
INSERT INTO T1_PRODUCT VALUES ( '4PN006' , "CANARA HSBC"           , 100000 ,  'FULL SERVICE'    );
INSERT INTO T1_PRODUCT VALUES ( '4PN007' , "DHFL PRAMERICA"        , 2500   ,  'SIDE MIRRORS'    );
INSERT INTO T1_PRODUCT VALUES ( '4PN008' , "EDELWEISS TOKIO"       , 50000  ,  'BACK DICKIE'     );
INSERT INTO T1_PRODUCT VALUES ( '4PN020' , "CANARA HSBC"           , 40000  ,  'PETROL LEAK'     );
INSERT INTO T1_PRODUCT VALUES ( '4PN017' , "AEGON INSURANCE"       , 100000 ,  'PETROL LEAK'     );

-- incident

insert into T1_incident values ('IN1001' , 'Major Incident'     , '2019-12-10' ,null);
insert into T1_incident values ('IN1002' , 'Near miss Incident' , '2019-12-11' ,null);
insert into T1_incident values ('IN1003' , 'Complex Incident'   , '2019-12-11' ,null);
insert into T1_incident values ('IN1004' , 'Major Incident'     , '2019-04-12' ,null);
insert into T1_incident values ('IN1005' , 'Complex Incident'   , '2019-12-19' ,null);
insert into T1_incident values ('IN1006' , 'Complex Incident'   , '2019-07-11' ,null);
insert into T1_incident values ('IN1007' , 'Near miss Incident' , '2019-12-11' ,null);
insert into T1_incident values ('IN1008' , 'Major Incident'     , '2019-01-01' ,null);
insert into T1_incident values ('IN1009' , 'Complex Incident'   , '2019-05-05' ,null);
insert into T1_incident values ('IN1010' , 'Near miss Incident' , '2019-12-11' ,null);
insert into T1_incident values ('IN1011' , 'Major Incident'     , '2019-12-27' ,null);
insert into T1_incident values ('IN1012' , 'Near miss Incident' , '2019-12-11' ,null);
insert into T1_incident values ('IN1013' , 'Complex Incident'   , '2019-10-28' ,null);
insert into T1_incident values ('IN1014' , 'Near miss Incident' , '2019-02-11' ,null);
insert into T1_incident values ('IN1015' , 'Major Incident'     , '2019-12-29' ,null);

-- incident_report

insert into T1_incident_report values ('IRI1001' , 'IN1001' , 1001 , 'Akashva'  , 100000 ,  'FIRE'    ,  Null , '2000' );
insert into T1_incident_report values ('IRI1002' , 'IN1002' , 1002 , 'Anoup'    , 110000 , 'Loss'     ,  Null , '2001' );
insert into T1_incident_report values ('IRI1003' , 'IN1003' , 1003 , 'Devansh'  , 125000 , 'Accident' ,  Null , '2003' );
insert into T1_incident_report values ('IRI1004' , 'IN1004' , 1004 , 'Sakshi'   , 100000 , 'Theft'    ,  Null , '2004' );
insert into T1_incident_report values ('IRI1005' , 'IN1005' , 1005 , 'Supriya'  , 135000 , 'Accident' ,  Null , '2005' );
insert into T1_incident_report values ('IRI1006' , 'IN1006' , 1006 ,  'Vijay'   , 145000 , 'Loss'     ,  Null , '2006' );
insert into T1_incident_report values ('IRI1007' , 'IN1007' , 1007 , 'Akaash'   , 155000 , 'Theft'    ,  Null , '2007' );
insert into T1_incident_report values ('IRI1008' , 'IN1008' , 1008 , 'Rakshit'  , 105000 , 'Loss'     ,  Null , '2008' );
insert into T1_incident_report values ('IRI1009' , 'IN1009' , 1009 , 'Ravikant' , 103000 , 'Theft'    ,  Null , '2009' );
insert into T1_incident_report values ('IRI1010' , 'IN1010' , 1010 , 'Bhawana'  , 115000 , 'Accident' ,  Null , '2010' );
insert into T1_incident_report values ('IRI1011' , 'IN1011' , 1011 , 'Rinku'    , 109000 , 'Loss'     ,  Null , '2011' );
insert into T1_incident_report values ('IRI1012' , 'IN1012' , 1012 , 'Rachna'   , 134000 , 'FIRE'     ,  Null , '2012' );
insert into T1_incident_report values ('IRI1013' , 'IN1013' , 1013 , 'Hari om'  , 123000 , 'FIRE'     ,  Null , '2013' );
insert into T1_incident_report values ('IRI1014' , 'IN1014' , 1014 , 'Nelam'    , 145000 , 'Loss'     ,  Null , '2014' );
insert into T1_incident_report values ('IRI1015' , 'IN1015' , 1015 , 'Rakesh'   , 156000 , 'FIRE'     ,  Null , '2015' );
insert into T1_incident_report values ('IRI1016' , 'IN1016' , 1016 , 'Rakesh'   , 156000 , 'FIRE'     ,  Null , '2016' );

-- claim

insert into T1_claim values  ( 1001 ,  'IRI1001'  , 'AG1001'  , 90000   ,  'Theift'           , '2020-03-12'  , 'verrified' );
insert into T1_claim values  ( 1002 ,  'IRI1002'  , 'AG1002'  , 87000   ,  'Fire'             , '2020-12-12'  , 'Unverified');
insert into T1_claim values  ( 1003 ,  'IRI1003'  , 'AG1003'  , 83000   ,  'Theift'           , '2020-01-12'  , 'verrified' );
insert into T1_claim values  ( 1004 ,  'IRI1004'  , 'AG1004'  , 102000  ,  'Complex Incident' , '2020-12-12'  , 'verrified' );
insert into T1_claim values  ( 1005 ,  'IRI1005'  , 'AG1005'  , 13000   ,  'Theift'           , '2020-07-10'  , 'Unverified');
insert into T1_claim values  ( 1006 ,  'IRI1006'  , 'AG1006'  , 45000   ,  'Complex Incident' , '2020-12-12'  , 'Pending'   );
insert into T1_claim values  ( 1007 ,  'IRI1007'  , 'AG1007'  , 70000   ,  'Theift'           , '2020-09-12'  , 'verrified' );
insert into T1_claim values  ( 1008 ,  'IRI1008'  , 'AG1008'  , 130000  ,  'Theift'           , '2020-09-09'  , 'verrified' );
insert into T1_claim values  ( 1009 ,  'IRI1009'  , 'AG1009'  , 40000   ,  'Theift'           , '2020-12-12'  , 'Pending'   );
insert into T1_claim values  ( 1010 ,  'IRI1010'  , 'AG1010'  , 56000   ,  'Fire'             , '2020-03-12'  , 'Unverified');
insert into T1_claim values  ( 1011 ,  'IRI1011'  , 'AG1011'  , 90000   ,  'Theift'           , '2020-12-12'  , 'verrified' );
insert into T1_claim values  ( 1012 ,  'IRI1012'  , 'AG1012'  , 120000  ,  'Complex Incident' , '2020-02-27'  , 'Pending'   );
insert into T1_claim values  ( 1013 ,  'IRI1013'  , 'AG1013'  , 10000   ,  'Theift'           , '2020-12-12'  , 'verrified' );

-- claim_settlement

insert into T1_claim_settlement values (1001 , '2021-12-16' ,80000  , 'CID1001' , 1001 );
insert into T1_claim_settlement values (1002 , '2021-12-16' ,80000  , 'CID1001' , 1002 );
insert into T1_claim_settlement values (1003 , '2021-10-14' ,90000  , 'CID1002' , 1003 );
insert into T1_claim_settlement values (1004 , '2021-12-24' ,100000 , 'CID1003' , 1004 );
insert into T1_claim_settlement values (1005 , '2021-08-16' ,120000 , 'CID1004' , 1005 );
insert into T1_claim_settlement values (1006 , '2021-12-04' ,98000  , 'CID1005' , 1006 );
insert into T1_claim_settlement values (1007 , '2021-12-16' ,87000  , 'CID1006' , 1007 );
insert into T1_claim_settlement values (1008 , '2021-04-16' ,81000  , 'CID1007' , 1008 );
insert into T1_claim_settlement values (1009 , '2021-12-05' ,73000  , 'CID1008' , 1009 );
insert into T1_claim_settlement values (1010 , '2021-12-16' ,88000  , 'CID1009' , 1010 );
insert into T1_claim_settlement values (1011 , '2021-12-09' ,80000  , 'CID1010' , 1011 );
insert into T1_claim_settlement values (1012 , '2021-01-16' ,84000  , 'CID1011' , 1012 );
insert into T1_claim_settlement values (1013 , '2021-12-09' ,12000  , 'CID1012' , 1013 );

-- vehicle 

insert into T1_vehicle value  (  5001  ,  1001  ,  '2000',  'PDK105651' , '1230456' , ' 100000 ' ,  'BIKE' , NULL , '2' , 'HONDA'  , '001' , '554301'    , '1999' , 'HONDA SP 125'        );
insert into T1_vehicle value  (  5002  ,  1002  ,  '2001',  'PDK101'    , '1230456' , ' 100000 ' ,  'BIKE' , NULL , '2' , 'HONDA'  , '001' , '5056543'   , '1999' , 'Hero GLAMOR'         );
insert into T1_vehicle value  (  5003  ,  1003  ,  '2002',  'PDK17751'  , '1230456' , ' 100000 ' ,  'BIKE' , NULL , '2' , 'HONDA'  , '001' , '500876541' , '1999' , 'Bajaj pulsor'        );
insert into T1_vehicle value  (  5004  ,  1003  ,  '2002',  'PD66651'   , '1230456' , ' 100000 ' ,  'BIKE' , NULL , '2' , 'HONDA'  , '001' , '576543'    , '1999' , 'Bajaj pulsor 125'    );
insert into T1_vehicle value  (  5005  ,  1005  ,  '2004',  'PDK1651'   , '1230456' , ' 108765 ' ,  'BIKE' , NULL , '2' , 'HONDA'  , '001' , '500345671' , '1999' , 'boxer'               );
insert into T1_vehicle value  (  5006  ,  1006  ,  '2005',  'PDK100251' , '1230456' , ' 108760 ' ,  'BIKE' , NULL , '2' , 'HONDA'  , '001' , '50567801'  , '1999' , 'hero super splendor' );
insert into T1_vehicle value  (  5007  ,  1007  ,  '2006',  'PDK100251' , '1230456' , ' 1076540' ,  'BIKE' , NULL , '2' , 'HONDA'  , '001' , '507601'    , '1999' , 'hero passion pro'    );
insert into T1_vehicle value  (  5008  ,  1006  ,  '2005',  'PDK100251' , '1230456' , ' 1054321' ,  'BIKE' , NULL , '2' , 'HONDA'  , '001' , '500054301' , '1999' , 'Honda livo'          );
insert into T1_vehicle value  (  5009  ,  1009  ,  '2008',  'PDK100251' , '1230456' , ' 1043210' ,  'BIKE' , NULL , '2' , 'HONDA'  , '001' , '500345671' , '1999' , 'Honda unicorn'       );
insert into T1_vehicle value  (  5010  ,  1010  ,  '2009',  'PDK100251' , '1230456' , ' 101230'  ,  'BIKE' , NULL , '2' , 'HONDA'  , '001' , '50456701'  , '1999' , 'TVS rider 125'       );
insert into T1_vehicle value  (  5011  ,  1010  ,  '2009',  'PDK100251' , '1230456' , ' 103202 ' ,  'BIKE' , NULL , '2' , 'HONDA'  , '001' , '50456701'  , '1999' , 'Hero splendor plus'  );
insert into T1_vehicle value  (  5012  ,  1013  ,  '2012',  'PDK100251' , '1230456' , ' 1043200' ,  'BIKE' , NULL , '2' , 'HONDA'  , '001' , '57801'     , '1999' , 'jupitor'             );
insert into T1_vehicle value  (  5013  ,  1006  ,  '2005',  'PDK100251' , '1230456' , ' 100450 ' ,  'BIKE' , NULL , '2' , 'HONDA'  , '001' , '50078001'  , '1999' , 'activa '             );

-- policy_renewable

insert into T1_policy_renewable values ( 'GzuT8G'  , 'AG1001' , 'AP123456775', '2024-09-1' , 'instant' );
insert into T1_policy_renewable values ( 'fwravd'  , 'AG1002' , 'AP14356765' , '2024-09-2' , 'delay'   );
insert into T1_policy_renewable values ( 'awrvrv'  , 'AG1003' , 'AP1235456'  , '2024-09-3' , 'instant' );
insert into T1_policy_renewable values ( 'tebear'  , 'AG1004' , 'AP123547'   , '2024-09-4' , 'instant' );
insert into T1_policy_renewable values ( 'myudrtg' , 'AG1005' , 'AP1234548'  , '2024-09-5' , 'instant' );

-- coverage

insert into T1_coverage values ('myudrtg' , 'BAJAJ INSURANCE' , 100000 , 'Personal'   , 'bronze' ,'100', null, null );
insert into T1_coverage values ('rtbdsdf' , 'AEGON INSURANCE' , 200000 , 'bike'       , 'bronze' ,'101', null, null );
insert into T1_coverage values ('xnordf'  , 'AVIVA INSURANCE' , 300000 , 'disability' , 'silver' ,'102', null, null );
insert into T1_coverage values ('iohiser' , 'EDELWEISS TOKIO' , 400000 , 'longterm'   , 'gold'   ,'103', null, null );

-- insurance_policy_coverage

insert into T1_INSURANCE_POLICY_COVERAGE values ('AG1001',  'myudrtg', 'AP123456775' , 'BAJAJ INSURANCE' );
insert into T1_INSURANCE_POLICY_COVERAGE values ('AG1002',  'rtbdsdf', 'AP14356765'  , 'AEGON INSURANCE' );
insert into T1_INSURANCE_POLICY_COVERAGE values ('AG1004',  'iohiser', 'AP123547'    , 'EDELWEISS TOKIO' );

-- Query-1

SELECT t1_customer.CUST_ID, t1_customer.CUST_FNAME, t1_customer.CUST_LNAME, t1_customer.CUSTOMER_ADDRESS,
t1_customer.CUST_EMAIL, t1_customer.CUST_MOB_NUMBER, t1_vehicle.VEHICLE_ID, 
t1_vehicle.VEHICLE_REGISTRATION_NUMBER, t1_vehicle.VEHICLE_TYPE, 
t1_incident_report.INCIDENT_REPORT_ID, t1_claim.CLAIM_STATUS FROM T1_CLAIM 
INNER JOIN T1_INCIDENT_REPORT ON T1_CLAIM.INCIDENT_REPORT_ID=T1_INCIDENT_REPORT.INCIDENT_REPORT_ID 
INNER JOIN T1_CUSTOMER ON T1_INCIDENT_REPORT.CUST_ID=T1_CUSTOMER.CUST_ID 
INNER JOIN T1_VEHICLE ON T1_CUSTOMER.CUST_ID=T1_VEHICLE.CUST_ID WHERE T1_CLAIM.CLAIM_STATUS='Pending';

-- Query-2

SELECT SUM(t1_customer.CUST_ID) AS SUM_CUST_ID, t1_customer.CUST_ID,
t1_customer.CUST_FNAME, t1_customer.CUST_LNAME, t1_customer.CUSTOMER_ADDRESS, 
t1_customer.CUST_EMAIL, t1_customer.CUST_MOB_NUMBER, t1_premium_payment.PREMIUM_PAYMENT_AMOUNT 
FROM t1_premium_payment RIGHT JOIN t1_customer ON t1_premium_payment.CUST_ID =t1_customer.CUST_ID 
GROUP BY t1_customer.CUST_ID HAVING SUM(t1_premium_payment.PREMIUM_PAYMENT_AMOUNT)>SUM_CUST_ID;

-- Query-3

SELECT * FROM t1_INSURANCE_COMPANY
WHERE Company_Name IN 
(SELECT t1_DEPARTMENT.Company_Name 
FROM t1_PRODUCT INNER JOIN t1_DEPARTMENT ON t1_DEPARTMENT.Company_Name = t1_PRODUCT.Company_Name
GROUP BY t1_DEPARTMENT.Company_Name
HAVING COUNT(DISTINCT (Product_Number)) > COUNT(DISTINCT (Department_Name)));

-- Query-4

select * from t1_customer 
inner join t1_vehicle on t1_customer.cust_id = t1_vehicle.cust_id  
inner join t1_premium_payment on t1_vehicle.policy_number = t1_premium_payment.policy_number
inner join t1_incident_report on t1_incident_report.policy_number = t1_premium_payment.policy_number group by (t1_vehicle.CUST_ID) having count(t1_vehicle.CUST_ID) > 1 and t1_premium_payment.CUST_ID  is null ;

-- Query-5

SELECT t1_vehicle.VEHICLE_ID, 
t1_vehicle.VEHICLE_REGISTRATION_NUMBER, t1_vehicle.VEHICLE_TYPE , t1_vehicle.VEHICLE_NUMBER , t1_premium_payment.PREMIUM_PAYMENT_AMOUNT
FROM t1_VEHICLE
INNER JOIN t1_premium_payment
ON t1_premium_payment.CUST_ID = t1_vehicle.CUST_ID 
WHERE PREMIUM_PAYMENT_AMOUNT > VEHICLE_NUMBER;

-- Query-6
SELECT t1_customer.CUST_ID, t1_customer.CUST_FNAME, t1_customer.CUST_LNAME, t1_customer.CUST_EMAIL,
t1_customer.CUST_MOB_NUMBER, t1_claim.CLAIM_ID, t1_claim_settlement.CLAIM_SETTLEMENT_ID,
t1_vehicle.VEHICLE_ID, t1_coverage.COVERAGE_AMOUNT, t1_claim.CLAIM_AMOUNT
FROM t1_customer JOIN t1_incident_report ON t1_customer.CUST_ID=t1_incident_report.CUST_ID 
JOIN t1_claim ON t1_incident_report.INCIDENT_REPORT_ID=t1_claim.INCIDENT_REPORT_ID
JOIN t1_claim_settlement ON t1_claim.CLAIM_ID=t1_claim_settlement.CLAIM_ID 
JOIN t1_vehicle ON t1_vehicle.CUST_ID=t1_customer.CUST_ID
JOIN t1_application ON t1_customer.CUST_ID=t1_application.CUST_ID
JOIN t1_insurance_policy ON t1_application.APPLICATION_ID=t1_insurance_policy.APPLICATION_ID
JOIN t1_insurance_policy_coverage ON (t1_insurance_policy.AGREEMENT_ID,t1_insurance_policy.APPLICATION_ID)=(t1_insurance_policy_coverage.AGREEMENT_ID,t1_insurance_policy_coverage.APPLICATION_ID)
JOIN t1_coverage ON t1_insurance_policy_coverage.COVERAGE_ID=t1_coverage.COVERAGE_ID
WHERE (t1_coverage.COVERAGE_AMOUNT > t1_claim.CLAIM_AMOUNT) AND (t1_claim.CLAIM_AMOUNT > (t1_claim_settlement.CLAIM_SETTLEMENT_ID + t1_vehicle.VEHICLE_ID + t1_claim.CLAIM_ID + t1_customer.CUST_ID));
