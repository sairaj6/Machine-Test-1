

Create Table Employee_NIS1026
(	EmployeeId Int Primary Key Identity,
	EmpName Nvarchar(30),
	Phone Nvarchar(10),
	Email Nvarchar(30)
)

Insert into Employee_NIS1026 values('Prajyot','123456789','prayjot@gmail.com'),
									('Ajinkya','234567891','ajinkya@gmail.com'),
									('Pratik','345678912','pratik@gmail.com'),                           
									('Dipak','456789123','dipak@gmail.com')

Create Table Manufacturer_NIS1026
(   MfName Nvarchar(30) 
	Primary key,  
	City Nvarchar(30), 
	State Nvarchar(30)
)

Insert Into Manufacturer_NIS1026 Values ('Lenovo','Mumbai','Maharashtra'),                                        
										('Asus','Trivendrum','Kerla'),
										('Hp','Pune','Maharashtra'),
										('DELL','Chennai','TamilNadu')


Create Table Computer_NIS1026
(   SerialNumber int primary key Identity,  
	MfName Nvarchar(30)        
		Constraint fk_mfg_comp       
		Foreign key (MfName)        
		References Manufacturer_NIS1026(MfName)        
		On Delete cascade,  
	Model Nvarchar(10), 
	Weight Decimal(3,2), 
	EmployeeId Int       
		Constraint fk_emp_comp  
		Foreign Key (EmployeeId)   
		References Employee_NIS1026(EmployeeId)  
		On Delete Cascade
)
Insert Into Computer_NIS1026 values ('Hp','Elite Book',1.90,1),                                    
									('Lenovo','ThinkPad',1.45,2),                                
									('Asus','ROG',1.30,3),
									('DELL','G5',2.50,4)

                           
									

/*
1. List the manufacturers’ names that are located in South Dakota.
*/
SELECT MfName FROM  Manufacturer_NIS1026 WHERE State LIKE 'MAHARASHTRA'

/*
2. Calculate the average weight of the computers in use.
*/
SELECT AVG(Weight) AVERAGE_WEIGHT FROM Computer_NIS1026;


/*
3. List the employee names for employees whose area_code starts with 2
*/
ALTER TABLE Employee_NIS1026 ADD AreaCode NVARCHAR(10);

UPDATE Employee_NIS1026 SET AreaCode = '123abc' WHERE EmployeeId = 1;
UPDATE Employee_NIS1026 SET AreaCode = 'abc123' WHERE EmployeeId = 2;
UPDATE Employee_NIS1026 SET AreaCode = '231pqr' WHERE EmployeeId = 3;
UPDATE Employee_NIS1026 SET AreaCode = 'pqr231' WHERE EmployeeId = 4;

SELECT EmpName, AreaCode FROM Employee_NIS1026
WHERE AreaCode LIKE '2%';


/*
4. List the serial numbers for computers that have a weight below
average.
*/
SELECT SerialNumber FROM Computer_NIS1026 WHERE Weight <(SELECT AVG(WEIGHT) FROM Computer_NIS1026);

/*
5. List the manufacturer names of companies that do not have any
computers in use. Use a subquery.
*/

SELECT * FROM Manufacturer_NIS1026
WHERE MfName LIKE 
(SELECT MfName FROM Computer_NIS1026 WHERE EmployeeID IS NULL)


/*
6. Create a VIEW with the list of employee name, their computer serial
number, and the city that they were manufactured in. Use a join.
*/
 CREATE VIEW vw_empname_NIS1026
  AS
    SELECT c.SerialNumber, e.EmpName, m.City
    FROM Employee_NIS1026 e
    INNER JOIN Computer_NIS1026 c
    ON e.EmployeeID=c.EmployeeID
    INNER JOIN Manufacturer_NIS1026 m
    ON c.MfName=m.MfName;

SELECT * FROM vw_empname_NIS1026;


/*
7. Write a Stored Procedure to accept EmployeeId as parameter and
List the serial number, manufacturer name, model, and weight of
computer that belong to the specified Employeeid.
*/
CREATE PROCEDURE sp_CompDetails_NIS1026
@EmployeeID INT
AS
BEGIN
    SELECT SerialNumber, MfName, Model, Weight
    FROM Computer_NIS1026
	WHERE EmployeeId = @EmployeeID

END
  
  EXEC sp_CompDetails_NIS1026 4;
									



