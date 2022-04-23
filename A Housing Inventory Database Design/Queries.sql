/*1-list all the homeless names along with the duration they spent it in the homeless order in ascending order based on the duration:*/

SELECT HL_ID AS 'ID' , CONCAT_WS(' ', HL_Fname,HL_Lname) AS 'Homeless\'s Name',  DATEDIFF(HL_date_of_Record ,when_became_homeless) AS 'Duration','Days'
FROM homeless
ORDER BY DATEDIFF(HL_date_of_Record ,when_became_homeless) ASC;


/*2-show me the total number of homeless people within each tract:*/

SELECT 'There are ', Count(HL_ID) AS HomelessNumber,' homeless people in tract :',censustract.tract_number AS 'Tract Number'
FROM censustract
RIGHT JOIN homeless ON homeless.tract_number= censustract.tract_number
GROUP BY homeless.tract_number, censustract.tract_number;

/*3-list me all the single-family building latest rentals along with the homeless who his/her monthly income higher than the latest rental and then show the difference if he/she rented the building:*/

SELECT CONCAT_WS(' ', HL_Fname,HL_Lname) AS 'Homeless\'s Name',monthly_income AS 'Monthly Income',new_rent AS 'Latest Rental ',SFR_date_of_record AS 'Date of Rental Record','How much Left if he/she rented :', (monthly_income - new_rent) AS 'Left' 
FROM ((censustract RIGHT JOIN Homeless ON homeless.tract_number= censustract.tract_number)
INNER JOIN singlefamilyfacility ON censustract.tract_number = singlefamilyfacility.tract_number )
INNER JOIN single_family_records ON singlefamilyfacility.Single_Building_ID = single_family_records.Single_Building_ID 
WHERE monthly_income>= new_rent;




/*4-compare between how many times the single-family buildings were occupied and when they were vacant :*/

SELECT DISTINCT (SELECT Count(*) FROM single_family_records WHERE occupancy ='O') AS Occupied ,  (SELECT Count(*) FROM single_family_records WHERE occupancy ='V') AS Vacant, Count(*) AS 'Total Number of Records'
FROM single_family_records;

/*5-Display only the buildings that have been repaired and in the same time show if there is a changed happened to the rental as well as show what has been repaired:*/

SELECT singlefamilyfacility.Single_Building_ID AS 'Building ID', old_rent AS 'OLD Rental',new_rent AS 'New Rental',(new_rent -old_rent) AS 'Difference in Rental',SFR_date_of_record AS 'Date of rental record', data_of_repairing AS 'Date of repairing',repairing_cost AS 'Repairing Cost',what_was_repaired AS Repaired
FROM (singlefamilyfacility INNER JOIN single_family_records ON singlefamilyfacility.Single_Building_ID = single_family_records.Single_Building_ID)
INNER JOIN repairs_records ON singlefamilyfacility.Single_Building_ID = repairs_records.Single_Building_ID
WHERE month(SFR_date_of_record) = month(data_of_repairing)  ;

/*6- show the percentage of homeless people to the population in their tract: */
SELECT  censustract.tract_number AS 'Tract Number',Count(HL_ID) AS 'Homeless Number', population,(Count(HL_ID)  / population) *100 AS 'Homeless Percentage','%'
FROM censustract
RIGHT JOIN homeless ON homeless.tract_number= censustract.tract_number
GROUP BY homeless.tract_number, censustract.tract_number;


/*7-Display the highest repairing cost beside the highest single family building among all the years :*/
SELECT RE_REC.Single_Building_ID AS 'Building ID',MAX(repairing_cost) AS 'Highest Repairing Cost',what_was_repaired AS 'Repaired' ,single_family_records.Single_Building_ID AS 'Building ID', GREATEST(MAX(new_rent),MAX(old_rent)) AS 'Highest Rental'
FROM (singlefamilyfacility INNER JOIN single_family_records ON singlefamilyfacility.Single_Building_ID = single_family_records.Single_Building_ID)
INNER JOIN repairs_records RE_REC ON singlefamilyfacility.Single_Building_ID =  RE_REC.Single_Building_ID;


/*8-List all homeless with their monthly income*/

SELECT CONCAT_WS(' ', HL_Fname,HL_Lname) AS 'Homeless\'s Name',monthly_income AS 'Monthly Income'
FROM homeless;

/*9-Show the average homelessness duration for all homelessness*/
SELECT AVG(DATEDIFF(HL_date_of_Record ,when_became_homeless)) AS 'Average Homelessness Duration For all Homelessness','Days'
FROM homeless;

/*10-List all the records based on the new rent from highest rent to lowest rent*/

SELECT Single_Building_ID AS 'Building ID',new_rent AS 'Last Updated Rent', SFR_date_of_record AS 'Date of Record'
FROM single_family_records
ORDER BY new_rent DESC;

/*11-List only the repairing records that has been done on the wall.*/
SELECT Single_Building_ID, what_was_repaired
FROM  repairs_records
WHERE what_was_repaired LIKE '%wall%';