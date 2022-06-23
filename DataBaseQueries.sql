CREATE DATABASE Company;
USE Company;
-------Create Tables--------
CREATE TABLE Employee(
ID INT IDENTITY PRIMARY KEY,
Name VARCHAR(30) NOT NULL,
Contact VARCHAR(30) NOT NULL,
StartYear VARCHAR(10) NOT NULL);
SELECT * FROM Employee;

CREATE TABLE Department(
ID int NOT NULL,
DeptName VARCHAR(30) NOT NULL,
SubDivision VARCHAR(30) NOT NULL,
);
SELECT * FROM Department;
-------Insert Data into Tables--------
INSERT INTO Employee(Name,Contact,StartYear) VALUES
('Reshma','9087561231','2017'),
('Basith','6005526294','2018'),
('Tanvir','6776543212','2020'),
('Khajabi','7776543212','2013'),
('Dastagiri','9876543212','2020');
SELECT * FROM Employee;

INSERT INTO Department(ID,DeptName,SubDivision) VALUES
('4','Finance','Manager'),
('2','Software','SeniorAssistant'),
('3','Management','Director'),
('1','Software','WebDesigner'),
('3','Management','Administrator');
SELECT * FROM Department;

-------Insert joins--------

-------Inner Join-------
SELECT EM.NAME, DT.DeptName
FROM Employee EM JOIN Department DT
ON EM.ID = DT.ID;

-------Left Join-------
SELECT EM.NAME, DT.DeptName
FROM Employee EM LEFT JOIN Department DT
ON EM.ID = DT.ID;

-------Right Join-------
SELECT EM.NAME, DT.DeptName
FROM Employee EM RIGHT JOIN Department DT
ON EM.ID = DT.ID;

-------Full Join-------
SELECT EM.NAME, DT.DeptName
FROM Employee EM FULL JOIN Department DT
ON EM.ID = DT.ID;

-------Cross Join-------
SELECT EM.NAME, DT.DeptName
FROM Employee EM CROSS JOIN Department DT

SELECT * FROM Employee;
SELECT * FROM Department;

-------Indexes-------
CREATE INDEX idx_Name ON Employee (Name);
INSERT INTO Employee(Name,Contact,StartYear) VALUES('Vahidha','8884561231','2015');
CREATE UNIQUE INDEX idx_SubDivision ON Department (SubDivision);
INSERT INTO Department(ID,DeptName,SubDivision) VALUES ('4','Finance','Manager')

-------Sub Query-------
SELECT DeptName, SubDivision FROM Department WHERE DeptName IN ('Software');
SELECT DeptName, SubDivision FROM Department WHERE DeptName NOT IN ('Software');
SELECT * FROM Employee WHERE StartYear=(SELECT MAX(StartYear) FROM Employee);

-------View-------
CREATE VIEW Dept_View AS SELECT DeptName, SubDivision FROM Department;
SELECT * FROM Dept_View;

CREATE VIEW Department_View AS SELECT DeptName, SubDivision FROM Department WHERE DeptName = 'Software';
SELECT * FROM Department_View;

--------Stored Procedures---------

CREATE PROCEDURE SP_DeptTables (@ID int,@DeptName varchar(30),@SubDivision varchar(30))
AS
BEGIN
SET NOCOUNT ON; 
INSERT INTO Department([ID],[DeptName],[SubDivision]) VALUES (@ID,@DeptName,@SubDivision)
END
GO

EXEC [dbo].[SP_DeptTables] @ID=2,@DeptName ='Sales',@SubDivision ='Marketing';
GO

SELECT * FROM Department;

--------One to One Relation--------
ALTER TABLE Department ADD CONSTRAINT FK_Employee FOREIGN KEY(ID) REFERENCES Employee(ID) ON DELETE CASCADE ON UPDATE CASCADE

SELECT SubDivision,COUNT(SubDivision) FROM Department DT INNER JOIN Employee EMP ON DT.ID = EMP.ID GROUP BY SubDivision


---------Functions---------
SELECT DeptName, COUNT(DeptName) AS Department FROM Department GROUP BY DeptName



---------Triggers---------
CREATE TABLE Employee_Backup (ID int, 
      Name VARCHAR(40), Contact VARCHAR(40), 
      StartYear VARCHAR(10), 
      primary key(ID));
delimiter $$
CREATE TRIGGER Backup BEFORE DELETE ON Employee 
FOR EACH ROW
BEGIN
INSERT INTO Employee_Backup
VALUES (OLD.ID, OLD.Name, 
        OLD.Contact, OLD.StartYear);
END; $$
delimiter; 