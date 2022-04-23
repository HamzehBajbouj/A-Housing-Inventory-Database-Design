CREATE DATABASE AlternativeAssessement;

USE AlternativeAssessement;

CREATE TABLE Manager(
   manger_ID INT AUTO_INCREMENT  NOT NULL PRIMARY KEY ,

   manger_Fname VARCHAR(15),
   manger_Lname VARCHAR(15),
   manger_phone_number DECIMAL(9,0),
   manger_ZIP VARCHAR(3),
   manger_city VARCHAR(30),
   manger_street VARCHAR(30)
);

CREATE TABLE Developer(
   Developer_ID INT AUTO_INCREMENT  NOT NULL PRIMARY KEY ,

   Developer_Lname VARCHAR(15),
   Developer_Fname VARCHAR(15),
   developer_phonenumber DECIMAL(9,0)
);

CREATE TABLE BuildingsOwners(
   owner_ID INT AUTO_INCREMENT  NOT NULL PRIMARY KEY ,

   Owner_Fname VARCHAR(15),
   Owner_Lname VARCHAR(15),
   owner_phone DECIMAL(9,0),
   Owner_ZIP VARCHAR(3),
   Owner_city VARCHAR(30),
   Owner_street VARCHAR(30)
);

CREATE TABLE CensusTract(
	tract_number INT AUTO_INCREMENT  NOT NULL PRIMARY KEY ,
	Developer_ID INT NOT NULL,
	median_household_income DECIMAL(8,0),
	income_per_capita DECIMAL(8,0),
	median_household_income_for_renters DECIMAL(8,0),
	per_capita_income_for_persons_in_group_quarters DECIMAL(8,0),
	median_gross_rent DECIMAL(8,0),
	median_gross_rent_as_a_percentage DECIMAL(4,0),
	population DECIMAL(8,0),

	FOREIGN KEY(Developer_ID) REFERENCES Developer(Developer_ID)
	
);

CREATE TABLE TractBorders(
	Border_Length DECIMAL(10,0),
	tract_number INT NOT NULL,
	Bordered_Tract INT NOT NULL,
	PRIMARY KEY (tract_number,Bordered_Tract),
	FOREIGN KEY(tract_number) REFERENCES CensusTract(tract_number),
	FOREIGN KEY(Bordered_Tract) REFERENCES CensusTract(tract_number)
);

CREATE TABLE SingleFamilyFacility(
	Single_Building_ID INT AUTO_INCREMENT  NOT NULL PRIMARY KEY ,
	Sng_ZIP VARCHAR(3),
	Sng_city  VARCHAR(30),
	Sng_street VARCHAR(30),
	facility_size DECIMAL(6,0),
	Sng_No_of_bedrooms DECIMAL(2,0),
	Sng_No_of_bathrooms DECIMAL(1,0),
	Sng_handicapped_accessibility ENUM('Y','N'),

	renovation ENUM('Y','N'),
	outdoor_space ENUM('Y','N'),

	
	tract_number INT NOT NULL,
	owner_ID INT NOT NULL,
	FOREIGN KEY(tract_number) REFERENCES CensusTract(tract_number),
	FOREIGN KEY(owner_ID) REFERENCES BuildingsOwners(owner_ID)
);

CREATE TABLE MultipleFamilyFacility(
	multiple_building_ID INT AUTO_INCREMENT  NOT NULL PRIMARY KEY ,
	Mul_Building_name VARCHAR(25),
	Mul_ZIP VARCHAR(3),
	Mul_city   VARCHAR(30),
	Mul_street VARCHAR(30),
	Number_of_units DECIMAL(3,0),
	Mul_handicapped_accessibility ENUM('Y','N'),
	Building_rating DECIMAL(2,1),

	
	tract_number INT NOT NULL,
	owner_ID INT NOT NULL,
	manger_ID INT NOT NULL,
	FOREIGN KEY(tract_number) REFERENCES CensusTract(tract_number),
	FOREIGN KEY(owner_ID) REFERENCES BuildingsOwners(owner_ID),
	FOREIGN KEY(manger_ID) REFERENCES Manager(manger_ID)
);

CREATE TABLE BuildingInspectionReport(
	Report_ID INT AUTO_INCREMENT  NOT NULL PRIMARY KEY ,
	Tenant_service ENUM('Y','N'),
	Heating_cooling_system ENUM('Y','N'),
	building_upkeep ENUM('Y','N'),
	pest_control ENUM('Y','N'),
	Report_date DATE,
	multiple_building_ID INT NOT NULL,
	FOREIGN KEY(multiple_building_ID) REFERENCES  MultipleFamilyFacility(multiple_building_ID)
);

CREATE TABLE Unit(
	Unit_ID INT AUTO_INCREMENT  NOT NULL PRIMARY KEY ,
	unit_size DECIMAL(4,0),
	cooking_availability ENUM('Y','N'),
	special_remarks VARCHAR(500),
	UNo_of_bedroom DECIMAL(2,0),
	UNo_of_bathroom DECIMAL(1,0),

	multiple_building_ID INT NOT NULL,
	FOREIGN KEY(multiple_building_ID) REFERENCES  MultipleFamilyFacility(multiple_building_ID)
);

CREATE TABLE UnitHistory(
	date_of_record DATE,
	Old_rent DECIMAL(12,2),
	New_rent DECIMAL(12,2),
	changes_in_conditions VARCHAR(1000)  DEFAULT 'No changes in conditions',
	Last_month_occupancy ENUM('O','V'),
	This_month_occupancy ENUM('O','V'),
	
	Unit_ID INT NOT NULL ,
	FOREIGN KEY(Unit_ID) REFERENCES Unit(Unit_ID)
);

/*THESE ARE THE NEW TABLES */
CREATE TABLE homeless(
	HL_ID INT AUTO_INCREMENT  NOT NULL PRIMARY KEY,
	HL_Fname VARCHAR(15),
	HL_Lname VARCHAR(15),
	when_became_homeless DATE,
	HL_date_of_Record DATE,
	reason VARCHAR(1000),
	monthly_income DECIMAL(12,2),
	
	tract_number INT NOT NULL,
	FOREIGN KEY(tract_number) REFERENCES CensusTract(tract_number)
);

CREATE TABLE single_family_records(
	old_rent DECIMAL(12,2),
	SFR_date_of_record DATE,
	new_rent DECIMAL(12,2),
	occupancy ENUM('O','V'),

	Single_Building_ID INT NOT NULL,
	FOREIGN KEY(Single_Building_ID) REFERENCES SingleFamilyFacility(Single_Building_ID)
);

CREATE TABLE Repairs_records(
	data_of_repairing DATE,
	repairing_duration DECIMAL(3,0),
	what_was_repaired VARCHAR(1000),
	repairing_cost DECIMAL(12,2),

	Single_Building_ID INT NOT NULL,
	FOREIGN KEY(Single_Building_ID) REFERENCES SingleFamilyFacility(Single_Building_ID)	
);

/*END OF CREATING THE NEW TABLES */

INSERT INTO developer (Developer_Fname,Developer_Lname,developer_phonenumber)
VALUES ('Hamzeh','Bajbouj',011645454),
	('Ali','Darjie',011432454),
	('Muhannd','Darwheh',013332454),
	('Al-baraa','Mhammeid',013322454),
	('Amjad','Baker',013324354),
	(' Zahareman','Salamon',032324354),
	('Renuga','Lourdenadin',011124354);

INSERT INTO Manager(manger_Fname, manger_Lname,manger_phone_number,manger_ZIP,manger_city,manger_street)
VALUES ('Zabrina','Saravanan',603803703,'QW3','PulauPinang','Lorong Bellamy'),
	('Mohammed','Mazwan',603803732,'Q23','Pulau Pinang','Jalan Lumba Kuda'),
	('John ','Hang',603333732,'QW3','Pulau Pinang','Jalan Kia Peng'),
	('Shaun ','Zet Hoo',603223732,'Q23','Labuan','Lorong '),
	('Nura ',' Syahira',603223444,'Q13','Kelantan Darul Naim','Jalan 56J'),
	('Violet ','Hoy Hee',603523444,'Q13','Melaka','G Bazar Keramat'),
	('Murni','Uda',603523555,'QW3','Pulau Pinang','Jalan Wisma Putra'),
	('Anaika ','Bhupalan',603635555,'QW3','Kuala Lumpur','Jalan 5/63B'),
	('Nur','Suhada',603635555,'Q43','Pahang','Jln 4/5P'),
	('Kiran','Saarvindran',603635532,'Q43','Terengganu',' Jln 8/16I');

INSERT INTO buildingsowners(Owner_Fname,Owner_Lname,owner_phone,Owner_ZIP,Owner_city,Owner_street)
VALUES ('Erika ','Zulhelmi ',603565235,'P34','Melaka','Jalan 9/31'),
	('Zabrina ','Subramaniam',604315235,'P34','Labuan','Lorong Bukit Bintang 1H'),
	('Tai ','Tean',604314235,'P32','Kuala Besut','Jln 4F'),
	('Mahathir ','Yosri',604314230,'P32','Mata Ayer','Jalan 6/99'),
	('Muhammed ',' Amir ',604544230,'P31','Selangor','Jalan Masjid 6/79Y'),
	('Noor','Farzana ',604544530,'P31','Terengganu ','Jln 7/35'),
	('Pushpa ',' Perera ',604544543,'P33','Selangor ','Jalan Alor 9/54'),
	('Shanti ',' Sanjay ',604543243,'P36','Putrajaya ','Jalan 7/79'),
	('Nura  ',' Masyitah  ',604541143,'P39','Penang ','Jln Kuala Kangsar 1/4D');

INSERT INTO censustract(Developer_ID,median_household_income,income_per_capita,median_household_income_for_renters,per_capita_income_for_persons_in_group_quarters,median_gross_rent,median_gross_rent_as_a_percentage,population)
VALUES ((SELECT Developer_ID FROM developer WHERE Developer_Fname ='Hamzeh' ),3405,7010,3240,3000,300,30,430),
	((SELECT Developer_ID FROM developer WHERE Developer_Fname ='Hamzeh' ),4300,6010,3410,3200,150,15,643),
	((SELECT Developer_ID FROM developer WHERE Developer_Fname ='Hamzeh' ),3030,4000,7000,7200,210,21,645),
	((SELECT Developer_ID FROM developer WHERE Developer_Fname ='Ali' ),3400,5510,6050,1000,400,40,1001),
	((SELECT Developer_ID FROM developer WHERE Developer_Fname ='Ali' ),3500,5000,4010,4200,700,70,1040),
	((SELECT Developer_ID FROM developer WHERE Developer_Fname ='Muhannd' ),2400,5000,2800,3200,1200,90,6043),
	((SELECT Developer_ID FROM developer WHERE Developer_Fname ='Al-baraa' ),6020,9303,4200,3213,210,30,4354),
	((SELECT Developer_ID FROM developer WHERE Developer_Fname ='Al-baraa' ),4020,6303,3800,2900,90,2,540),
	((SELECT Developer_ID FROM developer WHERE Developer_Fname ='Amjad' ),7000,10043,6010,9102,132,41,533),
	((SELECT Developer_ID FROM developer WHERE Developer_Fname ='Amjad' ),5340,11233,4500,9430,300,25,546),
	((SELECT Developer_ID FROM developer WHERE Developer_Fname ='Hamzeh' ),15000,23000,8900,10000,950,95,6564),
	((SELECT Developer_ID FROM developer WHERE Developer_Fname ='Renuga' ),12000,18000,9000,8400,1200,120,6549),
	((SELECT Developer_ID FROM developer WHERE Developer_Fname ='Renuga' ),5490,9300,5000,7599,210,21,3214),
	((SELECT Developer_ID FROM developer WHERE Developer_Fname ='Renuga' ),6030,7010,6500,6510,100,10,5433),
	((SELECT Developer_ID FROM developer WHERE Developer_Fname ='Renuga' ),7640,6300,4906,6132,220,22,6445),
	((SELECT Developer_ID FROM developer WHERE Developer_Fname ='Renuga' ),13120,16300,9000,12334,430,43,2321);

INSERT INTO tractborders(Border_Length,tract_number,Bordered_Tract)
VALUES (3241,(SELECT tract_number FROM censustract WHERE tract_number = 1),(SELECT tract_number FROM censustract WHERE tract_number = 7)),
	(433,(SELECT tract_number FROM censustract WHERE tract_number = 1),(SELECT tract_number FROM censustract WHERE tract_number = 3)),
	(2300,(SELECT tract_number FROM censustract WHERE tract_number = 1),(SELECT tract_number FROM censustract WHERE tract_number = 4)),
	(1020,(SELECT tract_number FROM censustract WHERE tract_number = 1),(SELECT tract_number FROM censustract WHERE tract_number = 2)),
	(1020,(SELECT tract_number FROM censustract WHERE tract_number = 2),(SELECT tract_number FROM censustract WHERE tract_number = 1)),
	(1320,(SELECT tract_number FROM censustract WHERE tract_number = 2),(SELECT tract_number FROM censustract WHERE tract_number = 3)),
	(2000,(SELECT tract_number FROM censustract WHERE tract_number = 2),(SELECT tract_number FROM censustract WHERE tract_number = 5)),
	(433,(SELECT tract_number FROM censustract WHERE tract_number = 3),(SELECT tract_number FROM censustract WHERE tract_number = 1)),
	(1320,(SELECT tract_number FROM censustract WHERE tract_number = 3),(SELECT tract_number FROM censustract WHERE tract_number = 2)),
	(1500,(SELECT tract_number FROM censustract WHERE tract_number = 3),(SELECT tract_number FROM censustract WHERE tract_number = 5)),
	(1433,(SELECT tract_number FROM censustract WHERE tract_number = 3),(SELECT tract_number FROM censustract WHERE tract_number = 6)),
	(2300,(SELECT tract_number FROM censustract WHERE tract_number = 4),(SELECT tract_number FROM censustract WHERE tract_number = 1)),
	(7900,(SELECT tract_number FROM censustract WHERE tract_number = 4),(SELECT tract_number FROM censustract WHERE tract_number = 8)),
	(2000,(SELECT tract_number FROM censustract WHERE tract_number = 5),(SELECT tract_number FROM censustract WHERE tract_number = 2)),
	(1500,(SELECT tract_number FROM censustract WHERE tract_number = 5),(SELECT tract_number FROM censustract WHERE tract_number = 3)),
	(4343,(SELECT tract_number FROM censustract WHERE tract_number = 5),(SELECT tract_number FROM censustract WHERE tract_number = 7)),
	(423,(SELECT tract_number FROM censustract WHERE tract_number = 5),(SELECT tract_number FROM censustract WHERE tract_number = 8)),
	(1433,(SELECT tract_number FROM censustract WHERE tract_number = 6),(SELECT tract_number FROM censustract WHERE tract_number = 3)),
	(400,(SELECT tract_number FROM censustract WHERE tract_number = 6),(SELECT tract_number FROM censustract WHERE tract_number = 8)),
	(4300,(SELECT tract_number FROM censustract WHERE tract_number = 6),(SELECT tract_number FROM censustract WHERE tract_number = 7)),
	(4343,(SELECT tract_number FROM censustract WHERE tract_number = 7),(SELECT tract_number FROM censustract WHERE tract_number = 5)),
	(4300,(SELECT tract_number FROM censustract WHERE tract_number = 7),(SELECT tract_number FROM censustract WHERE tract_number = 6)),
	(2052,(SELECT tract_number FROM censustract WHERE tract_number = 7),(SELECT tract_number FROM censustract WHERE tract_number = 9)),
	(3241,(SELECT tract_number FROM censustract WHERE tract_number = 7),(SELECT tract_number FROM censustract WHERE tract_number = 1)),
	(423,(SELECT tract_number FROM censustract WHERE tract_number = 8),(SELECT tract_number FROM censustract WHERE tract_number = 5)),
	(400,(SELECT tract_number FROM censustract WHERE tract_number = 8),(SELECT tract_number FROM censustract WHERE tract_number = 6)),
	(4300,(SELECT tract_number FROM censustract WHERE tract_number = 8),(SELECT tract_number FROM censustract WHERE tract_number = 9)),
	(10030,(SELECT tract_number FROM censustract WHERE tract_number = 8),(SELECT tract_number FROM censustract WHERE tract_number = 10)),
	(7900,(SELECT tract_number FROM censustract WHERE tract_number = 8),(SELECT tract_number FROM censustract WHERE tract_number = 4)),
	(1100,(SELECT tract_number FROM censustract WHERE tract_number = 8),(SELECT tract_number FROM censustract WHERE tract_number = 11)),
	(4300,(SELECT tract_number FROM censustract WHERE tract_number = 9),(SELECT tract_number FROM censustract WHERE tract_number = 8)),
	(2052,(SELECT tract_number FROM censustract WHERE tract_number = 9),(SELECT tract_number FROM censustract WHERE tract_number = 7)),
	(500,(SELECT tract_number FROM censustract WHERE tract_number = 9),(SELECT tract_number FROM censustract WHERE tract_number = 10)),
	(10030,(SELECT tract_number FROM censustract WHERE tract_number = 10),(SELECT tract_number FROM censustract WHERE tract_number = 8)),
	(500,(SELECT tract_number FROM censustract WHERE tract_number = 10),(SELECT tract_number FROM censustract WHERE tract_number = 9)),
	(11122,(SELECT tract_number FROM censustract WHERE tract_number = 10),(SELECT tract_number FROM censustract WHERE tract_number = 11)),
	(1100,(SELECT tract_number FROM censustract WHERE tract_number = 11),(SELECT tract_number FROM censustract WHERE tract_number = 8)),
	(11122,(SELECT tract_number FROM censustract WHERE tract_number = 11),(SELECT tract_number FROM censustract WHERE tract_number = 10)),
	(4305,(SELECT tract_number FROM censustract WHERE tract_number = 11),(SELECT tract_number FROM censustract WHERE tract_number = 12)),
	(343,(SELECT tract_number FROM censustract WHERE tract_number = 11),(SELECT tract_number FROM censustract WHERE tract_number = 13)),
	(22345,(SELECT tract_number FROM censustract WHERE tract_number = 11),(SELECT tract_number FROM censustract WHERE tract_number = 16)),
	(4305,(SELECT tract_number FROM censustract WHERE tract_number = 12),(SELECT tract_number FROM censustract WHERE tract_number = 11)),
	(4505,(SELECT tract_number FROM censustract WHERE tract_number = 13),(SELECT tract_number FROM censustract WHERE tract_number = 14)),
	(343,(SELECT tract_number FROM censustract WHERE tract_number = 13),(SELECT tract_number FROM censustract WHERE tract_number = 11)),
	(504,(SELECT tract_number FROM censustract WHERE tract_number = 13),(SELECT tract_number FROM censustract WHERE tract_number = 15)),
	(435,(SELECT tract_number FROM censustract WHERE tract_number = 13),(SELECT tract_number FROM censustract WHERE tract_number = 16)),
	(4505,(SELECT tract_number FROM censustract WHERE tract_number = 14),(SELECT tract_number FROM censustract WHERE tract_number = 13)),
	(504,(SELECT tract_number FROM censustract WHERE tract_number = 15),(SELECT tract_number FROM censustract WHERE tract_number = 13)),
	(435,(SELECT tract_number FROM censustract WHERE tract_number = 16),(SELECT tract_number FROM censustract WHERE tract_number = 13)),
	(22345,(SELECT tract_number FROM censustract WHERE tract_number = 16),(SELECT tract_number FROM censustract WHERE tract_number = 11));

INSERT INTO singlefamilyfacility(Sng_ZIP,Sng_city,Sng_street,facility_size,Sng_No_of_bedrooms,Sng_No_of_bathrooms,Sng_handicapped_accessibility, renovation,outdoor_space,tract_number,owner_ID)
VALUES ('G43' , 'Skudai', 'Jalan 32/2' ,530 ,7 ,3 , 'N' , 'Y' ,'Y',(SELECT  tract_number FROM censustract WHERE tract_number = 1),(SELECT owner_ID FROM buildingsowners WHERE Owner_Fname='Erika ')),
	('G43','Skudai','Jalan 32/2',420,8,4,'Y','N','Y',(SELECT  tract_number FROM censustract WHERE tract_number = 1),(SELECT owner_ID FROM buildingsowners WHERE Owner_Fname='Erika ')),
	('G43','Skudai','Jalan 32/2',150,3,2,'N','N','N',(SELECT  tract_number FROM censustract WHERE tract_number = 1),(SELECT owner_ID FROM buildingsowners WHERE Owner_Fname='Zabrina ')),
	('G43','Skudai','Jalan 31/3',200,4,2,'N','Y','N',(SELECT  tract_number FROM censustract WHERE tract_number = 1),(SELECT owner_ID FROM buildingsowners WHERE Owner_Fname='Zabrina ')),
	('F32','Skudai','Jalan 16/1',232,5,3,'N','Y','N',(SELECT  tract_number FROM censustract WHERE tract_number = 2),(SELECT owner_ID FROM buildingsowners WHERE Owner_Fname='Tai ')),
	('F32','Skudai','Jalan 16/1',340,6,4,'Y','N','Y',(SELECT  tract_number FROM censustract WHERE tract_number = 2),(SELECT owner_ID FROM buildingsowners WHERE Owner_Fname='Tai ')),
	('F43','Skudai','Jalan 45/5',400,7,4,'Y','Y','Y',(SELECT  tract_number FROM censustract WHERE tract_number = 3),(SELECT owner_ID FROM buildingsowners WHERE Owner_Fname='Tai ')),
	('C21','Skudai','Jalan 76/3',700,8,4,'Y','N','Y',(SELECT  tract_number FROM censustract WHERE tract_number = 4),(SELECT owner_ID FROM buildingsowners WHERE Owner_Fname='Mahathir ')),
	('C21','Skudai','Jalan 76/3',2800,15,7,'Y','Y','Y',(SELECT  tract_number FROM censustract WHERE tract_number = 4),(SELECT owner_ID FROM buildingsowners WHERE Owner_Fname='Mahathir ')),
	('C21','Skudai','Jalan 76/6',2100,10,5,'Y','N','Y',(SELECT  tract_number FROM censustract WHERE tract_number = 4),(SELECT owner_ID FROM buildingsowners WHERE Owner_Fname='Muhammed ')),
	('C21','Skudai','Jalan 76/4',3200,11,5,'Y','Y','Y',(SELECT  tract_number FROM censustract WHERE tract_number = 5),(SELECT owner_ID FROM buildingsowners WHERE Owner_Fname='Muhammed '));

INSERT INTO  multiplefamilyfacility(Mul_Building_name,Mul_ZIP,Mul_city,Mul_street, Number_of_units, Mul_handicapped_accessibility, Building_rating, tract_number,owner_ID,manger_ID)
VALUES ('Seaside','G43','Skudai','Jalan 32/2',4,'Y',4,(SELECT tract_number FROM censustract WHERE tract_number = 1),(SELECT owner_ID FROM buildingsowners WHERE Owner_Fname='Noor'),(SELECT manger_ID FROM Manager WHERE manger_Fname='Mohammed')),
	('The Old Police Station','G43','Skudai','Jalan 34/2',2,'Y',4.3,(SELECT tract_number FROM censustract WHERE tract_number = 1),(SELECT owner_ID FROM buildingsowners WHERE Owner_Fname='Erika '),(SELECT manger_ID FROM Manager WHERE manger_Fname='Mohammed')),
	('Green Gates','D23','Johor Buhru','Jalan 76/2',2,'Y',3,(SELECT tract_number FROM censustract WHERE tract_number = 6),(SELECT owner_ID FROM buildingsowners WHERE Owner_Fname='Pushpa '),(SELECT manger_ID FROM Manager WHERE manger_Fname='Zabrina')),
	('Walton Lodge','E21','Johor Buhru','Jalan 65/7',4,'Y',2.9,(SELECT tract_number FROM censustract WHERE tract_number = 7),(SELECT owner_ID FROM buildingsowners WHERE Owner_Fname='Shanti '),(SELECT manger_ID FROM Manager WHERE manger_Fname='Shaun ')),
	('Willowlands','K23','Johor Buhru','Jalan 65/7',2,'N',5,(SELECT tract_number FROM censustract WHERE tract_number = 8),(SELECT owner_ID FROM buildingsowners WHERE Owner_Fname='Nura  '),(SELECT manger_ID FROM Manager WHERE manger_Fname='Violet ')),
	('Willow Villa','S23','Johor Buhru','Jalan 65/7',3,'Y',4.5,(SELECT tract_number FROM censustract WHERE tract_number = 8),(SELECT owner_ID FROM buildingsowners WHERE Owner_Fname='Tai '),(SELECT manger_ID FROM Manager WHERE manger_Fname='Kiran')),
	('Lake View','S23','Johor Buhru','Jalan 65/7',4,'Y',3.8,(SELECT tract_number FROM censustract WHERE tract_number = 9),(SELECT owner_ID FROM buildingsowners WHERE Owner_Fname='Tai '),(SELECT manger_ID FROM Manager WHERE manger_Fname='Kiran')),
	('Lakeways','R23','Skudai','Jalan 23/1',2,'Y',4.6,(SELECT tract_number FROM censustract WHERE tract_number = 9),(SELECT owner_ID FROM buildingsowners WHERE Owner_Fname='Shanti '),(SELECT manger_ID FROM Manager WHERE manger_Fname='Anaika '));

INSERT INTO buildinginspectionreport(Tenant_service, Heating_cooling_system,building_upkeep,pest_control,Report_date,multiple_building_ID)
VALUES ('Y','N','N','Y','2010-4-13',(SELECT multiple_building_ID FROM multiplefamilyfacility WHERE Mul_Building_name= 'Seaside')),
	('Y','Y','Y','N','2010-5-13',(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE Mul_Building_name= 'Seaside')),
	('N','Y','N','Y','2010-4-8',(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE Mul_Building_name= 'The Old Police Station')),
	('Y','Y','Y','Y','2010-7-9',(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE Mul_Building_name= 'The Old Police Station')),
	('Y','N','Y','Y','2010-2-9',(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE Mul_Building_name= 'Green Gates')),
	('Y','Y','Y','N','2011-1-4',(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE Mul_Building_name= 'Green Gates')),
	('Y','N','N','N','2011-3-6',(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE Mul_Building_name= 'Walton Lodge')),
	('Y','Y','N','Y','2011-6-2',(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE Mul_Building_name= 'Walton Lodge')),
	('N','N','Y','Y','2011-6-2',(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE Mul_Building_name= 'Willowlands')),
	('Y','N','Y','Y','2011-7-15',(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE Mul_Building_name= 'Willowlands')),
	('Y','Y','Y','Y','2011-9-11',(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE Mul_Building_name= 'Willowlands')),
	('Y','Y','Y','N','2011-12-25',(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE Mul_Building_name= 'Willowlands')),
	('Y','N','Y','N','2012-3-25',(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE Mul_Building_name= 'Willow Villa')),
	('Y','N','Y','Y','2012-4-22',(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE Mul_Building_name= 'Willow Villa')),
	('N','Y','Y','Y','2012-7-16',(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE Mul_Building_name= 'Willow Villa')),
	('Y','Y','Y','Y','2012-4-26',(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE Mul_Building_name= 'Lake View')),
	('Y','N','Y','N','2013-2-13',(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE Mul_Building_name= 'Lake View')),
	('N','Y','Y','N','2014-5-12',(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE Mul_Building_name= 'Lake View')),
	('Y','Y','Y','N','2014-7-12',(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE Mul_Building_name= 'Lake View')),
	('N','N','N','N','2010-7-12',(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE Mul_Building_name= 'Lakeways')),
	('N','Y','Y','N','2012-6-12',(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE Mul_Building_name= 'Lakeways')),
	('N','N','Y','Y','2013-1-13',(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE Mul_Building_name= 'Lakeways')),
	('Y','Y','Y','Y','2014-7-12',(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE Mul_Building_name= 'Lakeways'));

INSERT INTO unit(unit_size,cooking_availability,special_remarks,UNo_of_bedroom, UNo_of_bathroom,multiple_building_ID)
VALUES (320,'Y','There are ACs provided as well waterheaters',4,2,(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE multiple_building_ID =1)),
	(320,'Y','There are ACs provided as well waterheaters',3,2,(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE multiple_building_ID =1)),
	(420,'Y','There are ACs provided as well waterheaters you also have a balcone',5,3,(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE multiple_building_ID =1)),
	(440,'Y','There are ACs provided as well waterheaters you also have a balcone',5,4,(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE multiple_building_ID =1)),

	(200,'Y','There are ACs provided',2,1,(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE multiple_building_ID =2)),
	(150,'N','waterheater are provided as well as roof fans',1,1,(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE multiple_building_ID =2)),
	(150,'N','waterheater are provided as well as roof fans',1,1,(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE multiple_building_ID =2)),

	(420,'Y','waterheater are provided as well as roof fans and there is a balcone',4,2,(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE multiple_building_ID =3)),
	(420,'Y','waterheater are provided as well as roof fans and there is a balcone',4,2,(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE multiple_building_ID =3)),

	(320,'Y',' roof fans are provided',4,2,(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE multiple_building_ID =4)),
	(320,'Y','roof fans are provided',4,2,(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE multiple_building_ID =4)),
	(210,'Y','roof fans are provided',3,1,(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE multiple_building_ID =4)),
	(210,'Y','roof fans are provided',3,1,(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE multiple_building_ID =4)),

	(310,'Y','No special remarks',3,2,(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE multiple_building_ID =5)),
	(310,'Y','No special remarks',3,2,(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE multiple_building_ID =5)),

	(460,'Y','roof fans are provided as well as ACs',4,2,(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE multiple_building_ID =6)),
	(460,'Y','roof fans are provided as well as ACs',5,3,(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE multiple_building_ID =6)),
	(460,'Y','roof fans are provided as well as ACs',5,3,(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE multiple_building_ID =6)),

	(270,'Y','Central ACs provided as well as there is  a balcone',3,2,(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE multiple_building_ID =7)),
	(270,'Y','Central ACs provided as well as there is  a balcone',3,1,(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE multiple_building_ID =7)),
	(340,'Y','Central ACs provided as well as there is  a balcone',4,2,(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE multiple_building_ID =7)),
	(340,'Y','Central ACs provided as well as there is  a balcone',4,2,(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE multiple_building_ID =7)),

	(120,'Y','No special remarks',2,1,(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE multiple_building_ID =8)),
	(130,'Y','No special remarks',2,1,(SELECT multiple_building_ID FROM multiplefamilyfacility  WHERE multiple_building_ID =8));


INSERT INTO unithistory(date_of_record,Old_rent,New_rent,changes_in_conditions,Last_month_occupancy,This_month_occupancy,Unit_ID)
VALUES ('2010-4-13',1200,1120,NULL,'V','O',(SELECT Unit_ID FROM unit WHERE Unit_ID=1)),
	('2010-5-13',1120,1120,NULL,'O','O',(SELECT Unit_ID FROM unit WHERE Unit_ID=1)),
	('2010-4-13',1300,1220,NULL,'O','O',(SELECT Unit_ID FROM unit WHERE Unit_ID=2)),
	('2010-5-13',1300,1220,NULL,'O','V',(SELECT Unit_ID FROM unit WHERE Unit_ID=2)),
	('2010-6-13',1300,1220,NULL,'O','O',(SELECT Unit_ID FROM unit WHERE Unit_ID=2)),
	('2010-4-13',1300,1000,NULL,'V','O',(SELECT Unit_ID FROM unit WHERE Unit_ID=3)),
	('2010-5-13',1000,1000,NULL,'O','O',(SELECT Unit_ID FROM unit WHERE Unit_ID=3)),
	('2010-6-13',1000,1200,NULL,'O','V',(SELECT Unit_ID FROM unit WHERE Unit_ID=3)),
	('2010-2-13',1000,1200,NULL,'O','V',(SELECT Unit_ID FROM unit WHERE Unit_ID=4)),
	('2011-2-13',1000,900,NULL,'V','O',(SELECT Unit_ID FROM unit WHERE Unit_ID=5)),
	('2011-3-1',1000,900,NULL,'V','O',(SELECT Unit_ID FROM unit WHERE Unit_ID=5)),
	('2011-3-1',900,900,NULL,'O','O',(SELECT Unit_ID FROM unit WHERE Unit_ID=6)),
	('2011-2-1',900,900,NULL,'O','O',(SELECT Unit_ID FROM unit WHERE Unit_ID=6)),
	('2011-2-1',900,900,'You cannot cook after 9 p.m','O','O',(SELECT Unit_ID FROM unit WHERE Unit_ID=7)),
	('2011-3-1',900,900,'You cannot cook after 9 p.m','O','O',(SELECT Unit_ID FROM unit WHERE Unit_ID=7)),
	('2011-7-1',1400,1400,NULL,'V','V',(SELECT Unit_ID FROM unit WHERE Unit_ID=8)),
	('2011-8-1',1400,1300,'You are not allowed to play music after 10 p.m','V','O',(SELECT Unit_ID FROM unit WHERE Unit_ID=8)),
	('2011-6-1',1400,1400,NULL,'V','V',(SELECT Unit_ID FROM unit WHERE Unit_ID=9)),
	('2011-6-1',1400,1400,NULL,'V','V',(SELECT Unit_ID FROM unit WHERE Unit_ID=9)),
	('2011-9-1',1200,1200,NULL,'O','O',(SELECT Unit_ID FROM unit WHERE Unit_ID=10)),
	('2011-10-1',1200,1200,'No visits after 10 p.m','O','O',(SELECT Unit_ID FROM unit WHERE Unit_ID=10)),
	('2011-9-1',1000,1200,'No visits after 10 p.m','O','V',(SELECT Unit_ID FROM unit WHERE Unit_ID=11)),
	('2011-10-1',1000,1000,'visits are allowed after 10 p.m','V','O',(SELECT Unit_ID FROM unit WHERE Unit_ID=11)),
	('2011-9-1',1200,1000,NULL,'V','O',(SELECT Unit_ID FROM unit WHERE Unit_ID=12));



/*This part is for inserting the data into the new tables*/
INSERT INTO homeless(HL_Fname ,HL_Lname,when_became_homeless,HL_date_of_Record,monthly_income,reason,tract_number )
VALUES ('Rowan','Collier','2010-5-12','2014-10-12',570,'Unemployment',(SELECT  tract_number FROM censustract WHERE tract_number = 1)),
	('Julien','Foley','2010-7-11','2014-10-13',340,'Unemployment',(SELECT  tract_number FROM censustract WHERE tract_number = 1)),
	('Helena','Williams','2012-7-17','2015-11-13',700,'Lack of Affordable Housing',(SELECT  tract_number FROM censustract WHERE tract_number = 2)),
	('Landen','Roy','2014-7-12','2015-11-13',680,'Lack of Trustworthy Relationships',(SELECT  tract_number FROM censustract WHERE tract_number = 2)),
	('Micaela','Kaufman','2012-7-12','2016-11-13',800,'Unemployment',(SELECT  tract_number FROM censustract WHERE tract_number = 2)),
	('Dylan','Fowler','2011-5-15','2014-11-13',600,'Unemployment',(SELECT  tract_number FROM censustract WHERE tract_number = 3)),
	('Claudia','Huerta','2014-4-17','2014-11-13',900,'Lack of Trustworthy Relationships',(SELECT  tract_number FROM censustract WHERE tract_number = 3)),
	('Turner','Oconnell','2011-5-20','2013-5-12',750,'Personal Hardship',(SELECT  tract_number FROM censustract WHERE tract_number = 4)),
	('June','Raymond','2012-8-23','2013-8-19',1050,'Working, but in Poverty',(SELECT  tract_number FROM censustract WHERE tract_number = 4)),
	('Urijah','Gill','2010-3-12','2015-8-19',1290,'Working, but in Poverty',(SELECT  tract_number FROM censustract WHERE tract_number = 5)),
	('Princess','Werner','2010-1-17','2016-8-19',890,'Working, but in Poverty',(SELECT  tract_number FROM censustract WHERE tract_number = 6)),
	('Jaylynn','Hodge','2012-5-6','2013-8-19',690,'Lack of Trustworthy Relationships',(SELECT  tract_number FROM censustract WHERE tract_number = 6));

INSERT INTO single_family_records(old_rent,new_rent,occupancy,SFR_date_of_record,Single_Building_ID)
VALUES (1200,1200,'O','2012-6-12',(SELECT Single_Building_ID FROM SingleFamilyFacility WHERE Single_Building_ID = 1)),
	(1200,1300,'V','2012-7-12',(SELECT Single_Building_ID FROM SingleFamilyFacility WHERE Single_Building_ID = 1)),
	(1300,1300,'O','2012-8-12',(SELECT Single_Building_ID FROM SingleFamilyFacility WHERE Single_Building_ID = 1)),
	(1000,1000,'O','2012-9-12',(SELECT Single_Building_ID FROM SingleFamilyFacility WHERE Single_Building_ID = 2)),
	(1000,1000,'O','2012-10-12',(SELECT Single_Building_ID FROM SingleFamilyFacility WHERE Single_Building_ID = 2)),
	(1200,1000,'O','2011-5-12',(SELECT Single_Building_ID FROM SingleFamilyFacility WHERE Single_Building_ID = 3)),
	(1000,1200,'V','2011-6-12',(SELECT Single_Building_ID FROM SingleFamilyFacility WHERE Single_Building_ID = 3)),
	(1200,1200,'V','2011-7-12',(SELECT Single_Building_ID FROM SingleFamilyFacility WHERE Single_Building_ID = 3)),
	(1300,1300,'O','2013-8-12',(SELECT Single_Building_ID FROM SingleFamilyFacility WHERE Single_Building_ID = 4)),
	(1300,1300,'O','2013-9-12',(SELECT Single_Building_ID FROM SingleFamilyFacility WHERE Single_Building_ID = 4)),
	(1300,1000,'O','2014-2-12',(SELECT Single_Building_ID FROM SingleFamilyFacility WHERE Single_Building_ID = 4)),
	(1200,800,'O','2014-2-8',(SELECT Single_Building_ID FROM SingleFamilyFacility WHERE Single_Building_ID = 5)),
	(800,800,'O','2014-3-8',(SELECT Single_Building_ID FROM SingleFamilyFacility WHERE Single_Building_ID = 5)),
	(800,850,'O','2014-4-8',(SELECT Single_Building_ID FROM SingleFamilyFacility WHERE Single_Building_ID = 5)),
	(1020,1000,'O','2015-2-11',(SELECT Single_Building_ID FROM SingleFamilyFacility WHERE Single_Building_ID = 6)),
	(1000,1000,'V','2015-3-11',(SELECT Single_Building_ID FROM SingleFamilyFacility WHERE Single_Building_ID = 6)),
	(1000,1000,'V','2014-7-2',(SELECT Single_Building_ID FROM SingleFamilyFacility WHERE Single_Building_ID = 7)),
	(1000,1000,'O','2014-8-4',(SELECT Single_Building_ID FROM SingleFamilyFacility WHERE Single_Building_ID = 7)),
	(1000,1000,'O','2012-8-4',(SELECT Single_Building_ID FROM SingleFamilyFacility WHERE Single_Building_ID = 8)),
	(1000,1200,'V','2014-9-4',(SELECT Single_Building_ID FROM SingleFamilyFacility WHERE Single_Building_ID = 9));

INSERT INTO Repairs_records(data_of_repairing,repairing_duration,what_was_repaired,repairing_cost,Single_Building_ID)
VALUES ('2012-6-12',5,'repainting the walls',2000,(SELECT Single_Building_ID FROM SingleFamilyFacility WHERE Single_Building_ID = 1)),
	('2014-8-16',3,'repainting the walls',1400,(SELECT Single_Building_ID FROM SingleFamilyFacility WHERE Single_Building_ID = 2)),
	('2013-5-2',7,'Building a new room',7000,(SELECT Single_Building_ID FROM SingleFamilyFacility WHERE Single_Building_ID = 3)),
	('2014-3-11',1,'Fixing the electricity',500,(SELECT Single_Building_ID FROM SingleFamilyFacility WHERE Single_Building_ID = 4)),
	('2014-7-6',3,'Fixing the roof',1200,(SELECT Single_Building_ID FROM SingleFamilyFacility WHERE Single_Building_ID = 4)),
	('2015-1-6',4,'repainting the walls',1790,(SELECT Single_Building_ID FROM SingleFamilyFacility WHERE Single_Building_ID = 5));